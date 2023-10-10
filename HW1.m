clc;
clear;

%% Problem 2

syms s

a = RR_poly([-1 1 -3 3 -6 6],1); 
f = RR_poly([-1 -1 -3 -3 -6 -6],1);
b = RR_poly([-2 2 -5 5],1);

[x,y] = RR_diophantine(a,b,f);

f_final = trim(a*x + b*y);