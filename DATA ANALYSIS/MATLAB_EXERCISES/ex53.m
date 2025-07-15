clc;
clear;
close all;

rain = importdata("rainThes59_97.dat");
temp = importdata("tempThes59_97.dat");
[y, m] = size(rain);        % y : years, number of observations per sample
                            % m : months, number of samples
L = 1000;                   % number of random permutations per sample
alpha = 0.05;
R = zeros(L+1, m);

for i = 1:m
    tmp_R = corrcoef(rain(:,i), temp(:,i));
    R(1,i) = tmp_R(1,2);
    % Hypothesis test H0: r = 0 using non-parametric test
    for j = 1:L
        tmp_R = corrcoef(rain(:,i), temp(randperm(y),i));%randperm returns a row vector containing a random permutation of the integers from 1 to y without repeating elements.
        R(j+1,i) = tmp_R(1,2);
    end
end

t = R .* sqrt((y-2) ./ (1-R.^2));
t_sorted = sort(t(2:L+1,:),1);
% low and upper limit
lowlim = round((alpha/2)*L);
upplim = round((1-alpha/2)*L);
tlow = t_sorted(lowlim, :);
tupp = t_sorted(upplim, :);
rej = sum(t(1,:) - tlow < 0 | t(1,:) - tupp > 0);
fprintf("Percentage of rejections of the null hypothesis %.4f%%.\n", rej/m*100);

% Hypothesis test H0: r = 0 using t-statistic
tc = tinv(1-alpha/2, y-2);
accept = sum(abs(t(1,:))<tc);
fprintf("Percentage of rejections of the null hypothesis using t-statistics %.4f%%.\n", (m-accept)*100/m);

% Print stats per month
for i = 1:m
    fprintf("--------- Month %d ---------\n", i);
    % Non-parametric
    fprintf("Non-parametric: t = %.3f, ci = [%.3f, %.3f] ", t(1,i), tlow(1,i), tupp(1,i));
    % Parametric
    fprintf("Parametric: t = %.3f, tinv = %.3f ", t(1,i), tc);
    fprintf("\n");
end