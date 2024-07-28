function [xk, yk, k] = steepestDescProjection(f, point, stepG, stepS, epsilon)
    % Set maximum number of iterations
    MAX_ITER = 500;
    
    % Define symbolic variables
    syms x y;
    
    % Initialize iteration counter and starting points
    k = 1;
    xk(k) = point(1); % Initial x value
    yk(k) = point(2); % Initial y value
    
    % Define boundary limits for x and y
    X = [-10 5]; % x range limits
    Y = [-8 12]; % y range limits
    
    % Calculate the gradient of the function
    g = gradient(f, [x, y]);
    
    % Calculate initial gradient direction
    d = g(xk(k), yk(k));
    
    % Perform steepest descent projection
    while (norm(d) > epsilon && k < MAX_ITER)
        d = -d; % Reverse the gradient direction
        
        % Calculate the trial points using stepS
        xkbar(k) = xk(k) + stepS * d(1);
        ykbar(k) = yk(k) + stepS * d(2);
        
        % Check and adjust if trial points are out of bounds
        if xkbar(k) > X(2)
            xkbar(k) = X(2);
        elseif xkbar(k) < X(1)
            xkbar(k) = X(1);
        end
        if ykbar(k) > Y(2)
            ykbar(k) = Y(2);
        elseif ykbar(k) < Y(1)
            ykbar(k) = Y(1);
        end
        
        % Update the current points using stepG
        xk(k + 1) = xk(k) + stepG * (xkbar(k) - xk(k));
        yk(k + 1) = yk(k) + stepG * (ykbar(k) - yk(k));
        
        % Increment iteration count
        k = k + 1;
        
        % Recalculate gradient direction for next iteration
        d = g(xk(k), yk(k));
    end
end
