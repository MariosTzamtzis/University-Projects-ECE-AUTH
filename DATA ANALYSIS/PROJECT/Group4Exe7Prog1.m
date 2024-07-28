%Liakos Aris 10000
%Tzamtzis Marios 10038

clc;
clear;
close all;

v = readmatrix("Heathrow.xlsx");
index= [2 3 4 5 6 7 8 9 12];
names = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "GR"];
d = dictionary(index,names);

for i=2:9
    [R2, choice] = Group4Exe7Fun1(v(:,i),v(:,10),d(i));
    fprintf("\nFor %s: \n", d(i));
    switch choice
        case 1
            fprintf("R2 = %.3f and 1st order Polynomial.\n", R2);
        case 2
            fprintf("R2 = %.3f and 2nd order Polynomial.\n", R2);
        case 3
            fprintf("R2 = %.3f and 3rd order Polynomial.\n", R2);
        case 4
            fprintf("R2 = %.3f and exponential.\n", R2);
    end

end
Group4Exe7Fun1(v(:,12),v(:,10),d(12));
fprintf("\nFor %s: \n", d(12));
switch choice
    case 1
        fprintf("R2 = %.3f and 1st order Polynomial.\n", R2);
    case 2
        fprintf("R2 = %.3f and 2nd order Polynomial.\n", R2);
    case 3
        fprintf("R2 = %.3f and 3rd order Polynomial.\n", R2);
    case 4
        fprintf("R2 = %.3f and exponential.\n", R2);
end

%The greatest AdjR2sqr was for RA and 2nd order polynomial model. However it's assumed as unsatisfying
%value. 

