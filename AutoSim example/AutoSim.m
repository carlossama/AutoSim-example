%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% AutoSim Main Script v1.0
% Written by: Carlos Sama, Sep 14




function AutoSim()

    
    mainDir = 'D:\EcoCAR\AutoSim example\'; % CHANGE ROOT DIRECTORY
    addpath(genpath(mainDir));
    runFileDir = AutoSim_GUI(); 
    load_system('simpleBEV');
    if strcmpi('off', get_param('simpleBEV','Shown'))
        open_system('simpleBEV');
    end
    
    
    % Configures default variants and parameters
    [values, names, all] = xlsread(strcat(mainDir, '\Main Model\variants_default.csv'));
    sub_call = all(2:end,1:2);
    for i = 1:length(sub_call) 
        variant.(sub_call{i,1}) = all{i+1,3};
        paramFile = strcat(mainDir, sub_call{i,1}, '\', all{i+1,3}, '\', all{i+1,3}, '_params.csv');
        eval(strcat(sub_call{i,2},'_paramConfig("',paramFile,'");'));  
    end
    variant_config(variant);
    
    % Defines report type - report hard coded for this example
    report.path = strcat(mainDir, 'simulations\results\');
    report.type = 'simdataSave';
    
    % Processing the sim file and creates lists of the subsystems to change
    [values, names, all] = xlsread(runFileDir);
    runs = values(:,1);
    values = values(:,2:end);
    subsystems = all(2,:);
    subsystemsIndex = find(cell2mat(cellfun(@(x)any(~isnan(x)),subsystems,'UniformOutput',false)));
    subsystems = subsystems(subsystemsIndex);
    cols = size(all); cols = cols(2);
    subsystemsIndex = [subsystemsIndex, cols + 1]; 
    subsystemsAbv = cell(1,length(subsystems));
    for i = 1:length(subsystems) - 1
        subsystem = subsystems{i};
        index = cellFindIndex(sub_call,subsystem(1:strfind(subsystem,'\') - 1));
        index(2) = index(2) + 1;
        subsystemsAbv{i} = sub_call{index(1),index(2)};
    end
    subsystemsAbv{end} = 'adv';
    
    % Creates a list of parameters to change, organized by subsystem
    parameters = all(3,:);
    sub_param = struct();
    for i = 1:length(subsystems)
        subParamList = parameters(subsystemsIndex(i):subsystemsIndex(i+1) - 1);
        sub_param.(subsystemsAbv{i}) = subParamList;
    end
    
    % Creates a list of parameters with all the values each parameter is
    % assigned
    param_val = struct();
    for i = 2:subsystemsIndex(end - 1) - 1
        param_val.(parameters{i}) = values(:,i-1);
    end
    for i = subsystemsIndex(end - 1):(subsystemsIndex(end) - 1)
        param_val.(parameters{i}) = all(4:end,i);
    end
    
    % Iterates through each run, reassigns changing parameter values
    for run = 1:runs(end)
        for i = 1:length(subsystems)
            if ~strcmpi(subsystemsAbv{i}, 'adv')
                params = sub_param.(subsystemsAbv{i});
                newVals = struct();
                for j = 1:length(params) 
                    param = params{j};
                    vals = param_val.(param);
                    val = vals(run);
                    if run == 1 || val ~= vals(run - 1)
                        newVals.(param) = val;
                    end
                end
                reassign(subsystemsAbv{i}, newVals);
            else
                params = sub_param.(subsystemsAbv{i});
                newVals = struct();
                for j = 1:length(params) 
                    param = params{j};
                    vals = param_val.(param);
                    val = vals(run);
                    if run == 1 || ~strcmpi(val, vals(run - 1)) 
                        newVals.(param) = val;
                    end
                end
                reassignAdv(newVals);
            end
        end
        report.name = strcat('Run_',num2str(run),'_',date);
        make_it_so('simpleBEV', report)
    end
end

    
    
    
    
