function [k, as, bs] = difBisection(lambda, a, b, f)

n = floor((log(b-a) - log(lambda)) / log(2)); % Calculate the integer number of repetitions needed

k = 1; % Initialize repetition count
as = [a]; % List to store lower interval bounds
bs = [b]; % List to store upper interval bounds

syms x; % Define x as symbolic for differentiation
df = matlabFunction(diff(f, x), 'Vars', x);%convert the symbolic expression of the derivative into an anonymous function that can be used for calculations

while (k - n ~= 0)
    xk = (as(k) + bs(k)) / 2; % Calculate the midpoint of the current interval

    if (df(xk) == 0) % If the derivative at the midpoint is 0, break the loop
        break;
    elseif (df(xk) > 0)
        % If the derivative at xk is positive, the root is to the left of xk
        % Update the bounds accordingly
        as = [as, as(end)]; % Lower bound remains the same
        bs = [bs, xk]; % Update upper bound
    else
        % If the derivative at xk is negative, the root is to the right of xk
        % Update the bounds accordingly
        as = [as, xk]; % Update lower bound
        bs = [bs, bs(end)]; % Upper bound remains the same
    end

    k = k + 1; % Increment the repetition count
end
end
