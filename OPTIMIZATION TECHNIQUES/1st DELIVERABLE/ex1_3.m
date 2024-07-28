clear;
close all;

epsilon = 1e-3;
lambdas = [2*epsilon + 1e-6, 1e-2, 1e-1]; % Different search ranges

% Define the three functions
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

funArray = {f1, f2, f3}; % Array holding the functions
subPlotPos = {1, 2, [3, 4]}; % Subplot positions for the figures
funcNames = {'f_1(x)', 'f_2(x)', 'f_3(x)'};

% Loop through each function
for j = 1:length(funArray)
    f = funArray{j};
    figure;
    % Loop through each lambda value
    for i = 1:length(lambdas)
        % Apply the bisection method to get k, as, and bs
        [k, as, bs] = bisection(epsilon, lambdas(i), 0, 3, f);
        
        % Create subplots for interval edges
        subplot(2, 2, subPlotPos{i});
        
        % Plot the edges of the interval [ak, bk] against k
        plot(1:k, as);
        hold on;
        plot(1:k, bs);
        
        % Label the axes and set the title
        xlabel('k Number of repetitions')
        ylabel('Interval Edges [\alpha_k, \beta_k]')
        hold off;
        legend('\alpha', '\beta')
        title(sprintf('Interval Edges [α_k, β_k] %s - k Number of repetitions for λ = %.0d', funcNames{j}, lambdas(i)))
    end
end
