clc;
clear;

%X~(4,0.01)
limit = 3.9;
mean = 4;
sigma = sqrt(0.01);

%Destroying Probability P(x<3.9)
p = normcdf(limit,mean,sigma);
%DestroyingProb = p(2) - p(1);
fprintf("The probability of a rail(<3.9m) being destroyed is %f.\n", p);

%P(x<a)=0.01
p2 = 0.01;
limit2 = norminv(p2,mean,sigma);
fprintf("The lowest limit of length is %f.\n", limit2);


