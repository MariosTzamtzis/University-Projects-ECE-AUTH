%{
Aris Liakos |AEM: 10000
Marios Tzamtzis |AEM: 10038
%}

clear;
clc;
close all;

%Erase years with NaN elements
data = readmatrix('Heathrow.xlsx');
data = data(11:end,:);
index = find(any(isnan(data),2));
data(index, :) = [];

