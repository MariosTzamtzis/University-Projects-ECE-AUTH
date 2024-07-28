clc;
clear;

mu = 0;
varX = 1;
n = 10;
M = 100;
B = 1000;

X = normrnd(mu, sqrt(varX), n, M);
% a
% i) 95% confidence interval of mean
ci_mean = zeros(M, 2);
for i = 1:M
    [h,p,ci] = ttest(X(:, i), mu);
    ci_mean(i, :) = ci';%ci transpose
end

% ii) 95% confidence interval of mean using bootstrap samples
ciBoot = zeros(M,2);
for i=1:M
    ciBoot(i, :) = bootci(B, @mean, X(:, i));%computes a 95% bootstrap confidence interval for each statistic computed by the function mean
end

% Histogram for upper ci limit
figure();
histogram(ci_mean(:,1));
hold on;
histogram(ciBoot(:,1));
hold off;
title('Histogram of upper ci limit');
legend('Bootstrap ci', 'Parametric ci');
% Histogram for low ci limit
figure();
histogram(ci_mean(:,2));
hold on;
histogram(ciBoot(:,2));
hold off;
title('Histogram of low ci limit');
legend('Bootstrap ci', 'Parametric ci');

% c : Y = X^2
Y = X.*X;
% i) 95% confidence interval of mean
ci_mean = zeros(M, 2);
for i = 1:M
    [h,p,ci] = ttest(Y(:, i), mu);
    ci_mean(i, :) = ci';%ci transpose
end

% ii) 95% confidence interval of mean using bootstrap samples
ciBoot = zeros(M,2);
for i=1:M
    ciBoot(i, :) = bootci(B, @mean, Y(:, i));%computes a 95% bootstrap confidence interval for each statistic computed by the function mean
end

% Histogram for upper ci limit
figure();
histogram(ci_mean(:,1));
hold on;
histogram(ciBoot(:,1));
hold off;
title('Histogram of upper ci limit');
legend('Bootstrap ci', 'Parametric ci');
% Histogram for low ci limit
figure();
histogram(ci_mean(:,2));
hold on;
histogram(ciBoot(:,2));
hold off;
title('Histogram of low ci limit');
legend('Bootstrap ci', 'Parametric ci');