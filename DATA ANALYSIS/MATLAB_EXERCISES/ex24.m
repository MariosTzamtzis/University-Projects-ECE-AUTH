%Exercise 2.4

clc;
clear;

%setting the bounds
low = 1;
high = 2;
%low = 0;
%high = 1;
%low = -1;
%high = 1;

n = [10 100 1e3 1e4 1e5 1e6];
numofexperiments = length(n);

%Initializing E[1/x] and 1/E[x]
a1 = zeros(numofexperiments, 1);
a2 = zeros(numofexperiments, 1);

for i = 1:numofexperiments
    x = low + (high - low) .* rand(n(i), 1);%Generating a uniform distribution of random numbers on [low,high]
    a1(i) = mean(1./x);
    a2(i) = 1/mean(x);

end

semilogx(n, a1, "blue");%plots x- and y-coordinates using a base-10 logarithmic scale on the x-axis and a linear scale on the y-axis
hold on;
semilogx(n, a2, "red");
title("E[1/X] relative to 1/E[X]");
xlabel("Sample Size");
ylabel("Mean value");
legend("E[1/X]", "1/E[X]");

% For low = 1 and high = 2,  E[1/X] != 1/E[X], 1/E[X] = 0.667 for
% big n and E[1/x] = 0.693

% For low = 0 and high = 1, 1/E[X] = 2 for big n and E[1/x] != const.

% For low = -1 and high = 1, 1/E[X] = oo for big n and E[1/x] near zero 

