clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Creation of PSA per ID dataset
%Definitions for means of PSA and age per patient (ID)
PSAUniq=unique(PSA.ID);
PSAperID=zeros(size(PSAUniq));
AgePerID=PSAperID;

%Calculating means per patient
for i=1:length(PSAUniq)
    PSAperID(i)=mean(PSA.psa(PSA.ID==PSAUniq(i)));
    AgePerID(i)=mean(PSA.age(PSA.ID==PSAUniq(i)));
end

%Deleting women
womenind=[5335,7860,10961];
indwomen=find(ismember(ECHO.ID,womenind));

for i=1:length(indwomen)
    ECHO.ID(indwomen(i)-i+1)=[];
    ECHO.volume(indwomen(i)-i+1)=[];
    ECHO.date(indwomen(i)-i+1)=[];
end

clearvars womenind indwomen

%% Analysis of MRI dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(MRI.pirads));

%Create three arrays new arrays for only the useful entries
scores=MRI.pirads(usefulEntryInd);
dates=MRI.date(usefulEntryInd);
IDs=MRI.ID(usefulEntryInd);

[MRIvalAge,MRIvalPSA]=FindAgeByDate(PSA,scores,dates,IDs);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(MRI.pirads));

%Create three arrays new arrays for only the not useful entries
notscores=MRI.pirads(notusefulEntryInd);
notdates=MRI.date(notusefulEntryInd);
notIDs=MRI.ID(notusefulEntryInd);

[MRInoValAge,MRInoValPSA]=FindAgeByDate(PSA,notscores,notdates,notIDs);

MRInoDataIDs=find(~ismember(PSAUniq,MRI.ID));

MRInoDataAge=AgePerID(MRInoDataIDs);
MRInoDataPSA=PSAperID(MRInoDataIDs);

%% Analysis of BIOPT dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(BIOPT.gleason));

%Create three arrays new arrays for only the useful entries
scores=BIOPT.gleason(usefulEntryInd);
dates=BIOPT.date(usefulEntryInd);
IDs=BIOPT.ID(usefulEntryInd);

[BIOPTvalAge,BIOPTvalPSA]=FindAgeByDate(PSA,scores,dates,IDs);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(BIOPT.gleason));

%Create three arrays new arrays for only the not useful entries
notscores=BIOPT.gleason(notusefulEntryInd);
notdates=BIOPT.date(notusefulEntryInd);
notIDs=BIOPT.ID(notusefulEntryInd);

[BIOPTnoValAge,BIOPTnoValPSA]=FindAgeByDate(PSA,notscores,notdates,notIDs);

BIOPTnoDataIDs=find(~ismember(PSAUniq,BIOPT.ID));

BIOPTnoDataAge=AgePerID(BIOPTnoDataIDs);
BIOPTnoDataPSA=PSAperID(BIOPTnoDataIDs);

%% Analysis of ECHO dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(ECHO.volume));

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

[ECHOvalAge,ECHOvalPSA]=FindAgeByDate(PSA,scores,dates,IDs);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(ECHO.volume));

%Create three arrays new arrays for only the not useful entries
notscores=ECHO.volume(notusefulEntryInd);
notdates=ECHO.date(notusefulEntryInd);
notIDs=ECHO.ID(notusefulEntryInd);

[ECHOnoValAge,ECHOnoValPSA]=FindAgeByDate(PSA,notscores,notdates,notIDs);

ECHOnoDataIDs=find(~ismember(PSAUniq,ECHO.ID));

ECHOnoDataAge=AgePerID(ECHOnoDataIDs);
ECHOnoDataPSA=PSAperID(ECHOnoDataIDs);

%% Plots
figure(1)
DispersionAnalysis(AgePerID);
title('Dispersion of ages of all patients')

%% MRI Age
figure(2)
MRIageStats=MultipleDispersionAnalyses(MRIvalAge,MRInoValAge,MRInoDataAge);

subplot(1,3,1)
title('MRI age dataset which corresponds with number entry')

subplot(1,3,2)
title('MRI age dataset which corresponds with no number entry')

subplot(1,3,3)
title('MRI age dataset which corresponds with no entries in MRI')

%% MRI PSA
figure(3)
MRIpsaStats=MultipleDispersionAnalyses(MRIvalPSA,MRInoValPSA,MRInoDataPSA);

subplot(1,3,1)
title('MRI PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('MRI PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('MRI PSA dataset which corresponds with no entries in MRI')

%% BIOPT Age
figure(4)
BIOPTageStats=MultipleDispersionAnalyses(BIOPTvalAge,BIOPTnoValAge,BIOPTnoDataAge);

subplot(1,3,1)
title('BIOPT age dataset which corresponds with number entry')

subplot(1,3,2)
title('BIOPT age dataset which corresponds with no number entry')

subplot(1,3,3)
title('BIOPT age dataset which corresponds with no entries in BIOPT')

%% BIOPT PSA
figure(5)
BIOPTpsaStats=MultipleDispersionAnalyses(BIOPTvalPSA,BIOPTnoValPSA,BIOPTnoDataPSA);

subplot(1,3,1)
title('BIOPT PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('BIOPT PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('BIOPT PSA dataset which corresponds with no entries in BIOPT')

%% ECHO Age
figure(6)
ECHOageStats=MultipleDispersionAnalyses(ECHOvalAge,ECHOnoValAge,ECHOnoDataAge);

subplot(1,3,1)
title('ECHO age dataset which corresponds with number entry')

subplot(1,3,2)
title('ECHO age dataset which corresponds with no number entry')

subplot(1,3,3)
title('ECHO age dataset which corresponds with no entries in ECHO')

%% ECHO PSA
figure(7)
ECHOpsaStats=MultipleDispersionAnalyses(ECHOvalPSA,ECHOnoValPSA,ECHOnoDataPSA);

subplot(1,3,1)
title('ECHO PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('ECHO PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('ECHO PSA dataset which corresponds with no entries in ECHO')