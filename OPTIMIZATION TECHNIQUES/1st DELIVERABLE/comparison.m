clear;
close all;

epsilon = 1e-6;

n = 100;

f1 = @(x) (x - 1)^3 + (x - 4)^2 * cos(x);
syms x;
f1sym = (x - 1)^3 + (x - 4)^2 * cos(x);

figure;
xlabel('\lambda, predetermined accuracy');
ylabel('k, number of repetitions')
title('k number of repetitions - \lambda predetermined accuracy for \epsilon = 1e-6');
hold on;

lambdas = linspace(2*epsilon + 1e-6, 1e-1, n);
ks = ones(1,n);

for i = 1:n 
        [k, as, bs] = bisection(epsilon, lambdas(i), 0, 3, f1);
        ks(i) = k;
end
plot(lambdas, ks, '--ok');
ks = ones(1,n);
for i = 1:n 
        [k, as, bs] = goldenSection(lambdas(i), 0, 3, f1);
        ks(i) = k;
end
plot (lambdas, ks, '-or');
ks = ones(1,n);
for i = 1:n 
        [k, as, bs] = fib(lambdas(i),epsilon, 0, 3, f1);
        ks(i) = k;
end
plot (lambdas, ks, '-og');
ks = ones(1,n);
for i = 1:n 
        [k, as, bs] = difBisection(lambdas(i), 0, 3, f1sym);
        ks(i) = k;
end
plot(lambdas,ks, '-ob');
legend('Bisection Method', 'Golden Section Method', 'Fibonacci Method', 'Differential Bisection Method');