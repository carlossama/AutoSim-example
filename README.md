# AutoSim-example
An example implementation of the AutoSim program on a simple battery electric vehicle model 

AutoSim, is a program designed to run user defined simulations, stored in a csv, using MATLAB/Simulink.
The program involves navigating a graphic user interface to select the models and parameters the simulation will run.

To operate the GUI:
First select the subsystem by clicking on it. A drop down menu should appear with all the availabe model variants, and each
variant will have a short description that pops up underneath the menu. Once you have decided on a model click "select". Then you will be 
prompted to select parameters. A list will show up with all the available parameters for the model you have selected. Double click the 
parameters you wish to add. They will then show up in a list at the bottom of the window. If you with to remove the parameter, double 
click it from the lower list of selected parameters. Once you are satisfied with your list, click "continue"
Lastly you must configure the "advanced" settings. These are fairly straight forward.
Once all that is done hit the "generate" button. This will generate a simfile (csv) and attempt to open it in a csv editing software (defualt to excel).
You must now fill out the run matrix with the parameter values you wish to test. Once you have finished, save and close the file.
Then return to the GUI window and hit run. AutoSim will now configure the model with the parameter values you have selected, or default paramters
values if none were selected, and proceed to run the simulations. 
Data is stored as timeseries in the results folder within the simulations folder.

The file organization is key to the functionality of AutoSim, do not alter it in any way. 

There is only one report available which has been hard coded into the system. More reports will come out as EcoCAR year 1 developes

