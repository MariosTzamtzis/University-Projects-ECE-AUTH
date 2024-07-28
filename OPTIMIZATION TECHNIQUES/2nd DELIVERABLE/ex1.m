clear;
close all;

syms x1 x2;  % Define symbolic variables x1 and x2

% Define the function f(x, y) = x^3 * e^(-x^2 - y^4)
f = (x1^3) * exp(-x1^2 - x2^4);

% Create a new figure for plotting
figure;

% Generate a 3D surface plot of the function f(x, y)
fsurf(f, 'ShowContours', 'on');

% Set the title and axis labels for the plot
title('Graphical Representation of f(x, y)');
xlabel('x');
ylabel('y');
zlabel('f');

% Display a box around the plot
box on;
