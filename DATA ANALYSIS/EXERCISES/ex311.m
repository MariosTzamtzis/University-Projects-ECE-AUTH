clc;
clear;

% Data from the X variable
M = 100;    
n = 10;        
meanX = 0;
varX = 1;
X = normrnd(meanX, sqrt(varX), n, M);
muX = mean(X);
stdX = std(X);

% Data from the Y variable
m = 12;       
meanY = 0;
varY = 1;
Y = normrnd(meanY, sqrt(varY), m, M);
muY = mean(Y);
stdY = std(Y);

h = ttest2(X,Y);
XY = [X; Y];

B = 1000;
diffBoot = bootstrp(B, @diff, XY);
diffRand = NaN(B,M);
meanDiff = mean(X) - mean(Y);

for i=1:B
    samples = NaN(n+m, M);
    for j=1:M
        samples(:, j) = XY(randperm(n+m), j);
    end
    diffRand(i, :) = diff(samples);
end

hBoot = find_h(diffBoot, meanDiff, M, B); %Rejections in bootstrap sampling
hRand = find_h(diffRand, meanDiff, M, B);%Rejections in Random Permutation

fprintf("Rejections in parametric is: %.3f%%\nRejections in Bootstrap Sampling is: %.3f%%\n" + ...
    "Rejections in Random Permutation is: %.3f%%\n", sum(h)/M*100, hBoot/M*100, hRand/M*100);

function diff = diff(temp)
    global n m
    diff = mean(temp(1:n, :)) - mean(temp(n+1:n+m, :));
end

function h = find_h(samples, meanDiff, M, B)
    arr = [samples; meanDiff];
    sorted_samples = sort(arr);
    rejection = 0;
    for k=1:M
        r = find(sorted_samples(:,k) == meanDiff(k));
        if length(r) == B+1
            r = round((B+1)/2); %If all distributions are identical, i choose the middle one.
        elseif length(r)>=2 %If at least two bootstrap statistics are identical
            r = r(unidrnd(length(r))); %Choose randomly an identical distribution
        end        
        if r < (B+1)*0.05/2 || r > (B+1)*(1-0.05/2)
            rejection = rejection + 1;
        end
    end
    h = rejection;
end

