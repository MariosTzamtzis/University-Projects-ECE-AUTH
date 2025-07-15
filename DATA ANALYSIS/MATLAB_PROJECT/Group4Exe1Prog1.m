%Liakos Aris 10000
%Tzamtzis Marios 10038

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
index= [1 2 3 4 5 6 7 8 9 10 11];
names = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG" "TN" "GR"];
d = dictionary(index,names);
v(:, 1) = [];

for i=1:11
    p = Group4Exe1Fun1(v(:,i),d(i));
end


