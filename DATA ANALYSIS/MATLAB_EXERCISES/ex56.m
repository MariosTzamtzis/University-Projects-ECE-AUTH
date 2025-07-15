clc;
clear;
close all;

% Data
X = [2 3 8 16 32 48 64 80]';                        % distance
Y = [98.2 91.7 81.3 64.0 36.4 32.6 17.1 11.3]';     % percentage
n = length(X);
alpha = 0.05;

% a : scatter plot, linear regression model and diagnostic plot
r = corrcoef(X,Y);
r = r(1,2);
fprintf('Correlation coefficient: %.3f\n',r);

b = regress(Y,[ones(n,1) X]);% Linear regression model using least squares method
fprintf('Linear regression model: y = ax + b -> Y = %.4f X + %.4f\n', ...
    b(2),b(1));
x0 = linspace(min(X),max(X),100)';
y0 = b(2)*x0 + b(1);
figure();
scatter(X,Y,12,'blue','filled');
title(sprintf('Km driven in relation to Percentage usable: r=%.3f', r));
hold on;
plot(x0,y0,'LineWidth',2);
xlabel('Km driven');
ylabel('Percentage usable');

e = Y - [ones(n,1) X] * b;
se = sqrt((1/(n-2))*(sum(e.^2)));
estar = e./se;
figure();
scatter(Y,estar,12,'blue','filled');
hold on;
yline(1.96,'r-.');
yline(-1.96,'r-.');
xlabel('Percentage usable');
ylabel('Standardized adjustment error');
title('Diagnostic plot');

%Y = ae^(-X*b)
lnY = log(Y);
[bLn, bint] = regress(lnY, [ones(n,1) X]);
seln = sqrt((n-1)/(n-2)*(var(lnY)-bLn(2)^2*var(X)));
e_ln = lnY - [ones(n,1) X]*bLn;
e_ln_star = e_ln./seln;
fprintf(['Ln-transformed linear regression model ' ...
    'y = ln(a) + bx -> y = %.3f + (%.3f)x\n'],bLn(1),bLn(2));
lny0 = bLn(2)*x0 + bLn(1);
figure();
scatter(X,lnY,12,'blue','filled');
title(sprintf('Distance and Ln Sufficiency=%.3f+(%.3f)x', ...
    bLn(1),bLn(2)));
hold on;
plot(x0,lny0,'LineWidth',2);
xlabel('Distance');
ylabel('Ln of Sufficiency');
grid on;
hold off;

% Diagnostic plot
figure();
scatter(lnY,e_ln_star,12,'blue','filled');
hold on;
yline(1.96,'r-.');
yline(-1.96,'r-.');
xlabel('Ln of sufficiency');
ylabel('Standardized adjustment error');
title('Diagnostic plot of ln linear regession');
grid on;
hold off;

% b : Sufficiency Y for X = 25
a = exp(bLn(1));
b = bLn(2);
fprintf('Exponential model: y = %.3f exp(%.3fx)\n',a,b);
y0 = a*exp(b*x0);
figure();
scatter(X,Y,12,'blue','filled');
title('Distance and Sufficiency');
hold on;
plot(x0,y0,'LineWidth',2);
xlabel('Distance');
ylabel('Sufficiency');
text(mean(X),mean(Y),sprintf('y = %.3f exp(%.3fx)',a,b));
grid on;
hold off;
x = 25;
y = a*exp(b*x);
fprintf('Sufficiency for x = %dkm: y = %.4f\n',x*1000,y);