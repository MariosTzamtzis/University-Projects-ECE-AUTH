clc;
clear;

f(1/15, 100, 100);
% a
f(1/15, 1000, 5);
% b
f(1/15, 1000, 100);


function f(meanX, M, n)
   rejection = 0;
   X = exprnd(meanX, n, M);
   ci = zeros(2,M);
   for i=1:M
    [h,~,ci(:,i)] = ttest(X(:, i),meanX);
    if h %if h=1 the value is out of confidence interval
        rejection = rejection + 1;
    end
   end
   if M == n
       fprintf("Confidence Interval: [%f, %f]\n", ci(1), ci(2));
   else
       fprintf("For M=%d samples and sample size n=%d the mean = %.4f is " + ...
           "inside confidence interval with percentage %.4f %%.\n", ...
           M, n, meanX, (1-rejection/M)*100);
   end
end

