clc;
clear;
close all;

% Define symbolic variables and the function f(x, y)
syms x1 x2;
f = x1^3 * exp(-x1^2 - x2^4);

% Convert the function to an inline function and a function handle
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points for optimization and options for steepestDescent method
x0 = [[-1, -1]; [0, 0]; [1, 1]];
celarray = ["optimal", "constant", "armijo"];
titlearray = ["minimizing f(xk + γk*dk)", 'constant', 'Armijo rule'];
subPlotPositions = {1, 2, [3, 4]};

% Iterate through each initial point
for i = 1:length(x0)
    X0 = sprintf('For initial point (%d, %d)\n', x0(i,1), x0(i,2));
    disp(X0);
    figure;
    
    % Iterate through each steepestDescent option
    for j = 1:length(celarray)
        % Perform steepestDescent optimization
        [k, gammas, xs, xmin, dist] = steepestDescent(1e-4, x0(i,:), f, celarray(j));
        
        % Create a subplot for each steepestDescent option
        subplot(2,2, subPlotPositions{j});
        
        % Plot the surface of the function f(x, y) with contours
        fsurf(f,'ShowContours', 'on');
        hold on;
        
        % Plot the iteration path and the minimum found in 3D space
        plot3(xs(:,1), xs(:,2), fx(xs), '-ok', 'MarkerSize', 20);
        hold on;
        plot3(xmin(:,1), xmin(:,2), fx(xmin), '.r', 'MarkerSize', 35);
        
        % Labeling and title for the subplot
        xlabel('x');
        ylabel('y');
        legend('f(x,y)','Point for k-th iteration', 'Min f');
        title(sprintf('Convergence of f with Steepest Descent with γ %s for initial point (x, y) = (%d, %d)', titlearray(j), x0(i,1), x0(i,2)));
        
        % Display iteration details
        K = sprintf('\nk = %d\n', k);
        disp(K);
        Dist = sprintf('Distance from minimum %.5f', dist);
        disp(Dist);
    end
end
