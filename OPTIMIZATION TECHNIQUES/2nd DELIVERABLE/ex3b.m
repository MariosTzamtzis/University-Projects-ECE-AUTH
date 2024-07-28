clc;
clear;
close all;

% Define the objective function
syms x1 x2;
f =(x1^3)*(exp(-x1^2 - x2^4));
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points, optimization options, and corresponding titles
x0 = [[-1 -1]; [0, 0]; [1,1]];
celarray = ["optimal", "constant", "armijo"];
titlearray = ["minimizing f(xk + γk*dk)", 'constant', 'Armijo rule']; 
subPlotPositions = {1, 2, [3, 4]};

% Iterate through each initial point and optimization option
for i = 1:length(x0)
    X0 = sprintf('For initial point (%d, %d)\n', x0(i,1), x0(i,2));
    disp(X0);
    
    % Create a new figure for each initial point
    figure;
    
    % Iterate through each optimization option
    for j = 1:length(celarray)
        % Check if the specific combination doesn't converge (arbitrary check for [1,1] initial point with Armijo)
        if (x0(i,:) == [1 1] & celarray(j) == "armijo")
            disp('Does not converge');
            break;
        end
        
        % Run Newton's method for optimization
        [k, gammas, xs, xmin, dist] = newton(1e-4, x0(i,:), f, celarray(j));
        
        % Plot results on subplots
        subplot(2,2, subPlotPositions{j});
        fcontour(f);
        hold on;
        plot(xs(:,1), xs(:,2), '--or');
        hold on;
        plot(xmin(:,1), xmin(:,2), '.', 'MarkerSize', 20);
        xlabel('x');
        ylabel('y');
        legend('Contour','Point for k-th iteration', 'Min f');
        title(sprintf('Convergence of f with Steepest Descent with γ %s for initial point (x, y) = (%d, %d)', titlearray(j), x0(i,1), x0(i,2)));

        % Display iteration count and distance from the minimum
        K = sprintf('\nk = %d\n', k);
        disp(K);
        Dist = sprintf('Distance from minimum %.5f', dist);
        disp(Dist);
    end
end
