clear;
close all;


lambda = 1e-4;% Constant search range
epsilon = 1e-6;

f = @(x) exp(-2 * x) + (x - 2)^2;
fmin = fminsearch(f,0);
fprintf("\nThe minimum of f1 is: %.7f\n", fmin);
[k1, x1, x2] = bisection(epsilon, lambda, 0, 3, f);
fprintf("\nThe Bisection Method has final interval [%.8f,%.8f] after %d repetitions with range of interval = %.2e\n",x1(end),x2(end),k1, x2(end)-x1(end))
[k2, x3, x4] = goldenSection(lambda, 0, 3, f);
fprintf("\nThe Golden Section Method has final interval [%.8f,%.8f] after %d repetitions with range of interval = %.2e\n",x3(end),x4(end),k2,x4(end)-x3(end))
[k3, x5, x6] = fib(lambda, lambda/10, 0, 3, f);
fprintf("\nThe Fibonacci Method has final interval [%.8f,%.8f] after %d repetitions with range of interval = %.2e\n",x5(end),x6(end),k3,x6(end)-x5(end))
[k4, x7, x8] = difBisection(lambda, 0, 3, f);
fprintf("\nThe Differential Bisection Method has final interval [%.8f,%.8f] after %d repetitions with range of interval = %.2e\n",x7(end),x8(end),k4,x8(end)-x7(end))

