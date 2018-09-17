function reassign(subsystem, paramChange)

    params = fieldnames(paramChange);
    for i = 1:length(params)
        evalin('base', strcat(subsystem, '.', params{i}, '=', num2str(paramChange.(params{i})),';'));
    end
    
    
    
    
