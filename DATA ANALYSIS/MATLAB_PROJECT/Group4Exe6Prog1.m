%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
v(:, 11) = []; %Erase TN
v(:, 1) = []; %Erase Years
r2arr = NaN(20,3);

keys = 1:10;
names = ["T" "TM" "Tm" "PP" "V"	"RA" "SN" "TS" "FG" "GR"];
d = dictionary(keys, names);

%Let i be the dependent and j the independent
for i=1:10
    figure();
    k = 1;
    r2temp = NaN(9,2);
    for j=1:10
        if (i==j)
            continue;
        else
            subplot(3,3,k);
            r2temp(k,2) = Group4Exe6Fun1(v(:,j), v(:,i), d(j), d(i));
            r2temp(k,1) = j;
            k = k + 1;
        end
    end
    r2temp = sort(r2temp,'descend');
    r2arr(2*(i-1) + 1,1) = i;
    r2arr(2*i,1) = i;
    r2arr(2*(i-1) + 1,2:end) = r2temp(1,:);
    r2arr(2*i,2:end) = r2temp(2,:);
end

clear r2temp;

for i=1:10
    fprintf("For the dependent variable %s the greatest r2 was for %s and %s, r2 = %.4f and %.4f respectively." ...
        , d(i), d(r2arr(2*(i-1) + 1,2)), d(r2arr(2*i,2)), r2arr(2*(i-1)+1,3), r2arr(2*i,3));
    fprintf("\n");
end

%As the greatest r2 was when the dependent variable was T and independent
%GR (0.95948) and for TM and GR respectively as well.




        
