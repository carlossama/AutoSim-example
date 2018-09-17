%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% AutoSim Run v1.0
% Written by: Carlos Sama, Sep 14

% runs the provided model and provides the output data to the selected
% report
function make_it_so(model,report)

    simout = sim(model, 'ReturnWorkspaceOutputs', 'on');
    simdataSave(report,simout) % report hard coded for this example
    
end

