clear;
close all;

epsilon = 1e-6;
n = 100;
lambdas = linspace(2 * epsilon + 1e-6, 1e-1, n); % Define the range for lambdas

% Define the functions
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

% Create a plot to visualize the results
figure;
xlabel('\lambda, predetermined accuracy');
ylabel('k, number of repetitions')
title('k number of repetitions - \lambda predetermined accuracy for \epsilon = 1e-6');
hold on;

funArray = {f1, f2, f3};
flags = {'-k', '--og', ':*b'};

for funci = 1:length(funArray)
    f = funArray{funci}; % Select a function from the list
    flag = flags{funci}; % Define the plot style

    ks = ones(1, n); % Initialize an array to store the number of repetitions
    
    % Loop over different lambda values
    for i = 1:n 
        [k, as, bs] = fib(lambdas(i), epsilon, 0, 3, f); % Apply Fibonacci method
        ks(i) = k; % Store the number of iterations
    end
    
    % Plot the results for the specific function
    plot(lambdas, ks, flag);
end

legend('f_1(x)', 'f_2(x)', 'f_3(x)')
