%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

clc;
clear;


data = readmatrix("Heathrow.xlsx");
X = data(:,2);
Y = data(:,4);

func(X,Y);

function [n, p, I] = func(X1, X2)
    
    [X, Y, n] = clearNaN(X1, X2);

    %Discretization
    medianX = median(X);
    medianY = median(Y);
    for i=1:n
        if (X(i)<medianX)
            X(i) = 0;
        else
            X(i) = 1;
        end
        if (Y(i)<medianY)
            Y(i) = 0;
        else
            Y(i) = 1;
        end
    end
[pmf_X, ~] = histcounts(X, 'Normalization', 'probability');
[pmf_Y, ~] = histcounts(Y, 'Normalization', 'probability');

H_X = -sum(pmf_X.*log(pmf_X));
H_Y = -sum(pmf_Y.*log(pmf_Y));

X_Y = [X Y];
[counts, ~] = hist3(X_Y, [2 2]);
joint_pmf = counts(:)/n;

H_XY = -sum(joint_pmf.*log(joint_pmf));

I = H_X + H_Y - H_XY;

[IrandPerm, L] = Group4Exe5Fun2(X, Y, n);

p = sum(IrandPerm>=I)/L;



end