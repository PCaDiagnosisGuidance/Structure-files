%% Curve fitting preparation script 
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Documents\MATLAB\OGO Computational Biology\OGO groep 5';

% CurvefitType equals the type of curvefitting you want to do. The
% following possibilities currently exist: 
% CurvefitType = 1 --> Curve fitting for the overall datasets
% CurvefitType = 2 --> Curve fitting for timeslot values
% CurvefitType = 3 --> Curve fitting for PSA values between 4 and 10 

CurvefitType = 2; 

if CurvefitType == 1
    %% Curve fitting for the overall datasets
    %Create a merged dataset of all available datasets
    Dataset = MergeDatasets(foldername);

    pID = Dataset(:,1);
    PSAvalues = Dataset(:,2);
    fPSAvalues = Dataset(:,3);
    MRIvalues = Dataset(:,4);
    Bioptvalues = Dataset(:,5);
    Echovalues = Dataset(:,6);
    DBCvalues = Dataset(:,7);

    clear Dataset

elseif CurvefitType == 2 
    %% Curve fitting for timeslot values
    % Assemble all values and types of all methods used in the given time frame  
    % around the first MRI measurement of all patients. 
    [AllValuesperMRI, methodsperMRI]=findDataPerMRI();
    psa_value=zeros(13939, 1);

    for i=1:size(methodsperMRI, 1);
        psa_index=find(methodsperMRI(i, :)==1, 1, 'first');
        if isempty(psa_index) == 0 
            psa_value(i, 1:length(psa_index))=AllValuesperMRI(i, psa_index);
        else
            psa_value(i, 1)=0;
        end

        mri_index=find(methodsperMRI(i, :)==2, 1, 'first');
        if isempty(mri_index) == 0
            mri_value(i, 1:length(mri_index))=AllValuesperMRI(i, mri_index);
        else
            mri_value(i, 1)=0;
        end

        biopt_index=find(methodsperMRI(i, :)==3, 1, 'first');
        if isempty(biopt_index) == 0 
            biopt_value(i, 1:length(biopt_index))=AllValuesperMRI(i, biopt_index);
        else
            biopt_value(i, 1)=0;
        end

        echo_index=find(methodsperMRI(i, :)==4, 1, 'first');
        if isempty(echo_index) == 0
            echo_value(i, 1:length(echo_index))=AllValuesperMRI(i, echo_index);
        else
            echo_value(i, 1)=0;
        end
    end
    clear biopt_index echo_index foldername i mri_index psa_index ...
        AllValuesperMRI methodsperMRI
    

elseif CurvefitType == 3 
    %% Curve fitting for PSA values between 4 and 10 
    %Create a merged dataset of all available datasets
    Dataset = MergeDatasets(foldername);
    
    % find all PSA values which are higher than 4 and lower than 10
    ipsa = find(Dataset(:,2)>=4 & Dataset(:,2)<=10);
    psa = Dataset(ipsa,2);
    fpsa = Dataset(ipsa,3);
    mri = Dataset(ipsa,4);
    biopt = Dataset(ipsa,5);
    volume = Dataset(ipsa,6);
    PCa = Dataset(ipsa,7); % corresponding PCa diagnosis
    
    clear ipsa Dataset
    
end 
    
clear CurvefitType 