%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% Variant Configuration 
% Written by: Carlos Sama, Sep 12


function variant_config(variant)
    
    subsystems = fieldnames(variant);
    for i = 1:numel(subsystems)
        set_param(strcat('simpleBEV/',subsystems{i},'/Model'),'ModelName',strcat(variant.(subsystems{i}),'.slx'));
    end
    
    