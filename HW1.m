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

function [Gz]= MC_C2D_matched(Gs,h,scaus)

    %   Description: This function uses the matched z-transform method to convert transfer function Gs (which is of class RR_tf)
    % to Gz (transfer function in z-domain) for a certain sample time h. 
    % Default Gz, if appropriate, is semi-causal (proper), if want strictly causal Gz make scaus = true
    
    if (~exist('scaus', 'var'))
        scaus = false;
    end

    if (~exist('h', 'var'))
        h = 1;
    end

    % Step 1
    % Transforming zeros in s to z domain
    for i = 1:length(Gs.z)
        zz(i) = exp(h*Gs.z(i));
    end

    % Transforming poles in s to z domain
    for i = 1:length(Gs.p)
        pz(i) = exp(h*Gs.p(i));
    end

    inf_z = length(pz)-length(zz);  % Finding n-m (poles-zeros)
    
    % Adding appropriate infinite zeros to make Gz semi-causal or strictly causal (Steps 2 & 3)
    if inf_z > 0
        for j = 1:inf_z
            zz = [zz -1];
        end
        if scaus == true    %If want strictly causal removes one infinite zero
            zz(end) = [];
        end
    end

    Mz = RR_tf(zz,pz,1);  %Gz without the gain kz
    % Get gain for Gz by finding DC gain of both Mz and Gs and equating then solving for k
    kz = RR_evaluate(Gs,0)/RR_evaluate(Mz,1);

    Gz = RR_tf(zz,pz,kz);

end