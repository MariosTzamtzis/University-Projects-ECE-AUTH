clear;
close all;

lambdas = [1e-8, 1e-5, 1e-2]; % Define a set of predetermined accuracies

% Define the functions. These functions are defined symbolically allowing
% differentation
syms x;
f1 = (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = exp(-2 * x) + (x - 2)^2;
f3 = (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

funArray = {f1, f2, f3}; % Store functions in an array
subPlotPositions = {1, 2, [3, 4]}; % Define subplot positions
funcNames = {'f_1(x)', 'f_2(x)', 'f_3(x)'}; % Names of functions

%Loop over each function
for j = 1:length(funArray)
    f = funArray{j}; % Select a function
    
    % Create a new figure for each function
    figure;
    
    %Loop over different lambda values
    for i = 1:length(lambdas)
        % Perform difBisection method for the current function and lambda
        [k, as, bs] = difBisection(lambdas(i), 0, 3, f);
        
        % Create subplots for different lambdas
        subplot(2, 2, subPlotPositions{i});
        plot(1:k, as); % Plot interval edges (alpha)
        hold on;
        plot(1:k, bs); % Plot interval edges (beta)
        xlabel('k number of repetitions')
        ylabel('Interval edges [\alpha_k, \beta_k]')
        hold off;
        legend('\alpha', '\beta')
        title(sprintf('Interval edges [α_k, β_k] %s - k number of repetitions for λ = %s', funcNames{j}, lambdas(i)))
    end
end
