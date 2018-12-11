%% Curve fitting preparation script 
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Documents\MATLAB\OGO Computational Biology\OGO groep 5';

% Create a merged dataset of all available datasets
Dataset = MergeDatasets(foldername);

pID = Dataset(:,1);
PSAvalues = Dataset(:,2);
fPSAvalues = Dataset(:,3);
MRIvalues = Dataset(:,4);
Bioptvalues = Dataset(:,5);
Echovalues = Dataset(:,6);
DBCvalues = Dataset(:,7);
