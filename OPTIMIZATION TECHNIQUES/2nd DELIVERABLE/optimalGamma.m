function [gamma] = optimalGamma(xk, dk, f)
    % Input Arguments:
    %   xk: Current iterate.
    %   dk: Search direction.
    %   f: Symbolic expression representing the objective function.

    syms x1 x2;

    % Convert the objective function to an anonymous function
    f1 = inline(f);
    fx = @(x) f1(x(:,1), x(:,2));

    syms g

    % Define a new function with respect to the variable g
    f2 = fx(xk + (g * dk));
    fg = inline(f2, 'g');

    % Perform Fibonacci search to find the optimal step size
    [p, gamma1, gamma2] = fibsearch(1e-8, 1e-9, -2, 10, fg); % Adjust the range if needed (e.g., (0,10))

    % Compute the average of the two optimal step sizes
    gamma = (gamma1(end) + gamma2(end)) / 2;
end

