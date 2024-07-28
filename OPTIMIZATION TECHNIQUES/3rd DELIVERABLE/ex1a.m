clc;
clear;
close all;

syms x1 x2;

% Define the symbolic function f(x, y)
f = (1/3)*(x1^2) + (3*x2^2);
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points for optimization
x0 = [3, 4];

% Define optimization methods and corresponding titles for plots
celarray = [0.1, 0.3, 3, 5];
titlearray = ["Gamma = 0.1", 'Gamma = 0.3', 'Gamma = 3', 'Gamma = 5'];
subPlotPositions = {1, 2, 3, 4};


X0 = sprintf('For initial point (%d, %d)\n', x0(1), x0(2));
disp(X0);
figure;

% Iterate through different optimization methods
for j = 1:length(celarray)
    % Perform steepest descent optimization
    [k, gammas, xs, xmin, dist] = steepestDesc(1e-3, x0, f, celarray(j));
    
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
    title(sprintf('Value of f with %s for initial point (x, y) = (%d, %d) ~ k number of iterations', titlearray(j), x0(1), x0(2)));
    
    % Display iteration details
    K = sprintf('\nk = %d\n', k);
    disp(K);
    Dist = sprintf('Distance from minimum %.5f', dist);
    disp(Dist);
end