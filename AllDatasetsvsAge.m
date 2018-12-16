clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Inputs
FirstInsteadMean=true;
PSAwindow=[4 10]; %[4 10] [-Inf Inf]
Outliers=false;

%% Creation of PSA per ID dataset
%Definitions for means of PSA and age per patient (ID)
PSAUniq=unique(PSA.ID);
PSAperID=zeros(size(PSAUniq));
AgePerID=PSAperID;

if FirstInsteadMean
    %Calculating first PSA val per patient
    for i=1:length(PSAUniq)
        PSAarr=PSA.psa(PSA.ID==PSAUniq(i));
        PSAperID(i)=PSAarr(1);
        AgePerID(i)=mean(PSA.age(PSA.ID==PSAUniq(i)));
    end
else
    %Calculating means per patient
    for i=1:length(PSAUniq)
        PSAperID(i)=mean(PSA.psa(PSA.ID==PSAUniq(i)));
        AgePerID(i)=mean(PSA.age(PSA.ID==PSAUniq(i)));
    end
end

AgePerIDforPlot=AgePerID(PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
PSAperIDforPlot=PSAperID(PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));

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

[MRIvalAge,MRIvalPSA]=FindAgeByDateAndPSA(PSA,scores,dates,IDs,PSAwindow);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(MRI.pirads));

%Create three arrays new arrays for only the not useful entries
notscores=MRI.pirads(notusefulEntryInd);
notdates=MRI.date(notusefulEntryInd);
notIDs=MRI.ID(notusefulEntryInd);

[MRInoValAge,MRInoValPSA]=FindAgeByDateAndPSA(PSA,notscores,notdates,notIDs,PSAwindow);

MRInoDataIDs=~ismember(PSAUniq,MRI.ID);

MRInoDataAge=AgePerID(MRInoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
MRInoDataPSA=PSAperID(MRInoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));

%% Analysis of BIOPT dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(BIOPT.gleason));

%Create three arrays new arrays for only the useful entries
scores=BIOPT.gleason(usefulEntryInd);
dates=BIOPT.date(usefulEntryInd);
IDs=BIOPT.ID(usefulEntryInd);

[BIOPTvalAge,BIOPTvalPSA]=FindAgeByDateAndPSA(PSA,scores,dates,IDs,PSAwindow);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(BIOPT.gleason));

%Create three arrays new arrays for only the not useful entries
notscores=BIOPT.gleason(notusefulEntryInd);
notdates=BIOPT.date(notusefulEntryInd);
notIDs=BIOPT.ID(notusefulEntryInd);

[BIOPTnoValAge,BIOPTnoValPSA]=FindAgeByDateAndPSA(PSA,notscores,notdates,notIDs,PSAwindow);

BIOPTnoDataIDs=~ismember(PSAUniq,BIOPT.ID);

BIOPTnoDataAge=AgePerID(BIOPTnoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
BIOPTnoDataPSA=PSAperID(BIOPTnoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));

%% Analysis of ECHO dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(ECHO.volume));

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

[ECHOvalAge,ECHOvalPSA]=FindAgeByDateAndPSA(PSA,scores,dates,IDs,PSAwindow);

%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(ECHO.volume));

%Create three arrays new arrays for only the not useful entries
notscores=ECHO.volume(notusefulEntryInd);
notdates=ECHO.date(notusefulEntryInd);
notIDs=ECHO.ID(notusefulEntryInd);

[ECHOnoValAge,ECHOnoValPSA]=FindAgeByDateAndPSA(PSA,notscores,notdates,notIDs,PSAwindow);

ECHOnoDataIDs=~ismember(PSAUniq,ECHO.ID);

ECHOnoDataAge=AgePerID(ECHOnoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
ECHOnoDataPSA=PSAperID(ECHOnoDataIDs & PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));

%%Remove outliers if true
if ~Outliers
    [AgePerID,PSAperID,AgePerIDforPlot,PSAperIDforPlot,...
    MRIvalAge,MRIvalPSA,MRInoValAge,MRInoValPSA,MRInoDataAge,MRInoDataPSA,...
    BIOPTvalAge,BIOPTvalPSA,BIOPTnoValAge,BIOPTnoValPSA,BIOPTnoDataAge,BIOPTnoDataPSA,...
    ECHOvalAge,ECHOvalPSA,ECHOnoValAge,ECHOnoValPSA,ECHOnoDataAge,ECHOnoDataPSA]=RemoveOutliers(AgePerID,PSAperID,AgePerIDforPlot,PSAperIDforPlot,...
    MRIvalAge,MRIvalPSA,MRInoValAge,MRInoValPSA,MRInoDataAge,MRInoDataPSA,...
    BIOPTvalAge,BIOPTvalPSA,BIOPTnoValAge,BIOPTnoValPSA,BIOPTnoDataAge,BIOPTnoDataPSA,...
    ECHOvalAge,ECHOvalPSA,ECHOnoValAge,ECHOnoValPSA,ECHOnoDataAge,ECHOnoDataPSA);
end

%% Plots
figure(1)
MultipleDispersionAnalyses(AgePerIDforPlot,PSAperIDforPlot);
set(gcf,'Position',[100,100,1600,400])

subplot(1,2,1)
title('Dispersion of ages of all patients')

subplot(1,2,2)
title('Dispersion of PSA values of all patients')

saveas(gcf,'1 Age and PSA All.jpg')
saveas(gcf,'1 Age and PSA All.fig')

%% MRI Age
figure(2)
MRIageStats=MultipleDispersionAnalyses(MRIvalAge,MRInoValAge,MRInoDataAge);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('MRI age dataset which corresponds with number entry')

subplot(1,3,2)
title('MRI age dataset which corresponds with no number entry')

subplot(1,3,3)
title('MRI age dataset which corresponds with no entries in MRI')

saveas(gcf,'2 Age MRI.jpg')
saveas(gcf,'2 Age MRI.fig')

%% MRI PSA
figure(3)
MRIpsaStats=MultipleDispersionAnalyses(MRIvalPSA,MRInoValPSA,MRInoDataPSA);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('MRI PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('MRI PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('MRI PSA dataset which corresponds with no entries in MRI')

saveas(gcf,'3 PSA MRI.jpg')
saveas(gcf,'3 PSA MRI.fig')

%% BIOPT Age
figure(4)
BIOPTageStats=MultipleDispersionAnalyses(BIOPTvalAge,BIOPTnoValAge,BIOPTnoDataAge);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('BIOPT age dataset which corresponds with number entry')

subplot(1,3,2)
title('BIOPT age dataset which corresponds with no number entry')

subplot(1,3,3)
title('BIOPT age dataset which corresponds with no entries in BIOPT')

saveas(gcf,'4 Age BIOPT.jpg')
saveas(gcf,'4 Age BIOPT.fig')

%% BIOPT PSA
figure(5)
BIOPTpsaStats=MultipleDispersionAnalyses(BIOPTvalPSA,BIOPTnoValPSA,BIOPTnoDataPSA);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('BIOPT PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('BIOPT PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('BIOPT PSA dataset which corresponds with no entries in BIOPT')

saveas(gcf,'5 PSA BIOPT.jpg')
saveas(gcf,'5 PSA BIOPT.fig')

%% ECHO Age
figure(6)
ECHOageStats=MultipleDispersionAnalyses(ECHOvalAge,ECHOnoValAge,ECHOnoDataAge);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('ECHO age dataset which corresponds with number entry')

subplot(1,3,2)
title('ECHO age dataset which corresponds with no number entry')

subplot(1,3,3)
title('ECHO age dataset which corresponds with no entries in ECHO')

saveas(gcf,'6 Age ECHO.jpg')
saveas(gcf,'6 Age ECHO.fig')

%% ECHO PSA
figure(7)
ECHOpsaStats=MultipleDispersionAnalyses(ECHOvalPSA,ECHOnoValPSA,ECHOnoDataPSA);
set(gcf,'Position',[100,100,1600,400])

subplot(1,3,1)
title('ECHO PSA dataset which corresponds with number entry')

subplot(1,3,2)
title('ECHO PSA dataset which corresponds with no number entry')

subplot(1,3,3)
title('ECHO PSA dataset which corresponds with no entries in ECHO')

saveas(gcf,'7 PSA ECHO.jpg')
saveas(gcf,'7 PSA ECHO.fig')