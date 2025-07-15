%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}


function r2 = Group4Exe6Fun1(X1,X2, d1, d2)

    %Clear NaN elements
    T1 = isnan(X1);
    X1(T1) = [];
    X2(T1) = [];
    T2 = isnan(X2);
    X1(T2) = [];
    X2(T2) = [];
    X = X1;
    Y = X2;
    clear T1 T2 X1 X2;

    n = length(X);

    b = regress(Y, [ones(n,1) X]);

    % Calculate predicted values of Y
    predictedY = [ones(size(X)), X] * b;
    
    % Calculate residuals
    residuals = Y - predictedY;
    
    % Calculate total sum of squares
    SST = sum((Y - mean(Y)).^2);
    
    % Calculate residual sum of squares
    SSE = sum(residuals.^2);
    
    % Calculate R-squared
    r2 = 1 - (SSE/SST);
   
    % Create scatter plot    
    scatter(X, Y, 12, 'blue', 'filled');    
    hold on;
    
    % Plot the estimated line
    x0 = linspace(min(X), max(X), 100)';
    y0 = b(1) + b(2)*x0;
    line(x0, y0,'Color','red','LineWidth',2)
    xlabel(d1);
    ylabel(d2);
    
    % Add R-squared value to chart
    title(['R^2 = ', num2str(r2)])
    grid on;


end
