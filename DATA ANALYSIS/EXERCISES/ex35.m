clc;
clear;

data = importdata("eruption.dat");

% a : Confidence interval of standard deviation
var_waitingtime = 10;
var_duration = 1;
alpha = 0.05;

hvar = zeros(3,1);
pvar = zeros(3,1);
civar = zeros(3,2);
% 1st column: waiting time 1989
fprintf("Waiting Time 1989\n");
[hvar(1), pvar(1), civar(1,:)] = print_vartest(data(:,1), var_waitingtime, alpha);
% 2nd column: duration of eruptions 1989
fprintf("\nDuration of eruptions 1989\n");
[hvar(2), pvar(2), civar(2,:)] = print_vartest(data(:,2),var_duration, alpha);
% 3rd column: waiting time 2006
fprintf("\nWaiting Time 2006\n");
[hvar(3), pvar(3), civar(3,:)] = print_vartest(data(:,3),var_waitingtime, alpha);


% b : Confidence interval of mean
mu_waitingtime = 75;
mu_duration = 2.5;
hmu = zeros(3,1);
pmu = zeros(3,1);
cimu = zeros(3,2);
% 1st column: waiting time 1989
fprintf("Waiting Time 1989\n");
[hmu(1), pmu(1), cimu(1,:)] = print_ttest(data(:,1), mu_waitingtime,alpha);
% 2nd column: duration of eruptions 1989
fprintf("\nDuration of eruptions 1989\n");
[hmu(2), pmu(2), cimu(2,:)] = print_ttest(data(:,2), mu_duration,alpha);
% 3rd column: waiting time 2006
fprintf("\nWaiting Time 2006\n");
[hmu(3), pmu(3), cimu(3,:)] = print_ttest(data(:,3), mu_waitingtime,alpha);

% c : Goodness-of-fit Test for normal distribution
hchi2 = zeros(3,1);
pchi2 = zeros(3,1);
% 1st column: waiting time 1989
fprintf("Waiting Time 1989\n");
[hchi2(1), pchi2(1)] = print_chi2gof(data(:,1), alpha);
% 2nd column: duration of eruptions 1989
fprintf("\nDuration of eruptions 1989\n");
[hchi2(2), pchi2(2)] = print_chi2gof(data(:,2), alpha);
% 3rd column: waiting time 2006
fprintf("\nWaiting Time 2006\n");
[hchi2(3), pchi2(3)] = print_chi2gof(data(:,3), alpha);

% d : Checking the claim "With an error of 10 minutes, Old Faithful will erupt 
% 65 minutes after an eruption lasting less than 2.5 minutes or 91 minutes
% after an eruption lasting more than 2.5 minutes."
waitingtimes = data(:, 1);
waitingtime_less = waitingtimes(data(:,2)<2.5);
waitingtime_more = waitingtimes(data(:,2)>=2.5);
mu_less = 65;
mu_more = 91;
std = 10;

fprintf("\nConfidence Interval and null Hypothesis test for mean value\n");
fprintf("Waiting time < 2.5 minutes\n");
[hmul, pmul, cimul] = print_ttest(waitingtime_less, mu_less, alpha);
fprintf("Waiting time >= 2.5 minutes\n");
[hmum, pmum, cimum] = print_ttest(waitingtime_more, mu_more, alpha);

fprintf("\nConfidence Interval and null Hypothesis test for std\n");
fprintf("Waiting time < 2.5 minutes\n");
[hvarl, pvarl, civarl] = print_vartest(waitingtime_less, std^2, alpha);
fprintf("Waiting time >= 2.5 minutes\n");
[hvarm, pvarm, civarm] = print_vartest(waitingtime_more, std^2, alpha);

function [h,p,ci] = print_vartest(data,var,alpha)
    [h,p,ci] = vartest(data, var, 'Alpha', alpha);
    fprintf("%.2f %% Confidence Interval of std: [%.4f, %.4f]\n",(1-alpha)*100, sqrt(ci(1)), sqrt(ci(2)));
    if(h==0)
        fprintf('Yes variance was %1.3f\n', var);
    else
        fprintf('No variance was not %1.3f\n', var');
    end
end

function [h,p,ci] = print_ttest(data,mu,alpha)
    [h,p,ci] = ttest(data, mu, 'Alpha', alpha);
    fprintf("%.2f %% Confidence Interval of mean value: [%.4f, %.4f]\n",(1-alpha)*100, ci(1), ci(2));
    if(h==0)
        fprintf('Yes mean was %1.3f\n', mu);
    else
        fprintf('No mean was not %1.3f\n', mu);
    end
end

function [h,p] = print_chi2gof(data,alpha)
    [h,p] = chi2gof(data, 'Alpha', alpha);
    fprintf("The p-value of the goodness-of-fit test is %.4f.\n", p);
end
