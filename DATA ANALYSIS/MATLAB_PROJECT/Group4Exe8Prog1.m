%Liakos Aris 10000
%Tzamtzis Marios 10038

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
v(:,11) = [];
v(:, 1) = [];
index= [1 2 3 4 5 6 7 8 9 10];
names = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG" "GR"];
d = dictionary(index,names);
p = NaN(9,1);
r2arr = NaN(9,1);
for i=1:10
    if (i==9)
        continue;
    end
    [r2arr(i), p(i)] = Group4Exe8Fun1(v(:,i), v(:,9),d(i));
end

[~,index] = max(r2arr);
fprintf("The indicator with the greatest R2adj with FG was %s and r2adj = %.3f and p-value=%.3f\n", ...
    d(index), max(r2arr), p(index));

%As we can see when indicator T is the independent variable that has the
%greatest r2adj with FG and p-value equals to 0 (p<0.05). So if we choose an indicator, it's better be that.
%However 0.252 is not a "good" value.