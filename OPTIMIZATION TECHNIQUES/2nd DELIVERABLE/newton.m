function [k, gammas, xs, xmin, dist] = newton(epsilon, x0, f, option)
arguments
    epsilon (1,1) double     % Convergence tolerance
    x0 (1,:) double          % Initial guess for the minimum
    f sym                    % Symbolic expression representing the objective function
    option (1,:) {mustBeMember(option,["optimal", "constant", "armijo"])} = "optimal"  % Optimization method
end


syms x1 x2;  % Declare symbolic variables

% Initialize variables
xk = [x0(1), x0(2)];  % Current iterate
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));  % Objective function as a function handle

% Function handle for Jacobian and Hessian of the objective function
jac = inline(jacobian(f));
jacx = @(x) jac(x(:,1), x(:,2));
hess = inline(hessian(f));
hessx = @(x) hess(x(:,1), x(:,2));

k = 1;       % Iteration counter
xs = [xk];   % Array to store all iterates
gammas = []; % Array to store step sizes

if  option == 'optimal'
    % Use optimal step size from the optimalGamma function
    while (norm(jacx(xk)) > epsilon)
        dk = - (jacx(xk) / hessx(xk));
        [gamma] = optimalGamma(xk, dk, f);  % Calculate gamma using an optimal method
        xk = double(xk + gamma * dk);       % Update current iterate
        xs = [xs; xk];                      % Store results
        gammas = [gammas; gamma];
        k = k + 1;
    end
    disp('Optimal Gamma was used');
    
elseif option == 'constant'
    gamma = 0.5;  % Use a constant step size
    while (norm(jacx(xk)) > epsilon)
        dk = - (jacx(xk) / hessx(xk));
        xk = double(xk + gamma * dk);  % Update current iterate
        xs = [xs; xk];                 % Store results
        gammas = [gammas; gamma];
        k = k + 1;
    end
    disp('Constant Gamma was used');
    
else
    % Use the Armijo rule to determine the step size
    gamma = -0.98;  % (can be adjusted or removed)
    dk = - (jacx(xk) / hessx(xk));
    xk = double(xk + gamma * dk);
    while (norm(jacx(xk)) > epsilon)
        dk = - (jacx(xk) / hessx(xk));
        [gamma] = armijo(10, 0.01, 0.2, xk, dk, f);  % Calculate gamma using Armijo rule
        xk = double(xk + gamma * dk);                % Update current iterate
        xs = [xs; xk];                               % Store results
        gammas = [gammas; gamma];
        k = k + 1;
    end
    disp('Armijo Rule was used');
end

xmin = fminsearch(fx, x0);          % Find minimum using fminsearch
dist = norm(xmin - xk);              % Calculate distance between the minimum found and the final iterate

end

