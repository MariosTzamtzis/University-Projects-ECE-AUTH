clc;
clear;

% Generate random numbers from exponential distribution
lambda = 1;
uniform_rnd = rand(1e3, 1);
exp_rnd = -(1/lambda).*log(1-uniform_rnd);

x = 0.01:0.1:10;
exp_pdf = lambda.*exp(-lambda.*x);

histogram(exp_rnd, 'Normalization','pdf');
hold on
plot(x, exp_pdf, 'LineWidth',1.5);
legend('simulated','analytic');
title('Exponential distribution from random numbers');