%Liakos Aris 10000
%Tzamtzis Marios 10038

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
index= [2 3 4 5 6 7 8 9 10];
names = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG"];
d = dictionary(index,names);
p=NaN(9,2);
for i=2:10
    [p(i-1,1),p(i-1,2)]= Group4Exe3Fun1(v(:,1),v(:,i));
    fprintf("%s:\np1=%.3f\np2=%.3f\n",d(i),p(i-1,1),p(i-1,2));
    if p(i-1,1) > 0.05
        fprintf("According to t-test there is a difference between the 2 means(p>0.05) in the %s\n",d(i));
    end
    if p(i-1,2) > 0.05
        fprintf("According to Bootstrap test there is a difference between the 2 means(p>0.05) in the %s\n",d(i));
    end
    fprintf('\n');
end

[~,index] = max(p(:,1));
[~,index2] = max(p(:,2));
fprintf("According to t-test the biggest difference between the 2 means is in the %s\n",d(index+1));
fprintf("According to Bootstrap test the biggest difference between the 2 means is in the %s\n",d(index2+1));