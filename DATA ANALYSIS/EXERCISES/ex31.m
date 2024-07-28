clc;
clear;



n = [10 100 1e3 1e4 1e5 1e6];
lambda = 2;
meanX = zeros(length(n),1);
for i = 1:length(n)
    X = poissrnd(lambda, n(i), 1);% get n samples from Poisson distribution
    meanX(i) = mean(X);% Calculate samples' mean
    MLE = mle(X,'distribution','poisson');
    fprintf('Number of samples: %d      Mean: %.5f     MLE: %.5f\n', n(i), meanX(i), MLE);
end

m1 = poissonMean(1, 10, 10);
m2 = poissonMean(2, 100, 100);
m3 = poissonMean(3, 1000, 1000);

function m = poissonMean(lambda, M, n)
   X = poissrnd(lambda, n, M);
   meanX = mean(X);
   figure();
   histogram(meanX);
   title(sprintf('Mean values from poisson distribution lambda=%d ', lambda));
   m = mean(meanX);
   fprintf('Mean value of Poisson mean values: %.5f\n', m);
end