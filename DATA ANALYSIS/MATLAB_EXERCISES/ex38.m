clc;
clear;

mu = 0;
varX = 1;
n = 10;
M = 100;
B = 1000;

X = normrnd(mu, sqrt(varX), n, M);

% a
% i) 95% confidence interval of std
ci_std = zeros(M, 2);
for i = 1:M
    [h,p,ci] = vartest(X(:, i), varX);
    ci_std(i, :) = sqrt(ci)';
end

% ii) 95% confidence interval of std using bootstrap samples
ciBoot = zeros(M,2);
for i=1:M
    ciBoot(i, :) = bootci(B, @std, X(:, i));%computes a 95% bootstrap confidence interval for each statistic computed by the function std
end

% Histogram for upper ci limit
figure();
histogram(ci_std(:,1));
hold on;
histogram(ciBoot(:,1));
hold off;
title('Histogram of upper ci limit');
legend('Bootstrap ci', 'Parametric ci');
% Histogram for low ci limit
figure();
histogram(ci_std(:,2));
hold on;
histogram(ciBoot(:,2));
hold off;
title('Histogram of low ci limit');
legend('Bootstrap ci', 'Parametric ci');

% c : Y = X^2
Y = X.*X;
% i) 95% confidence interval of std
ci_std = zeros(M, 2);
for i = 1:M
    [h,p,ci] = vartest(Y(:, i), varX);
    ci_std(i, :) = sqrt(ci)';
end

% ii) 95% confidence interval of std using bootstrap samples
ciBoot = zeros(M,2);
for i=1:M
    ciBoot(i, :) = bootci(B, @std, Y(:, i));%computes a 95% bootstrap confidence interval for each statistic computed by the function std
end

% Histogram for upper ci limit
figure();
histogram(ci_std(:,1));
hold on;
histogram(ciBoot(:,1));
hold off;
title('Histogram of upper ci limit');
legend('Bootstrap ci', 'Parametric ci');
% Histogram for low ci limit
figure();
histogram(ci_std(:,2));
hold on;
histogram(ciBoot(:,2));
hold off;
title('Histogram of low ci limit');
legend('Bootstrap ci', 'Parametric ci');