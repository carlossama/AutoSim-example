function veh_paramConfig(paramFile)

    [values, names, all] = xlsread(paramFile);
    startIndex = 2;
    
    for i = 1:length(values)
        veh.(names{startIndex + i,1}) = values(i,1);
    end
    assignin('base','veh',veh)
end