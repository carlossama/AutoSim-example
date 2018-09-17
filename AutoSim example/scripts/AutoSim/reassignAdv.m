%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% Advanced value reassign
% Written by: Carlos Sama, Sep 12

%Reassigns values that are not standard to subsystems such as drive cycle

function reassignAdv(newVals)

    parameters = fieldnames(newVals);
    for i = 1:length(parameters)
        if strcmpi(parameters{i}, 'Drive_Cycle')
            val = newVals.(parameters{i});
            val = val{1};
            set_param('simpleBEV/Drive Cycle Source','cycleVar',val);
            tfinal = get_param('simpleBEV/Drive Cycle Source','tfinal');
            set_param('simpleBEV','StopTime', (tfinal(1:strfind(tfinal,'  ')-1)));
        end
    end
    
    
    

    