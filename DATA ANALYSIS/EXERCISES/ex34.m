clc;
clear;

data = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];

var = 25;
alpha = 0.05;
%vartest rejects the null hypothesis at the default 5% significance level 
%ci shows the lower and upper boundaries of the confidence interval for the true variance
% and suggests that the true variance is greater than 25
%Confidence interval= 1-alpha
[h,p,ci] = vartest(data, var, 'Alpha', alpha);
% a : Confidence Interval of variance
fprintf('%.2f %% Confidence Interval of variance: [%.4f, %.4f]\n',(1-alpha)*100, ci(1), ci(2));

% b : sigma=5
fprintf('p-value: σ = %.2f: p = %.3f\n\n',sqrt(var),p);%the probability that the null hypothesis is true, if p<0.05 the test hypothesis is false or should be rejected

% c : Confidence Interval of mean value
mean = 52;
[hc,pc,cic] = ttest(data, mean, 'Alpha', alpha);
fprintf('%.2f %% Confidence Interval of mean value: [%.4f, %.4f]\n',(1-alpha)*100, cic(1), cic(2));

% d : Mean = 52
fprintf('p-value: μ = %.2f: p = %.3f\n\n',mean,pc);

% e : Goodness-of-fit test and p-value
[h,p] = chi2gof(data, 'Alpha', alpha);
fprintf('The p-value of the goodness-of-fit test is %.3f.\n', p);
