clc;
clear;

nV = [10 100 1e3 1e4 1e5 1e6];
nE = length(nV);
tailsFrequency = zeros(nE,1);

for i=1 : nE
    flips = unidrnd(2,nV(i),1);
    numOfTails = length(flips(flips==1));
    tailsFrequency(i) = numOfTails / nV(i);
    fprintf('%d coin flips: %f.\n', nV(i),tailsFrequency(i));
end

plot(log10(nV), tailsFrequency);
xlabel('Number of repetitions (log10)');
ylabel('Probaility of tails');
title('Probability of a binary outcome');
