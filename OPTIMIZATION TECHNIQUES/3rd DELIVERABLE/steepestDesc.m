function [k, gammas, xs, xmin, dist] = steepestDesc(epsilon, x0, f, option)

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
        if option == 0.1
            gamma = 0.1;
        elseif option == 0.3
            gamma = 0.3;
        elseif option == 3
            gamma = 3;
        else
            gamma = 5;
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
    if option == 0.1
        disp('Gamma = 0.1\n');
    elseif option == 0.3
        disp('Gamma = 0.3\n');
    elseif option == 3
        disp('Gamma = 3\n');
    else
        disp('Gamma =5\n');
    end
    
end