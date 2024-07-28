function [f_hat] = f_hat(a, b, const, u1, u2)
    % a = coefficients for Gaussians
    % b = constant term
    % const = matrix containing Gaussian constants for each function
    % u1, u2 = input variables

    f_hat = 0; % Initialize the output

    % Compute the weighted sum of Gaussian functions using coefficients 'a'
    for i = 1:15
        % Calculate the Gaussian function value for each 'a' coefficient and add it to the total
        f_hat = f_hat + a(i) * Gaussian(u1, u2, const(i, 1), const(i, 2), const(i, 3), const(i, 4));
    end

    f_hat = f_hat + b; % Add the constant term 'b' to the final result
end
