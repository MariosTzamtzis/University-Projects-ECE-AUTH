%Liakos Aris 10000
%Tzamtzis Marios 10038

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
index= [2 3 4 5 6 7 8 9 10];
names = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG"];
d = dictionary(index,names);

c=NaN(9,4);
for i=2:10
    [ci, bootCI] = Group4Exe2Fun1(v(11:end,i));
    meanIndex = mean(v(1:10,i));
    if meanIndex>ci(1) && meanIndex<ci(2)
        fprintf('The sample mean value of %s for the years 1949-1958 is inside the parametric confidence interval of mean value for the years 1973-2017.\n', d(i));
    else
        fprintf('The sample mean value of %s for the years 1949-1958 is not inside the parametric confidence interval of mean value for the years 1973-2017.\n', d(i));
    end
    if meanIndex>bootCI(1) && meanIndex<bootCI(2)
        fprintf('The sample mean value of %s for the years 1949-1958 is inside the Bootstrap confidence interval of mean value for the years 1973-2017.\n', d(i));
    else
        fprintf('The sample mean value of %s for the years 1949-1958 is not inside the Bootstrap confidence interval of mean value for the years 1973-2017.\n', d(i));
    end
    fprintf('\n');
end

%COMMENT:
%As we can see the two testings bring the same results.
%Mean of period 1949 - 1958 is NOT included for T, Tm, PP, V, RA, SN, TS,
%FG

