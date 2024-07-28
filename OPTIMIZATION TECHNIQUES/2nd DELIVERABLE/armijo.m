function [gamma] = armijo(s, a, b,xk, dk,f)
%syms x1 x2;

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

jac = inline(jacobian(f));
jacx = @(x) jac(x(:,1), x(:,2));

mk = 1e-12;
gamma = s*(b^mk);

jacT = transpose(jacx(xk));
D = dk*jacT;

while fx(xk) - fx(xk+gamma*dk) < -a*s*(b^mk)*D
    mk = mk + 1;
    gamma = s*(b^mk);
end

 end

