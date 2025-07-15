%Liakos Aris 10000
%Tzamtzis Marios 10038

function [pParam,pBoot]= Group4Exe3Fun1(v1,v2)
    %v1(isnan(v2)) = [];
    v2(isnan(v2)) = [];
    r=0;
    for i=2:length(v1)
        if v1(i) ~= v1(i-1) + 1
            r = i;
            break
        end
    end

    if r == 0
        fprintf('ERROR\n');
        return;
    end

    v21 = v2(1:r-1);
    v22 = v2(r:end);

    X = v21 - mean(v21);
    Y = v22 - mean(v22);
 

    meanDiff = mean(v21) - mean(v22);

    % i: Parametric 95% Confidence Interval
    [~,pParam] = ttest2(v21, v22);

    
    %ii: Bootstrap Method
    B = 1000;
    
    bootV21 = bootstrp(B, @mean, v21);
    bootV22 = bootstrp(B, @mean, v22);
    bootZ =  

    pBoot = sum(bootZ>=meanDiff(v21,v22))/B;

end