% Aligning of the data
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5';
[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut(foldername);

% GITHUB TEST
%% Aligning of the data in a new dataset
Dataset = [];
for i = 1:length(PSA.ID)
    pID = PSA.ID(i,1);
    psaTrue = find(PSA.ID == pID);
    fpsaTrue = find(PSA.ID == pID);    
    mriTrue = find(MRI.ID == pID);
    bioptTrue = find(BIOPT.ID == pID);
    echoTrue = find(ECHO.ID == pID);
   
    if isempty(mriTrue)
        MRIvalue = 0;
    else
        % Currently the script takes the last measured value of a certain
        % parameter. Another possibility is to average all of the measured
        % values per patient
        MRIvalue = MRI.pirads(mriTrue(end),1); 
    end 
    
    if isempty(bioptTrue)
        bioptvalue = 0;
    else 
        bioptvalue = BIOPT.gleason(bioptTrue(end),1);
    end
    
    if isempty(echoTrue) 
        echovalue = 0;
    else 
        echovalue = ECHO.volume(echoTrue(end),1);
    end
    
    Dataset = [Dataset; pID, PSA.psa(psaTrue(end),1), PSA.freepsa(fpsaTrue(end),1), MRIvalue, bioptvalue, echovalue];
end

% Eliminate the duplicate rows which occur due to multiple PSA level
% measurements 
Dataset = unique(Dataset, 'rows');

%% Visualization of data
% PSA versus PI-RADS score
subplot(2,2,1);
imri = find(Dataset(:,4));
psa = Dataset(imri,2);
pirads = Dataset(imri,4);
scatter(psa,pirads)
axis([0 20 0 6]);
clearvars psa

% PSA versus free PSA
subplot(2,2,2);
ifpsa = find(Dataset(:,3));
fpsa = Dataset(ifpsa,3);
psa = Dataset(ifpsa,2);
scatter(psa,fpsa);
axis([0 10 0 5]);
clearvars psa

% PSA versus Gleason score
subplot(2,2,3);
igleason = find(Dataset(:,5));
psa = Dataset(igleason,2);
gleason = Dataset(igleason,5);
scatter(psa,gleason);
axis([0 20 0 10]);
clearvars psa

% PSA versus Echo volume
subplot(2,2,4);
ivolume = find(Dataset(:,6));
psa = Dataset(ivolume,2);
volume = Dataset(ivolume,6);
scatter(psa,volume);
axis([0 20 0 150]);
clearvars psa


