function [k, gammas, xs, xmin, dist] = steepestDescent(epsilon, x0, f, option)
    % Input Arguments:
    %   epsilon: Convergence tolerance.
    %   x0: Initial guess for the minimum.
    %   f: Symbolic expression representing the objective function.
    %   option: Optimization method ('optimal', 'constant', or 'armijo').

    % Initialize variables
    xk = [x0(1), x0(2)]; % Current iterate
    f1 = inline(f); % Objective function as an inline function
    fx = @(x) f1(x(:,1), x(:,2)); % Objective function as a function handle
    k = 1; % Iteration counter

    % Function handle for Jacobian of the objective function
    jac = inline(jacobian(f));
    jacx = @(x) jac(x(:,1), x(:,2));

    xs = [xk]; % Array to store all iterates
    gammas = []; % Array to store step sizes

    % Main optimization loop
    while (norm(jacx(xk)) > epsilon)
        % Compute search direction
        dk = -jacx(xk);

        % Update iterate based on the selected option
        if option == 'optimal'
            % Use optimal step size from the optimalGamma function
            gamma = optimalGamma(xk, dk, f);
        elseif option == 'constant'
            % Use a constant step size of 0.5
            gamma = 0.5;
        else
            % Use Armijo rule to determine step size
            gamma = armijo(10, 0.01, 0.2, xk, dk, f);
        end

        % Update current iterate
        xk = double(xk + gamma * dk);

        % Store results
        xs = [xs; xk];
        gammas = [gammas; gamma];
        k = k + 1;
    end

    % Find minimum using fminsearch
    xmin = fminsearch(fx, x0);

    % Calculate distance between the minimum found and the final iterate
    dist = norm(xmin - xk);

    % Display which step size strategy was used
    if option == 'optimal'
        disp('Optimal Gamma was used');
    elseif option == 'constant'
        disp('Constant Gamma was used');
    else
        disp('Armijo Rule was used');
    end
    
end
