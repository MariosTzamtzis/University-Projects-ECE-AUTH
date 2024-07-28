clc;
clear;

n = [10 1e2 1e3 1e4 1e5 1e6];
lambda = 0.5;
meanX = zeros(length(n),1);
for i = 1:length(n)
    X = exprnd(1/lambda, n(i), 1);%mean = 1/lambda
    meanX(i) = mean(X);
    MLE = mle(X,'distribution','Exponential');
    fprintf('Number of samples: %d      Mean: %.5f     MLE: %.5f\n', n(i), meanX(i), MLE);
end

% b
m1 = exponentialMean(1, 10, 10);
m2 = exponentialMean(2, 100, 100);
m3 = exponentialMean(3, 1000, 1000);


function m = exponentialMean(lambda, M, n)
   X = exprnd(1/lambda, n, M);
   meanX = mean(X);
   figure();
   histogram(meanX);
   title(sprintf(['Mean values from exponential distribution: lambda=%.2f'],lambda));
   m = mean(meanX);
   fprintf('Mean value of Exponential mean values: %.5f\n', m);
end