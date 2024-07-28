%Liakos Aris 10000
%Tzamtzis Marios 10038


function [R2, choice] = Group4Exe7Fun1(v1,v2,d)
    r2adj=NaN(4,1);       
    T1 = isnan(v1);
    v1(T1) = [];
    v2(T1) = [];
    T2 = isnan(v2);
    v1(T2) = [];
    v2(T2) = [];
    n = length(v1);

    p1 = polyfit(v1, v2,1); 
    p2 = polyfit(v1, v2,2); 
    p3 = polyfit(v1, v2,3); 
    p4 = polyfit(v1, log(v2),1);


    v10 = linspace(min(v1),max(v1),100)';

    v2Pred = [polyval(p1, v10) polyval(p2, v10) polyval(p3, v10) polyval(p4, v10)];

    
    figure();
    for i = 1:4
        subplot(2,2,i);
        %scatter plot
        if i<4
            switch i
                case 1
                    e = v2 - [v1 ones(n,1)]*p1';
                case 2
                    e = v2 - [v1.^2 v1 ones(n,1)]*p2';
                case 3
                    e = v2 - [v1.^3 v1.^2 v1 ones(n,1)]*p3';
            end
            r2adj(i) = 1 - ((n-1)/(n-i-1))*sum(e.^2)/sum((v2 - mean(v2)).^2);
            scatter(v1,v2,12,"blue","filled");
            hold on;
            title(sprintf("Order %d and r^2=%.3f",i, abs(r2adj(i))));
            plot(v10,v2Pred(:,i),'LineWidth',2);
        else
            e = log(v2) - [v1 ones(n,1)]*p4';
            r2adj(i) = 1 - ((n-1)/(n-2))*sum(e.^2)/sum((log(v2) - mean(log(v2))).^2);
            scatter(v1,log(v2),12,"blue","filled");
            hold on;
            title(sprintf("Expontential and r^2=%.3f", abs(r2adj(i))));
            plot(v10,v2Pred(:,i),'LineWidth',2);

        end
        xlabel(d);
        ylabel('FG');
        grid on;
    end
    
   [R2,choice] = max(r2adj);

end