clear;
close all;

lambdas = [1e-8, 1e-5, 1e-2]; % Final search range values

% Define the functions
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

funArray = {f1, f2, f3}; % Store functions in a cell array
subPlotPositions = {1, 2, [3, 4]}; 
funcNames = {'f_1(x)', 'f_2(x)', 'f_3(x)'}; % Function names

% Loop through each function
for j = 1:length(funArray)
    f = funArray{j}; % Extract the function
    figure;
    
    % Loop through each value of lambda
    for i = 1:length(lambdas)
        % Apply the Golden Section Method for the current function and lambda
        [k, as, bs] = goldenSection(lambdas(i), 0, 3, f);
        
        % Plot the interval edges [ak, bk] against the number of repetitions (k)
        subplot(2, 2, subPlotPositions{i});
        plot(1:k, as);
        hold on;
        plot(1:k, bs);
        xlabel('k number of repetitions')
        ylabel('Interval edges [\alpha_k, \beta_k]')
        hold off;
        legend('\alpha', '\beta')
        title(sprintf('Interval edges [α_k, β_k] %s - k number of repetitions for λ = %.0s', funcNames{j}, lambdas(i)))
    end
end
