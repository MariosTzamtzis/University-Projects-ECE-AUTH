%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

function [n, fisherCI, bootCI, pParam, pNonParam] = Group4Exe4Fun1(X1,X2)

    %Clear NaN elements
    T1 = isnan(X1);
    X1(T1) = [];
    X2(T1) = [];
    T2 = isnan(X2);
    X1(T2) = [];
    X2(T2) = [];  
    clear T1 T2;

    n = length(X1); %RETURN
    
    rcoef = corrcoef(X1, X2);
    rcoef = rcoef(1,2);

    %b1: Confidence Interval 
    % for correlation coefficient using fisher method
    z = 0.5*log((1+rcoef)/(1-rcoef));
    se = 1/sqrt(n-3);
    alpha = 0.05;
    z_l = z - norminv(1-alpha/2)*se;
    z_u = z + norminv(1-alpha/2)*se;
    r_l = (exp(2*z_l) - 1)/(exp(2*z_l) + 1);
    r_u = (exp(2*z_u) - 1)/(exp(2*z_u) + 1);
    fisherCI = [r_l, r_u];
    
    clear r_l r_u;


    %b2: Confidence Interval using Bootstrap Method
    B = 1000; %Number of resamples
    rco_resamples  = NaN(B, 1);
    for i=1:B
        index = randi(n,n,1);
        x1Resampled = X1(index);
        x2Resampled = X2(index);
        rcoTemp = corrcoef(x1Resampled, x2Resampled);
        rco_resamples(i) = rcoTemp(1,2);
    end
    lowLim = prctile(rco_resamples, 2.5);
    upLim = prctile(rco_resamples, 97.5);
    
    bootCI = [lowLim, upLim]; %RETURN
    
    clear lowLim upLim rco_resamples x1Resampled x2Resampled index rcoTemp;

    %c1: Parametric testing
    [~, pParam] = corr(X1, X2);

    %c2: Non-Parametric
    rco_permutations = NaN(n, 1);
    for i = 1:B
        permuted_indices = randperm(n);
        X2_permuted = X2(permuted_indices);
        rcoTemp = corrcoef(X1,X2_permuted);
        rco_permutations(i) = rcoTemp(1,2);
    end    
    
    pNonParam = (sum(rco_permutations)>= rcoef)/B;        
       
end


