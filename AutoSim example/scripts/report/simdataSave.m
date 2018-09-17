%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% Report: sim data save
% Written by: Carlos Sama, Aug 31


% saves the provided sim data to the provided directory 
function simdataSave(report, simout)
    
    save(strcat(report.path, report.name,'.mat'), 'simout', '-mat');