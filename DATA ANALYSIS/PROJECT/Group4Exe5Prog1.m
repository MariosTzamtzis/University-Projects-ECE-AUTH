%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

clear;
close all;
clc;

data = readmatrix("Heathrow.xlsx");
data(:,1) = [];

for i=4:6
    X1 = data(:, 1);
    X2 = data(:, i);
    [n, X, Y] = Group4Exe5Fun2(X1, X2);
    clear X1 X2;
    
    r = corrcoef(X, Y);
    r = r(1,2);
    t = r * sqrt((n - 2) / (1 - r^2)); % t-statistic
    p = 2 * tcdf(-abs(t), n - 2); % two-tailed p-value

end