clc;
clear;

h1 = 100;
h2 = [60 54 58 60 56];
alpha = 0.05;

e0 = 0.76;
e = sqrt(h2./h1);
std_e = std(e);
t = tinv(1-alpha/2, length(h2)-1);%returns the inverse cumulative distribution function (icdf) of the Student's t distribution evaluated at the probability values in (1-alpha/2) using the corresponding degrees of freedom in n-1
fprintf("Uncertainty of Measurement = %.3f\n", std_e);
fprintf("Precision limits of correspondence are: [%.3f , %.3f]\n", 0.76 - t*std_e, 0.76 + t*std_e);

%b
M = 1000;
n = 5;
mu = 58;
sigma = 2;
h2 = normrnd(mu, sigma, n, M);
e = sqrt(h2./h1);
mean_h2 = mean(h2);
mean_e = mean(e);
std_h2 = std(h2);
std_e = std(e);

expectedE = sqrt(mu/h1);
expectedSTD = 0.5*sqrt(1/h1)*sqrt(1/mu)*sigma;

figure();
histogram(mean_h2);
title("Mean Of h2 Histogram");
xline(mu, 'Color', 'r', 'LineWidth', 3);
legend('Mean Of h2', 'Mean');
figure();
histogram(std_h2);
title("Std Of h2 Histogram");
xline(sigma, 'Color', 'r', 'LineWidth', 3);
legend('Std Of h2', 'Sigma');
figure();
histogram(mean_e);
title("Mean Of e Histogram");
xline(expectedE, 'Color', 'r', 'LineWidth', 3);
legend('Mean Of e', 'Expected Mean');
figure();
histogram(std_e);
title("Std Of e Histogram");
xline(expectedSTD, 'Color', 'r', 'LineWidth', 3);
legend('Std Of e', 'Expected Sigma');

%c
h = [80 48; 100 60; 90 50; 120 75; 95 56]; %Column1 --> h1, Column2 --> h2

e = sqrt(h(:,2)./h(:,1));

std_h1 = std(h(:,1));
std_h2 = std(h(:,2));
std_e = std(e);
mu_h2 = mean(h(:,2));
mu_h1 = mean(h(:,1));

t = tinv((1-alpha/2), 4);

eSigma = sqrt((-0.5*sqrt(mu_h2)*mu_h1^(-3/2))^2*std_h1^2 + ...
    (0.5*sqrt(1/mu_h1)*sqrt(1/mu_h2))^2*std_h2^2);

fprintf('\nUncertainty of correspondence: %.4f\n', std_e);
fprintf('Propagation of error of correspondence: %.4f\n', eSigma);
fprintf('Mean of E = %.4f\n', mean(e));
fprintf("Precision limits of correspondence are: [%.3f , %.3f]\n", 0.76 - t*std_e, 0.76 + t*std_e);

