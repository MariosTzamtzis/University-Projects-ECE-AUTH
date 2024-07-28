clear;
close all;

lambdas = [1e-6, 1e-4, 1e-2];
epsilon = 1e-7;

% Define the functions
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

funArray = {f1, f2, f3};
subPlotPositions = {1, 2, [3, 4]};
funcNames = {'f_1(x)', 'f_2(x)', 'f_3(x)'};

% Loop over each function
for j = 1:length(funArray)
    f = funArray{j};
    figure;
    
    % Loop over each lambda value
    for i = 1:length(lambdas)
        % Apply Fibonacci search method for the given function and lambda
        [k, as, bs] = fib(lambdas(i), epsilon, 0, 3, f);
        subplot(2, 2, subPlotPositions{i});
        plot(1:k+1, as);
        hold on;
        plot(1:k+1, bs);
        xlabel('k Number of repetitions')
        ylabel('Interval edges [\alpha_k, \beta_k]')
        hold off;
        legend('\alpha', '\beta')
        title(sprintf('Interval edges [α_k, β_k] %s - k number of repetitions for λ = %s', funcNames{j}, num2str(lambdas(i))))
    end
end

