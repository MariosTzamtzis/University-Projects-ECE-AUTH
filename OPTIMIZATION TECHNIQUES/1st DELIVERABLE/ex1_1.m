clear;
close all;


lambda = 1e-2;% Constant search range
n = 100;% Number of repetitions

% Define three functions: f1, f2, f3
f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = @(x) exp(-2 * x) + (x - 2)^2;
f3 = @(x) (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

% Set up a figure for plotting
figure;
xlabel('\epsilon, distance from bisector');
ylabel('k, number of repetitions')
title('k number of repetitions - \epsilon distance from bisector for l = 0.01');
hold on;% Ensure multiple plots are shown on the same figure

% Define function array with functions and line styles
funArray = {f1, f2, f3};
flags = {'-k', '--og', ':*b'};

% Generate values for the distance from the bisector (epsilon)
epsilon = linspace(1e-6, lambda/2 - 1e-6, n);

% Loop over each function in the function array
for funci = 1:length(funArray)
    f = funArray{funci};
    flag = flags{funci};
    ks = ones(1, n);% Array to store repetition counts for each epsilon value
    % Loop over each epsilon value
    for i = 1:n
        % Call the bisection method for the current function and epsilon value
        [k, x1, x2] = bisection(epsilon(i), lambda, 0, 3, funArray{funci});
        ks(i) = k;% Store the number of repetitions for this epsilon
    end
    % Plot the number of iterations vs. epsilon for each function
    plot(epsilon, ks, flag);
end

legend('f_1(x)', 'f_2(x)', 'f_3(x)')