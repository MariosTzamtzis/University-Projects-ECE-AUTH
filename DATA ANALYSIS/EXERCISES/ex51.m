clc;
close all;
clear;

M = 1000;
alpha = 0.05;

%displays the text in prompt and waits for the user to input a value and press the Return key
prompt1 = 'Select n:\n';
n = input(prompt1);
prompt2 = 'Select r:\n';
r = input(prompt2);

muX = 0;
muY = 0;
mu = [muX muY];
stdX = 1;
stdY = 1;
sigma = [stdX^2 r; r stdY^2];

X = zeros(n, M);
Y = zeros(n, M);

for i=1:M
    data = mvnrnd(mu, sigma, n);
    X(:, i) = data(:,1);
    Y(:, i) = data(:,2);
end

% d : Z = X^2
prompt3 = 'Select 2 for question d: \n';
choice = input(prompt3);
if choice == 2
    X = X.^2;
    Y = Y.^2;
end

% a : 95% confidence interval of correlation coefficient using Fisher transform
R = zeros(M, 1);
RL = zeros(M, 1);
RU = zeros(M, 1);

% returns coefficients between two random variables Χ and Υ. 
%includes also matrices containing lower and upper bounds for a 95% confidence interval for each coefficient.
for i = 1:M
    [temp_R, ~, temp_RL, temp_RU] = corrcoef(X(:,i), Y(:,i), 'Alpha', alpha);
    R(i) = temp_R(1,2);
    RL(i) = temp_RL(1,2);
    RU(i) = temp_RU(1,2);
end

figure();
subplot(2,1,1);
histogram(RL);
title('Histogram of lower limit using Fisher Transformation');
subplot(2,1,2);
histogram(RU);
title('Histogram of upper limit using Fisher Transformation');

Z = 0.5*log((1+R)./(1-R));
z = norminv(1-alpha/2);
zstd = sqrt(1/(n-3));
ZL = Z - z*zstd;
ZU = Z + z*zstd;
RL_z = (exp(2*ZL)-1)./(exp(2*ZL)+1);
RU_z = (exp(2*ZU)-1)./(exp(2*ZU)+1);

perc = 0;
for i=1:M
    if RL_z(i)<r && r<RU_z(i)
        perc = perc + 1;
    end
end

fprintf("\nUsing Fisher Transformation, CI included r: %.3f%% times.\n", perc/M*100);

t = R .* sqrt((n-2)./(1-R.^2));
tc = tinv(1-alpha/2, n-2);
accept = sum(abs(t)<tc);
fprintf("Η0: r = 0 rejected: %.3f%% times.\n", (M-accept)*100/M);
