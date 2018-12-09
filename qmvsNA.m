clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Deleting women from ECHO
womenind=[5335,7860,10961];
indwomen=find(ismember(ECHO.ID,womenind));

for i=1:length(indwomen)
    ECHO.ID(indwomen(i)-i+1)=[];
    ECHO.volume(indwomen(i)-i+1)=[];
    ECHO.date(indwomen(i)-i+1)=[];
end

%% ECHO

%Find all indices for NA entries in score dataset
usefulEntryInd=find(isnan(ECHO.volume));

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

[NAage,NAPSA]=FindAgeByDate(PSA,scores,dates,IDs);

%Find all indices for ? entries in score dataset
usefulEntryInd=find(ECHO.volume==Inf);

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

[qmAge,qmPSA]=FindAgeByDate(PSA,scores,dates,IDs);

%% Plots
figure(1)
subplot(2,2,1)
statsNAage=DispersionAnalysis(NAage,'Normplot');
title('Normal prob. plot of patient ages corresponding to NA entries')
xlabel('Age [years]')

subplot(2,2,2)
statsqmAge=DispersionAnalysis(qmAge,'Normplot');
title('NPP of patient ages corresponding to "?" entries')
xlabel('Age [years]')

subplot(2,2,3)
statsNAPSA=DispersionAnalysis(NAPSA,'Normplot');
title('NPP of patient PSA concentration corr. to NA entries')
xlabel('PSA [ug/L]')

subplot(2,2,4)
statsqmPSA=DispersionAnalysis(qmPSA,'Normplot');
title('NPP of patient PSA concentration corr. to "?" entries')
xlabel('PSA [ug/L]')
