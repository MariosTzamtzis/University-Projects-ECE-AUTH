function [k, as, bs] = goldenSection(lambda, a, b, f)
    k = 1; % Initialize the number of repetitions
    as = [a]; % Initialize the lower bounds array
    bs = [b]; % Initialize the upper bounds array

    gamma = 0.618; % Complementary golden ratio

    x1 = a + (1 - gamma) * (b - a); % Define x1
    x2 = a + gamma * (b - a); % Define x2

    while (bs(k) - as(k) - lambda >= 0)
        if (f(x1) - f(x2) > 0)
            % Condition when f(x1) > f(x2)
            as = [as, x1]; % Append x1 to lower bounds
            bs = [bs, bs(end)]; % Append the previous upper bound to upper bounds
            x1 = x2; % Update x1
            x2 = as(end) + gamma * (bs(end) - as(end)); % Update x2
        else
            % Condition when f(x2) >= f(x1)
            as = [as, as(end)]; % Append the previous lower bound to lower bounds
            bs = [bs, x2]; % Append x2 to upper bounds
            x2 = x1; % Update x2
            x1 = as(end) + (1 - gamma) * (bs(end) - as(end)); % Update x1
        end
        k = k + 1; % Increment the number of repetitions
    end
end
