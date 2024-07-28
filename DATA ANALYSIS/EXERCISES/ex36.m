clc;
clear;

n=10;
meanX = 0;
varX = 1;
data = normrnd(meanX, sqrt(varX), 1, n);
mu = mean(data);%Mean of normal distribution

% a : Mean of bootstrap samples
B = 1000;
bootstat = bootstrp(B,@mean,data);%draws B bootstrap data samples from data, computes statistics on each sample using the function mean, and returns the results in bootstat
bootstat_mean = mean(bootstat);
figure();
histogram(bootstat);
hold on;
xline(meanX, '-.r', 'Mean of X');%draws a vertical line where meanX is
hold on;
xline(bootstat_mean, '-.b', 'Bootstrap-Mean');%draws a vertical line where bootstrap-mean is
hold off;
fprintf('Mean value from data m = %.3f\n', mu);
fprintf('Mean value from bootstrap samples m = %.3f\n', bootstat_mean);

% b : Calculate standard error
seB = std(bootstat);
seData = std(data)/sqrt(n);
fprintf('Standard Error from bootstrap samples seB = %.3f\n', seB);
fprintf('Standard Error from data seData = %.3f\n', seData);

% c : Y = exp(X)
Ydata = exp(data);
muY = mean(Ydata);
bootstat2 = bootstrp(B,@mean,Ydata);
bootstat_mean2 = mean(bootstat2);
figure();
histogram(bootstat2);
hold on;
xline(muY, '-.r', 'Mean of Y');
hold on;
xline(bootstat_mean2, '-.b', 'Bootstrap-Mean');
hold off;
fprintf('Mean value from Y m = %.3f\n', muY);
fprintf('Mean value from bootstrap samples m = %.3f\n', bootstat_mean2);
seB2 = std(bootstat2);
seY = std(Ydata)/sqrt(n);
fprintf('Standard Error from bootstrap samples seB = %.3f\n', seB2);
fprintf('Standard Error from data seData = %.3f\n', seY);