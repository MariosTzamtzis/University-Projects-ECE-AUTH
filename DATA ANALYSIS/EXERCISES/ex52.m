clc;
close all;
clear;

M = 1000;
alpha = 0.05;
n = 20;
L = 1000;
prompt1 = 'Select r:\n';
r = input(prompt1);
muX = 0;
muY = 0;
mu = [muX muY];
stdX = 1;
stdY = 1;
sigma = [stdX^2 r; r stdY^2];
X = zeros(n, M);
Y = zeros(n, M);
R = zeros(L+1, M);

for i=1:M
    data = mvnrnd(mu, sigma, n);
    X(:, i) = data(:,1);
    Y(:, i) = data(:,2);
end

prompt2 = 'Select 2 for square X, Y: \n';
choice = input(prompt2);
if choice == 2
    X = X.^2;
    Y = Y.^2;
    fprintf("X^2 & Y^2:\n")
end

% Hypothesis test H0: r = 0 using non-parametric test
for i=1:M
    temp = corrcoef(X(:, i), Y(:, i));
    R(1, i) = temp(1,2);
    for j=1:L
        tempRAND = corrcoef(X(randperm(n), i), Y(:,i));
        R(j+1, i) = tempRAND(1,2);
    end
end

t = R .* sqrt((n-2)./(1-R.^2));
t_sorted = sort(t(2:L+1,:),1);

% low and upper limit
lowlim = round((alpha/2)*L);
upplim = round((1-alpha/2)*L);
tlow = t_sorted(lowlim, :);
tupp = t_sorted(upplim, :);
rej = sum(t(1,:) - tlow < 0 | t(1,:) - tupp > 0);
fprintf("Percentage of rejections of the null hypothesis %.4f%%.\n", rej/M*100);

% Hypothesis test H0: r = 0 using t-statistic
tc = tinv(1-alpha/2, n-2);
accept = sum(abs(t(1,:))<tc);
fprintf("Percentage of rejections of the null hypothesis using t-statistics %.4f%%.\n", (M-accept)*100/M);

