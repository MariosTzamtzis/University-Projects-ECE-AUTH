clear;
close all;

epsilon = 1e-3; % Distance from bisector
n = 100; % Number of repetitions

% Range of predetermined accuracy (lambda) values
lambdas = linspace(2 * epsilon + 1e-6, 1e-1, n);

% Define three different functions: f1, f2, f3
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

figure;
xlabel('\lambda, predetermined accuracy');
ylabel('k, number of repetitions')
title('k number of repetitions - \lambda predetermined accuracy for \epsilon = 0.001');
hold on;

% Function array holding the functions and line styles for plotting
funArray = {f1, f2, f3};
flags = {'-k', '--og', ':*b'};

% Loop through each function in the function array
for funci = 1:length(funArray)
    f = funArray{funci};
    flag = flags{funci};
    ks = ones(1, n); % Array to store repetition counts for each lambda

    % Loop through each lambda value
    for i = 1:n 
        % Call the bisection method for the current function and lambda value
        [k, ~, ~] = bisection(epsilon, lambdas(i), 0, 3, f);
        ks(i) = k; % Store the number of repetitions for this lambda
    end

    % Plot the number of iterations vs. lambda for each function
    plot(lambdas, ks, flag);
end

legend('f_1(x)', 'f_2(x)', 'f_3(x)');
