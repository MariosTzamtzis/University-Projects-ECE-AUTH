%Liakos Aris 10000
%Tzamtzis Marios 10038

function [ci, bootCI] = Group4Exe2Fun1(v)
    v(isnan(v)) = []; %If NaN elements are included we get wrong results. 
    [~,~,ci] = ttest(v);  

    B = 1000;       % number of bootstrap samples
    bootCI = bootci(B, @mean, v); 

end


