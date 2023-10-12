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
    kz = RR_evaluate(Gs,0)/RR_evaluate(Mz,1);

    Gz = RR_tf(zz,pz,kz);

end