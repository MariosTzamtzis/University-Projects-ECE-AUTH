function [k, as, bs] = bisection(epsilon,lambda, a, b, f)
k = 1;    % Number of repetitions
as = [a]; % Min
bs = [b]; % Max

% Loop until the difference between max and min is less than lambda
while((bs(k) - as(k) - lambda) > 0)

    x1 = (as(k) + bs(k)) / 2 - epsilon;
    x2 = (as(k) + bs(k)) / 2 + epsilon;

    % Choose the new interval based on function evaluation
    if ((f(x1) - f(x2)) < 0)
        as = [as as(end)];
        bs = [bs x2];
    else
        as = [as x1];
        bs = [bs bs(end)];
    end
    
    k = k + 1;% Increment repetition count
end
end