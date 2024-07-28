clc;
clear;
close all;

% Define the objective function
syms x1 x2;
f = (x1^3)*(exp(-x1^2 - x2^4));
f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

% Define initial points, optimization options, and corresponding titles
x0 = [[-1 -1]; [0, 0]; [1,1]];
celarray = ["optimal", "constant", "armijo"];
titlearray = ["minimizing f(xk + γk*dk)", 'constant', 'Armijo rule']; 
subPlotPositions = {1, 2, [3, 4]};

% Loop through each initial point and optimization option
for i = 1:length(x0)
    figure;
    for j = 1:length(celarray)
        if (x0(i,:) == [1 1] & celarray(j) == "armijo")
            disp('Armijo does not converge');
            break;
        end
        
        % Run Newton's method for optimization
        [k, gammas, xs, xmin, dist] = newton(1e-4, x0(i,:), f, celarray(j));
        
        % Plot results
        subplot(2,2, subPlotPositions{j});
        plot(1:k, fx(xs), '-ok');
        hold on;
        yline(fx(xmin), '-.r');
        xlabel('k Number of iterations')
        ylabel('Value of f(xk)');
        legend('Value of f', 'Min f');
        title(sprintf('Value of f with γk %s for initial point (x, y) = (%d, %d) ~ k number of iterations', titlearray(j), x0(i,1), x0(i,2)));

        % Display iteration count and distance from the minimum
        K = sprintf('\nk = %d\n', k);
        disp(K);
        Dist = sprintf('Distance from minimum %.5f', dist);
        disp(Dist);
    end
end

