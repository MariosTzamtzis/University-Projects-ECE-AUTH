clear;
close all;

n = 100;
lambdas = linspace(1e-8, 1e-5, n); % Generating a range of lambda values

% Define the functions. These functions are defined symbolically allowing
% differentation
syms x;
f1 = (x - 1)^3 + (x - 4)^2 * cos(x);
f2 = exp(-2 * x) + (x - 2)^2;
f3 = (x^2) * log(0.5 * x) + sin((0.2 * x)^2);

figure;
xlabel('\lambda, predetermined accuracy');
ylabel('k, number of repetitions')
title('k number of repetitions - \lambda predetermined accuracy');
hold on;

funArray = {f1, f2, f3};
flags = {'-k', '--og', ':*b'};

%Loop over each function
for funci = 1:length(funArray)
    f = funArray{funci};
    flag = flags{funci}; % Select a plot style for each function
    
    ks = ones(1, n); % Initialize an array to store the number of repetitions
    
    %Loop over different lambda values
    for i = 1:n 
        [k, as, bs] = difBisection(lambdas(i), 0, 3, f); % Apply difBisection method
        ks(i) = k; % Store the number of repetitions for the current lambda
    end
    
    % Plot the results for each function and lambda
    plot(lambdas, ks, flag);
end

legend('f_1(x)', 'f_2(x)', 'f_3(x)')
