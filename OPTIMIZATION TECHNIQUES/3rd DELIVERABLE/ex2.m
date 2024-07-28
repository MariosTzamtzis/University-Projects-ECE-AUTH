% Clear workspace, close figures, and clear command window
close all; 
clear;
clc;

% Define symbolic variables
syms x y

% Define the function
f(x,y) = 1/3 * x ^ 2 + 3 * y ^ 2;

% Choose a point and steps for each algorithm
point = [5 -5];
sk = 5; % Steady step
gk = 0.5; % Gradient step size
epsilon = 0.01; % Convergence tolerance

% Perform steepest descent projection
[x1, y1, k] = steepestDescProjection(f, point, gk, sk, epsilon);
F1 = f(x1, y1);

% Plot the function contour and the steepest descent path
figure(1)
fcontour(f)
hold on
plot(x1, y1, '-ok', 'LineWidth', 1, 'MarkerSize', 5);
title("Steepest Descent Projection for stepS: " + sk + " and stepG: " + gk + ". Starting Point: [" + point(1) + " " + point(2) + "]");
xlabel("x1"); ylabel("x2");

% Plot the convergence of the objective function over iterations
figure(2)
plot(F1);
xlabel('Repetitions'); ylabel('f(xk,yk)'); 
title("Steepest Descent Projection. StepS: " + sk + ". StepG: " + gk + ". Starting Point: [" + point(1) + " " + point(2) + "]");

% Display the number of iterations
K = sprintf('\nk = %d iterations\n', k);
disp(K);
