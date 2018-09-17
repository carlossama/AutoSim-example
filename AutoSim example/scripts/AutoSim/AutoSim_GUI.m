%       __  ___      __  ____         ________   ___     
%      / / / / | /| / / / __/______  / ___/ _ | / _ \    
%     / /_/ /| |/ |/ / / _// __/ _ \/ /__/ __ |/ , _/    
%     \____/ |__/|__/ /___/\__/\___/\___/_/ |_/_/|_|  
%     System Modeling and Simulations 
%
% AutoSim Graphic User Interface v1.0
% Written by: Carlos Sama, Aug 31




% DO NOT EDIT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function varargout = AutoSim_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AutoSim_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AutoSim_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function AutoSim_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.figure1,'Units','normalized')
handles.mainDir = 'D:\EcoCAR\AutoSim example\'; %CHANGE MAIN DIR HERE (two other places also)
FigWidth = .20;
pos = get(handles.figure1, 'Position');
set(handles.figure1, 'Position', [pos(1) pos(2) FigWidth pos(4)])
handles.output = hObject;
guidata(hObject, handles);
uiwait(handles.figure1)

% --- Outputs from this function are returned to the command line.
function varargout = AutoSim_GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.simpathfile;
delete(handles.figure1)



% PANEL CREATE FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subsystems_p_CreateFcn(hObject, eventdata, handles)
handles.selectedSubsystem = '';
hObject.Position = [0,0, 54.636, 25.936];
hObject.Visible = 'On';
handles.subsystem_p = hObject;
guidata(hObject, handles);

function modelSelect_p_CreateFcn(hObject, eventdata, handles)
hObject.Position = [0,0, 54.636, 25.936];
handles.modelSelect_p = hObject;
hObject.Visible = 'Off';
guidata(hObject, handles);

function parameters_p_CreateFcn(hObject, eventdata, handles)
hObject.Position = [0,0, 54.636, 25.936];
handles.parameters_p = hObject;
hObject.Visible = 'Off';
guidata(hObject, handles);

function simulationSettings_p_CreateFcn(hObject, eventdata, handles)
hObject.Position = [0,0, 54.636, 25.936];
handles.simulationSettings_p = hObject;
handles.simulationSettings = {'Drive Cycle', 'report'};
hObject.Visible = 'Off';
guidata(hObject, handles);


% SUBSYSTEM BUTTON CREATE FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subsystem1_b_CreateFcn(hObject, eventdata, handles)

hObject.String = 'CONTROLLER';

handles.mainDir = 'D:\EcoCAR\AutoSim example\'; % CHANGE MAIN DIR HERE
d = dir(strcat(handles.mainDir, 'Controller'));
isub = [d(:).isdir]; 
fileList = {d(isub).name}';
fileList = fileList(3:end);
descriptionList = cell(length(fileList) + 1,1);
descriptionList{1} = 'info';
for i = 1:length(fileList)
    description = fileread(strcat(handles.mainDir, 'Controller/', fileList{i}, '/', fileList{i},'.txt')); %v\'D:\EcoCAR\AutoSim\Model Folder\Subsystems\Controller\Documentation\',fileList{i},'.txt'
    descriptionList{i+1} = description;
end
fileList = {'info', fileList{:}};
handles.subsystem1.list = fileList;
handles.subsystem1.string = 'Controller';
handles.subsystem1.ID = 'subsystem1';
handles.subsystem1.callsign = 'ctl';
handles.subsystem1.descriptions = descriptionList;
handles.subsystem1.parametersToChange = cell(0);
handles.subsystem1.variant = '';
handles.subsystem1.configStatus = 0;
guidata(hObject, handles);

function subsystem2_b_CreateFcn(hObject, eventdata, handles)

hObject.String = 'PLANT';

handles.mainDir = 'D:\EcoCAR\AutoSim example\'; % CHANGE MAIN DIR HERE
d = dir(strcat(handles.mainDir, 'Plant'));
isub = [d(:).isdir]; 
fileList = {d(isub).name}';
fileList = fileList(3:end);
descriptionList = cell(length(fileList) + 1,1);
descriptionList{1} = 'info';
for i = 1:length(fileList)
    description = fileread(strcat(handles.mainDir, 'Plant/', fileList{i}, '/', fileList{i},'.txt'));
    descriptionList{i+1} = description;
end
fileList = {'info', fileList{:}};
handles.subsystem2.list = fileList;
handles.subsystem2.string = 'Plant';
handles.subsystem2.ID = 'subsystem2';
handles.subsystem2.callsign = 'veh';
handles.subsystem2.descriptions = descriptionList;
handles.subsystem2.parametersToChange = cell(0);
handles.subsystem2.variant = '';
handles.subsystem2.configStatus = 0;
guidata(hObject, handles);


function advanced_b_CreateFcn(hObject, eventdata, handles)

hObject.String = 'ADVANCED';


handles.advanced.parametersToChange = {'Drive_Cycle'};
handles.advanced.string = 'advanced';
handles.advanced.ID = 'advanced';
handles.advanced.callsign = 'adv';
handles.advanced.driveCycle = '';
handles.advanced.numberOfRuns = 0;
handles.advanced.simfile = '';
handles.advanced.report = cell(0);
handles.advanced.configStatus = 0;
guidata(hObject, handles);


% SCROLL MENU CREATE FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function modelOptions_m_CreateFcn(hObject, eventdata, handles)
handles.modelOptions_m = hObject;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','Gray');
end
guidata(hObject, handles);

function driveCycle_m_CreateFcn(hObject, eventdata, handles)
hObject.String = {'Select Cycle','US06'};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% AXES CREATE FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function driveCyclePlot_CreateFcn(hObject, eventdata, handles)
hObject.Color = [0.3 0.3 0.3];
handles.driveCyclePlot = hObject;
guidata(hObject, handles);


% ENTER BOX CREAT FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simulationAmount_e_CreateFcn(hObject, eventdata, handles)
handles.numberOfSimulations = 0;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function simfile_e_CreateFcn(hObject, eventdata, handles)
hObject.String = '';


% TEXTBOX CREATE FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function modelInfo_t_CreateFcn(hObject, eventdata, handles)
hObject.String = 'info';
handles.modelInfo_t = hObject;
guidata(hObject, handles);


% LISTBOX CREATE FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function availableParameters_l_CreateFcn(hObject, eventdata, handles)
hObject.String = 'parameters';
handles.availableParameters_l = hObject;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

function selectedParameters_l_CreateFcn(hObject, eventdata, handles)
hObject.String = cell(0);
handles.selectedParameters = hObject;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


% PANEL CALLBACK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function modelSelect_p_Callback(hObject, handles)
if strcmpi(handles.selectedPanel, 'modelSelect_p')
    hObject.Visible = 'On';
    handles.modelOptions_m.String = handles.selectedSubsystem.list;
else
    hObject.Visible = 'Off';
end
guidata(hObject, handles);

function subsystem_p_Callback(hObject, handles)
if strcmpi(handles.selectedPanel, 'subsystem_p')
    hObject.Visible = 'On';
else 
    hObject.Visible = 'Off';
end
guidata(hObject, handles);

function parameters_p_Callback(hObject, handles)
if strcmpi(handles.selectedPanel, 'parameters_p')
    hObject.Visible = 'On';
else 
    hObject.Visible = 'Off';
end
guidata(hObject, handles);

function simulationSettings_p_Callback(hObject, handles)
if strcmpi(handles.selectedPanel, 'simulationSettings_p')
    hObject.Visible = 'On';
else 
    hObject.Visible = 'Off';
end
guidata(hObject, handles);


% BUTTON CALLBACKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subsystem1_b_Callback(hObject, eventdata, handles)
handles.subsystem1.configStatus = 1;
handles.selectedSubsystem = handles.subsystem1;
handles.selectedPanel = 'modelSelect_p';
subsystem_p_Callback(handles.subsystem_p, handles);
modelSelect_p_Callback(handles.modelSelect_p, handles);
modelOptions_m_Callback(handles.modelOptions_m, eventdata, handles);
guidata(hObject, handles);

function subsystem2_b_Callback(hObject, eventdata, handles)
handles.subsystem2.configStatus = 1;
handles.selectedSubsystem = handles.subsystem2;
handles.selectedPanel = 'modelSelect_p';
subsystem_p_Callback(handles.subsystem_p, handles);
modelSelect_p_Callback(handles.modelSelect_p, handles);
modelOptions_m_Callback(handles.modelOptions_m, eventdata, handles);
guidata(hObject, handles);

function subvar2subparam_b_Callback(hObject, eventdata, handles)
if ~strcmpi(handles.selectedModel,'info')
    handles.selectedSubsystem.variant = handles.selectedModel;
    modelDir = strcat(handles.mainDir, handles.selectedSubsystem.string,'/', handles.selectedSubsystem.variant,'/', handles.selectedSubsystem.variant,'_params.csv');
    [values, names, all] = xlsread(modelDir{1});
    handles.availableParameters = names(2:end,1);
    handles.availableParameters_l.String = names(3:end,1);
    handles.selectedPanel = 'parameters_p';
    modelSelect_p_Callback(handles.modelSelect_p, handles);
    parameters_p_Callback(handles.parameters_p, handles);
end
    handles.modelOptions_m.Value = 1;
guidata(hObject, handles);

function continue_b_Callback(hObject, eventdata, handles)
handles.selectedSubsystem.parametersToChange = handles.selectedParameters_l.String;
eval(strcat('handles.',handles.selectedSubsystem.ID,'=handles.selectedSubsystem;'));
handles.selectedPanel = 'subsystem_p';
subsystem_p_Callback(handles.subsystem_p, handles)
parameters_p_Callback(handles.parameters_p, handles)
handles.selectedParameters_l.String = cell(0);
guidata(hObject, handles);

function advanced_b_Callback(hObject, eventdata, handles)
handles.advanced.configStatus = 1;
handles.selectedSubsystem = handles.advanced;
handles.selectedPanel = 'simulationSettings_p';
simulationSettings_p_Callback(handles.simulationSettings_p, handles);
subsystem_p_Callback(handles.subsystem_p, handles);
guidata(hObject, handles)

function continue_b1_Callback(hObject, eventdata, handles)
handles.selectedPanel = 'subsystem_p';
subsystem_p_Callback(handles.subsystem_p, handles);
simulationSettings_p_Callback(handles.simulationSettings_p, handles);
guidata(hObject, handles)


% MENU CALLBACKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function modelOptions_m_Callback(hObject, eventdata, handles)
handles.modelOptions_m = hObject;
handles.selectedModel = hObject.String(hObject.Value);
handles.selectedSubsystem.variant = handles.selectedModel;
handles.selectedDescription = handles.selectedSubsystem.descriptions(hObject.Value);
modelInfo_t_Callback(handles.modelInfo_t, eventdata, handles)
guidata(hObject,handles)

function driveCycle_m_Callback(hObject, eventdata, handles)
selectedCycle = hObject.String{hObject.Value};
if hObject.Value > 1
    handles.advanced.driveCycle = selectedCycle;
    axes(handles.driveCyclePlot)
    cycle = csvread(strcat(handles.mainDir, 'Drive Cycles/', hObject.String{hObject.Value},'.csv'));
    plot(cycle(:,1),cycle(:,2));
    handles.driveCyclePlot.Color = [0.3, 0.3, 0.3];
    handles.driveCyclePlot.XLim = [0, cycle(end,1)];
    handles.driveCyclePlot.YLim = [0, max(cycle(:,2)) + 10];
end
guidata(hObject,handles)


% TEXTBOX CALLBACKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function modelInfo_t_Callback(hObject, eventdata, handles)
hObject.String = handles.selectedDescription;


% LISTBOX CALLBACKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function availableParameters_l_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
handles.selectedParameter = contents{get(hObject,'Value')};
clickAdd(handles, eventdata);
guidata(hObject,handles)

function selectedParameters_l_Callback(hObject, eventdata, handles)
handles.selectedParameter = get(hObject,'Value');
clickRemove(handles, eventdata)
guidata(hObject, handles)

function clickAdd(handles, eventdata)
persistent chk
if isempty(chk)
      chk = 1;
      pause(0.5);
      if chk == 1
          chk = [];
      end
else
      chk = [];
      addParam(handles.selectedParameters_l, eventdata, handles);
end

function clickRemove(handles, eventdata)
persistent chk
if isempty(chk)
      chk = 1;
      pause(0.5); 
      if chk == 1
          chk = [];
      end
else
      chk = [];
      removeParam(handles.selectedParameters_l, eventdata, handles);
end

function removeParam(hObject, eventdata, handles) 
hObject.String = remove((hObject.String),handles.selectedParameter);
if hObject.Value ~= 1
    hObject.Value = handles.selectedParameter - 1;
end

function addParam(hObject, eventdata, handles)
if ~contains(hObject.String,handles.selectedParameter)
    hObject.String{length(hObject.String) + 1} = handles.selectedParameter;
end

function newList = remove(list, index)
indexing = ones(length(list),1);
indexing(index) = 0;
newList = list(logical(indexing));


function status = contains(array, string)
for i = 1:length(array)
    if strcmp(array{i}, string)
        status = 1;
        return
    end
end
status = 0;
return


% ENTER BOX CALLBACKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simulationAmount_e_Callback(hObject, eventdata, handles)
handles.advanced.numberOfRuns = str2double(get(hObject,'String'));
guidata(hObject, handles)

function simfile_e_Callback(hObject, eventdata, handles)
handles.advanced.simfile = get(hObject, 'String');
guidata(hObject,handles)


% GENERATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function generate_Callback(hObject, eventdata, handles)
subsystems = compile(handles);
if ~contains(subsystems, 'wrong')
    index = 2;
    counts = 2;
    for i = 1:length(subsystems) 
        counts = counts + length(subsystems{i}.parametersToChange);
    end
    header = cell(subsystems{end}.numberOfRuns + 3, counts - 1);
    for i = 1:length(subsystems) 
        if subsystems{i}.configStatus == 1
            header{2,index} = subsystems{i}.string;
            if ~strcmpi(subsystems{i}.string,'advanced')
                subsystemVariant = strcat(header{2,index},'\',subsystems{i}.variant);
                header{2, index} = subsystemVariant{1};
            end
            for j = 1:length(subsystems{i}.parametersToChange)
                header{3,index + j - 1} = subsystems{i}.parametersToChange{j};
                if strcmpi(subsystems{i}.string, 'advanced') && j == 1
                    header{4,index + j - 1} = handles.advanced.driveCycle;
                end
            end
            index = index + length(subsystems{i}.parametersToChange);
        end
    end
    header(4:end,1) = num2cell(1:subsystems{end}.numberOfRuns)';
    header{1,1} = 'Sim Test';
    header{1,2} = 'Notes:';
    header{3,1} = 'Run';
    file = strcat(handles.mainDir,'simulations/simfile/',subsystems{end}.simfile,'.csv');
    handles.simpathfile = file;
    xlswrite(file,header);
    winopen(file);
end
guidata(hObject, handles)

function subsystems = compile(handles)
subsystems = {handles.subsystem1, handles.subsystem2, handles.advanced};
if checkAdvanced(handles.advanced)
    error = error1;
    uiwait(error)
    subsystems = {'wrong'};
    return
else 
    return
end

function status = checkAdvanced(advanced)
if  (strcmpi(advanced.driveCycle,'') ||...
        advanced.numberOfRuns == 0 || ...
        strcmpi(advanced.simfile,'')||...
        advanced.configStatus == 0 )
    status = 1;
else 
    status = 0;
end
    
            

        

% ABORT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function abort_Callback(hObject, eventdata, handles)
close all


% RUN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function runnit_Callback(hObject, eventdata, handles)
if isempty(handles.advanced.simfile)
    error = error1;
    uiwait(error)
end
    
figure1_DeleteFcn(handles.figure1, eventdata, handles);
guidata(hObject,handles);

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
uiresume(hObject)


