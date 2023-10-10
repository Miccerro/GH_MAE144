clc;
clear;

%% Problem 2a

syms s

a1 = RR_poly([-1 1 -3 3 -6 6],1); 
f1 = RR_poly([-1 -1 -3 -3 -6 -6],1);
b1 = RR_poly([-2 2 -5 5],1);

[x1,y1] = RR_diophantine(a1,b1,f1);

f1_final = trim(a1*x1 + b1*y1);
g1_final = trim(b1*y1);

%% Problem 2b

a2 = RR_poly([-1 1 -3 3 -6 6],1); 
f2 = RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20],1);
b2 = RR_poly([-2 2 -5 5],1);

[x2,y2] = RR_diophantine(a2,b2,f2);

f2_final = trim(a2*x2 + b2*y2);
g2_final = trim(b2*y2); 

D = y/x;
