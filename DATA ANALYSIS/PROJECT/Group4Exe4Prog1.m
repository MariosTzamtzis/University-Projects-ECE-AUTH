%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

clear;
close all;
clc;

%Dictionary
keys = 1:9;
names = ["T" "TM" "Tm" "PP" "V"	"RA" "SN" "TS" "FG"];
d = dictionary(keys, names);

data = readmatrix("Heathrow.xlsx");
data(:,1) = [];

resultsFisher = NaN(36, 3);
resultsBoot = NaN(36, 3);
results_pParam = NaN(36, 4);
results_pNonParam = NaN(36, 4);

k = 1;
for i=1:8
    for j=i+1:9
        X1 = data(:, i);
        X2 = data(:, j);
        [n, fisherCI, bootCI, pParam, pNonParam] = Group4Exe4Fun1(X1,X2);
        resultsFisher(k,1) = any(0==fisherCI);
        resultsFisher(k,2:end) = [i,j];
        resultsBoot(k,1) = any(0==bootCI);        
        resultsBoot(k,2:end) = [i,j];     
        results_pParam(k,1) = (pParam<0.05);
        results_pParam(k,2) = pParam;
        results_pParam(k,3:end) = [i,j];
        results_pNonParam(k,1) = pNonParam<0.05;
        results_pNonParam(k,2) = pNonParam;
        results_pNonParam(k,3:end) = [i,j];
        k = k + 1 ;        
    end
end

sorted_pParam = sortrows(results_pParam,2);
sorted_pNonParam = sortrows(results_pNonParam,2);

first3elemParam = sorted_pParam(1:3, :);
first3elemNonParam = sorted_pNonParam(1:3, :);

fprintf("The first 3 pairs with the most significant correlation are:\n\n");
for i=1:3
    fprintf("Param: %s and %s\n", d(first3elemParam(i,3)), d(first3elemParam(i,4)));
    fprintf("NonParam: %s and %s\n", d(first3elemNonParam(i,3)), d(first3elemNonParam(i,4)));
end

resultsFisher = resultsFisher(resultsFisher(:,1)==1, :);
resultsBoot = resultsBoot(resultsBoot(:,1)==1, :);
results_pParam = results_pParam(results_pParam(:,1)==1, :);
results_pNonParam = results_pNonParam(results_pNonParam(:,1)==1, :);

%{
As we can see, when we test the null hypothesis that r = 0 using
bootstrapCI
or FisherCI, r = 0 is never inlcuded in any CI so it seems like that there is
no significant evidence of correlation between any of pairs.
When it comes to p-values, there are some pairs that p-values of parametric and not
parametric test are <0.05 and so there is evidence of correlation between
the two variables. However as we can see, the pairs that seems to have
correlation according to p-value that we get for Parametric test are not
the same with the pairts that we get for Non-Parametric test. 
%}




