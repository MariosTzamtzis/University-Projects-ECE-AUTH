clc;
clear;

numOfVars = 100;
numOfSamples = 1e4;
x = rand(numOfVars, numOfSamples);%creating numOfVars-by-numOfSamples matrix of random numbers

y = mean(x);% returning a row vector containing the mean of each column

h = histfit(y);%Histogram with a distribution fit

title("Histogram of uniform mean values and plot of fitted normal distribution");
xlabel("Mean value");
legend("Y distribution", "Normal distribution");
