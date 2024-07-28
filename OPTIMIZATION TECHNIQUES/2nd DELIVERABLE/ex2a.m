clc;
clear;
close all;

syms x1 x2;

% Define the symbolic function f(x, y)
f = (x1^3) * (exp(-x1^2 - x2^4));
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points for optimization
x0 = [[-1, -1]; [0, 0]; [1, 1]];

% Define optimization methods and corresponding titles for plots
celarray = ["optimal", "constant", "armijo"];
titlearray = ["minimizing f(xk + γk*dk)", 'constant', 'Armijo rule'];
subPlotPositions = {1, 2, [3, 4]};

% Iterate through different initial points
for i = 1:length(x0)
    X0 = sprintf('For initial point (%d, %d)\n', x0(i,1), x0(i,2));
    disp(X0);
    figure;
    
    % Iterate through different optimization methods
    for j = 1:length(celarray)
        % Perform steepest descent optimization
        [k, gammas, xs, xmin, dist] = steepestDescent(1e-4, x0(i,:), f, celarray(j));
        
        % Create subplots for each optimization method
        subplot(2,2, subPlotPositions{j});
        
        % Plot the convergence of the objective function over iterations
        plot(1:k, fx(xs), '-ok');
        hold on;
        yline(fx(xmin), '-.r');  % Plot the minimum value found
        
        % Label and title for the subplot
        xlabel('k Number of iterations')
        ylabel('f(xk)');
        legend('Value of f', 'Min f');
        title(sprintf('Value of f with γk %s for initial point (x, y) = (%d, %d) ~ k number of iterations', titlearray(j), x0(i,1), x0(i,2)));
        
        % Display iteration details
        K = sprintf('\nk = %d\n', k);
        disp(K);
        Dist = sprintf('Distance from minimum %.5f', dist);
        disp(Dist);
    end
end
