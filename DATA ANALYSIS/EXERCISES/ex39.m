clc;
clear;

M = 100;     
n = 10;
m = 12;
alpha = 0.05;

%Data from the X variable
meanX = 0;
varX = 1;
dataX = normrnd(meanX, sqrt(varX), n, M);
muX = mean(dataX);
stdX = std(dataX);

%Data from the Y variable
meanY = 0;
% meanY = 0.2;
varY = 1;
dataY = normrnd(meanY, sqrt(varY), m, M);
muY = mean(dataY);
stdY = std(dataY);

%Parametric 95% Confidence Interval for 2 samples
[h1,p1,ci1] = ttest2(dataX, dataY);
figure(1);
subplot(2,1,1);
histogram(ci1(1,:));
title('Histogram of lower limit of conficence interval');
subplot(2,1,2);
histogram(ci1(2,:));
title('Histogram of upper limit of conficence interval');

%Bootstrap 95% Confidence Interval
B = 1000; 
bootstrap_meanX = bootstrp(B, @mean, dataX);
bootstrap_meanY = bootstrp(B, @mean, dataY);
b_mean = bootstrap_meanX - bootstrap_meanY;

% Calculate low and upper limit for confidence interval
ci_llimit = floor((B+1)*alpha/2);
ci_ulimit = B+1-ci_llimit;
% Sorting the bootstrap_mean array
b_mean_sorted = sort(b_mean);
% Get the confidence interval
bci1 = zeros(2, M);
for i = 1:M
    bci1(1, i) = b_mean_sorted(ci_llimit, i);
    bci1(2, i) = b_mean_sorted(ci_ulimit, i);
end

figure(2);
subplot(2,1,1);
histogram(bci1(1,:));
title('Histogram of lower limit of Bootstrap conficence interval');
subplot(2,1,2);
histogram(bci1(2,:));
title('Histogram of upper limit of Bootstrap conficence interval');

%Transform Y = X^2
dataY2 = dataX .* dataX;
[~,~,ci2] = ttest2(dataX, dataY2);
figure(3);
subplot(2,1,1);
histogram(ci2(1,:));
title('Histogram of lower limit of conficence interval');
subplot(2,1,2);
histogram(ci2(2,:));
title('Histogram of upper limit of conficence interval');

%Bootstrap 95% Confidence Interval
bootstrap_meanX = bootstrp(B, @mean, dataX);
bootstrap_meanY2 = bootstrp(B, @mean, dataY2);
b_mean2 = bootstrap_meanX - bootstrap_meanY2;
% Sort the bootstrap_mean array
b_mean2_sorted = sort(b_mean2);
% Get the confidence interval
bci2 = zeros(2, M);
for i = 1:M
    bci2(1, i) = b_mean2_sorted(ci_llimit, i);
    bci2(2, i) = b_mean2_sorted(ci_ulimit, i);
end

figure(4);
subplot(2,1,1);
histogram(bci2(1,:));
title('Histogram of lower limit of Bootstrap conficence interval');
subplot(2,1,2);
histogram(bci2(2,:));
title('Histogram of upper limit of Bootstrap conficence interval');