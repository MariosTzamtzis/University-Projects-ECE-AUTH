clc;
clear;
close all;

% Define symbolic variables and the function f(x, y)
syms x1 x2;
f = (1/3)*(x1^2) + (3*x2^2);

% Convert the function to an inline function and a function handle
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points for optimization and options for steepestDescent method
x0 = [3,4];
celarray = [0.1, 0.3, 3, 5];
titlearray = ["Gamma = 0.1", 'Gamma = 0.3', 'Gamma = 3', 'Gamma = 5'];
subPlotPositions = {1, 2, 3, 4};


X0 = sprintf('For initial point (%d, %d)\n', x0(1), x0(2));
disp(X0);
figure;

% Iterate through each steepestDescent option
for j = 1:length(celarray)
    % Perform steepestDescent optimization
    [k, gammas, xs, xmin, dist] = steepestDesc(1e-3, x0, f, celarray(j));
    
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
    title(sprintf('Convergence of f with Steepest Descent with  %s for initial point (x, y) = (%d, %d)', titlearray(j), x0(1), x0(2)));
    
    % Display iteration details
    K = sprintf('\nk = %d\n', k);
    disp(K);
    Dist = sprintf('Distance from minimum %.5f', dist);
    disp(Dist);
end
