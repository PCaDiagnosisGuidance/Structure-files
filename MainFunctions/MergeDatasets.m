function [Dataset] = MergeDatasets(foldername)
% MergeDatasets reads in all datasets using DataReadOut. It then generates
% a Dataset with on each row all information of a patient in the following
% format: Dataset = [pID, PSA, FreePSA, PI-RADS, Gleason, Volume, DBC.PCa];

[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut(foldername);

%% Merging of the datasets in a new dataset
Dataset = [];

for i = 1:length(PSA.ID)
    pID = PSA.ID(i,1);
    psaTrue = find(PSA.ID == pID);
    fpsaTrue = find(PSA.ID == pID);    
    mriTrue = find(MRI.ID == pID);
    bioptTrue = find(BIOPT.ID == pID);
    echoTrue = find(ECHO.ID == pID);
    DBCTrue = find(DBC.ID == pID);
       
    if isempty(mriTrue) % Als deze techniek niet gebruikt is bij de patient
        MRIvalue = 0;   % stel dan de waarde gelijk aan 0.
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
    
    if isempty(DBCTrue)
        DBCvalue = -1; % geef het een negatieve waarde als de DBC diagnose onbekend is 
    else 
        DBCvalue = DBC.PCa(DBCTrue(end),1);
    end
    
    Dataset = [Dataset; pID, PSA.psa(psaTrue(end),1), PSA.freepsa(fpsaTrue(end),1), MRIvalue, bioptvalue, echovalue, DBCvalue];
end

% Eliminate the duplicate rows which occur due to multiple PSA level
% measurements 
Dataset = unique(Dataset, 'rows');
