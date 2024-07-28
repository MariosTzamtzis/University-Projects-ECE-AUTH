clear;
close all;

n = 100; % Number of samples
lambdas = linspace(1e-8, 1e-5, n); % Predetermined accuracy range

% Define the functions
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

% Create a new figure for plotting
figure;
xlabel('\lambda, predetermined accuracy');
ylabel('k, number of repetitions');
title('k number of repetitions - \lambda predetermined accuracy');
hold on;

funArray = {f1, f2, f3}; % Store functions in a cell array
flags = {'-k', '--og', ':*b'}; % Line styles for plotting

% Loop through each function to apply the Golden Section Method
for funci = 1:length(funArray)
    f = funArray{funci}; % Extract the function
    flag = flags{funci}; % Extract the line style for the specific function
    ks = ones(1, n); % Initialize an array to store the number of repetitions
    
    % Loop through each predetermined accuracy value (lambda)
    for i = 1 : n 
        % Apply the Golden Section Method for the current function and lambda
        [k, as, bs] = goldenSection(lambdas(i), 0, 3, f);
        ks(i) = k; % Store the number of repetitions for this lambda
    end
    
    % Plot the number of repetitions against lambda for the function
    plot(lambdas, ks, flag);
end

legend('f_1(x)', 'f_2(x)', 'f_3(x)');