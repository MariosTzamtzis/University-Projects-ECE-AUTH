%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

%This function implements random permutation.
function [IrandPerm, L] = Group4Exe5Fun2(X,Y,n)
   L = 1000;
   IrandPerm = NaN(L,1);
   for i=1:L
       Y = Y(randperm(n));
       [pmf_X, ~] = histcounts(X, 'Normalization', 'probability');
       [pmf_Y, ~] = histcounts(Y, 'Normalization', 'probability');

       H_X = -sum(pmf_X.*log(pmf_X));
       H_Y = -sum(pmf_Y.*log(pmf_Y));
    
       X_Y = [X Y];
       [counts, ~] = hist3(X_Y, [2 2]);
       joint_pmf = counts(:)/n;

       H_XY = -sum(joint_pmf.*log(joint_pmf));
    
       IrandPerm(i) = H_X + H_Y - H_XY;
   end