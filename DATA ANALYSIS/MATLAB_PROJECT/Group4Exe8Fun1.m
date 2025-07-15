%Liakos Aris 10000
%Tzamtzis Marios 10038

function [R2adj, p] = Group4Exe8Fun1(X, Y, d)
    [X, Y, n] = clearNaN(X,Y);

    %Y = aexp(-bX)

    mdl = polyfit(X, log(Y),1);
    x0 = linspace(min(X), max(X), 100)';
   
    y0pred = polyval(mdl, x0);
    e = log(Y) - [X ones(n,1)]*mdl';    
    R2adj = 1-((n-1)/(n-2))*(sum(e.^2))/(sum((log(Y)-mean(log(Y))).^2));
    figure();
    scatter(X,log(Y),12,'blue','filled');
    title(sprintf('y = aexp(-bx) and r^2=%.3f', ...
        R2adj));
    hold on;
    plot(x0,y0pred,'LineWidth',2);
    xlabel(d);
    ylabel('FG');

    L = 1000;
    
    R2adjPerm = NaN(L,1);
    for i=1:L
        Y = Y(randperm(n));
        mdlPermutated = polyfit(X, log(Y),1);
        e = log(Y) - [X ones(n,1)]*mdlPermutated';
        R2adjPerm(i) = 1-((n-1)/(n-2))*(sum(e.^2))/(sum((log(Y)-mean(log(Y))).^2));
    end

    p = sum(R2adjPerm>=R2adj)/L;

end