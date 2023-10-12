clc;
clear;

%% Problem 2a

syms s

a1 = RR_poly([-1 1 -3 3 -6 6],1); 
f1 = RR_poly([-1 -1 -3 -3 -6 -6],1);
b1 = RR_poly([-2 2 -5 5],1);

[x1,y1] = RR_diophantine(a1,b1,f1);

f1_final = trim(a1*x1 + b1*y1)
g1_final = trim(b1*y1);

%% Problem 2b

a2 = RR_poly([-1 1 -3 3 -6 6],1); 
f2 = RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20],1);
b2 = RR_poly([-2 2 -5 5],1);

[x2,y2] = RR_diophantine(a2,b2,f2);

f2_final = trim(a2*x2 + b2*y2)
g2_final = trim(b2*y2); 

D2 = y2/x2

%% Problem 3

function [Gz]= MC_C2D_matched(Gs,omega_bar,caus)

    % Description: 
    % Default resulting Gz is semi causal (proper), if want strictly causal Gz make caus = 'strict'
    
    if ~exist('caus','var')
        % if caus does not exist, default it to null
            caus = [];
    end
       
    % Step 1
    % Transforming zeros in s to z domain
    for i = 1:length(Gs.z)
        zz(i) = exp(omega_bar*Gs.z(i));
    end

    % Transforming poles in s to z domain
    for i = 1:length(Gs.p)
        pz(i) = exp(omega_bar*Gs.p(i));
    end

    inf_z = length(pz)-length(zz);  % Finding n-m (poles-zeros)
    
    % Adding appropriate infinite zeros to make Gz semi-causal or strictly causal (Steps 2 & 3)
    if inf_z > 0
        for j = 1:length(inf_z)
            zz = [zz -1];
        end
        if caus == 'strict'
            zz(end) = [];
        end
    end

    Mz = RR_tf(zz,pz,k);  %Gz without the gain kz
    % Get gain for Gz
    kz = RR_evaluate(Gs,0)/RR_evaluate(Mz,1)

    Gz = RR_tf(zz,pz,kz);

end