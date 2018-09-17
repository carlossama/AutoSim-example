%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% Written by: Carlos Sama, Aug 18
%
%% cellFindIndex
%
% index = cellFindIndex(data, part)
%
% Find the index of a provided 'part' value in the cell array 'data'
%
function index = cellFindIndex(data,part)
    dim = size(data); cols = dim(2); rows = dim(1);
    for j = 1:cols
        for i = 1:rows
            if strcmpi(data{i,j},part)
                if rows == 1
                    index = j;
                else
                    index = [i,j];
                end
            end
        end
    end

