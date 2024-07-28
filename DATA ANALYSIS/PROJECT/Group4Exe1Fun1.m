%Liakos Aris 10000
%Tzamtzis Marios 10038

function [p1,p2] = Group4Exe1Fun1(v,d)
v(isnan(v)) = [];
%alpha=0.05;
figure();
if length(unique(v))>10
    histfit(v)
    [~,p1] = chi2gof(v);
    
    [~,p2] = chi2gof(v,'CDF',@(z)unifcdf(z,min(v),max(v)));
    title(sprintf("%s: p-value for normal distribution = %.3f\n and p-value for uniform distribution=%.3f",d,p1,p2));

    if p1<p2
        fprintf('The %s is considered continuous and follows normal distribution.\n',d);
    else
        fprintf('The %s is considered continuous and follows uniform distribution.\n',d);
    end

else
    bar(v)
    prob = 0.95;
    pd2 = makedist('Binomial', 'N', 100, 'p', prob);
    n = max(v) - min(v) + 1; % number of possible values in the distribution
    expectedFrequency = ones(1,n) * (1/n); % expected frequency for each value in the distribution

    [~,p1,~] = chi2gof(v,'Frequency',expectedFrequency);
    [~,p2,~] = chi2gof(v,'CDF',pd2);
    title(sprintf("%s: p-value for binomial distribution = %.3f\n p-value for discrete uniform distribution=%.3f",d,p1,p2));
    
    if p1<p2
        fprintf('The %s is considered discrete and follows binomial distribution.\n',d);
    else
        fprintf('The %s is considered discrete and follows discrete uniform distribution.\n',d);
    end

end
