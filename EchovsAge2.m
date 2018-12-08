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
usefulEntryInd=find(~isnan(ECHO.volume));

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

%Label naming
lbl='Prostate Volume [mL]';

%Strip the PSA dataset to only consist of useful data
PSAentryID=find(ismember(PSA.ID,IDs));

PSAID=PSA.ID(PSAentryID);
PSAval=PSA.psa(PSAentryID);
PSAage=PSA.age(PSAentryID);
PSAdate=PSA.date(PSAentryID);

age=zeros(size(scores));
psaval=age;

%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSAID==IDs(i));
    diffdatearr=abs(PSAdate(ind)-dates(i));
    [~,indmin]=min(diffdatearr);
    age(i)=PSAage(ind(indmin));
    psaval(i)=PSAval(ind(indmin));
end

clearvars ind indmin usefulEntryInd scores dates IDs PSAID PSAval PSAage PSAdate

%% Find ages for not useful entries
%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(ECHO.volume));

%Create three arrays new arrays for only the not useful entries
notscores=ECHO.volume(notusefulEntryInd);
notdates=ECHO.date(notusefulEntryInd);
notIDs=ECHO.ID(notusefulEntryInd);

%Strip the PSA dataset to only consist of not useful data
notPSAentryID=find(ismember(PSA.ID,notIDs));

notPSAID=PSA.ID(notPSAentryID);
notPSAval=PSA.psa(notPSAentryID);
notPSAage=PSA.age(notPSAentryID);
notPSAdate=PSA.date(notPSAentryID);

notage=zeros(size(notscores));
notpsaval=notage;

%Find corresponding age with score by using nearest date
for i=1:length(notscores)
    ind=find(notPSAID==notIDs(i));
    diffdatearr=abs(notPSAdate(ind)-notdates(i));
    [~,indmin]=min(diffdatearr);
    notage(i)=notPSAage(ind(indmin));
    notpsaval(i)=notPSAval(ind(indmin));
end

clearvars i ind indmin notusefulEntryInd notscores notdates notIDs notPSAID notPSAval notPSAage notPSAdate diffdatearr

%% Calculation of means and std of different sets of data
MeanAgeAll=mean(AgePerID);
StdAgeAll=std(AgePerID);

MeanPSAall=mean(PSAperID);
StdPSAall=std(PSAperID);

MeanAgeUseful=mean(age);
StdAgeUseful=std(age);

MeanPSAuseful=mean(psaval);
StdPSAuseful=std(psaval);

% MeanAgeAllMRI=mean([age' notage']);
% StdAgeAllMRI=std([age' notage']);

MeanAgeNotUseful=mean(notage);
StdAgeNotUseful=std(notage);

MeanPSAnotUseful=mean(notpsaval);
StdPSAnotUseful=std(notpsaval);

% PSAnotusefulIDs=find(~ismember(PSAUniq,IDs));
% MeanAgePSAnotuseful=mean(AgePerID(PSAnotusefulIDs));
% StdAgePSAnotuseful=std(AgePerID(PSAnotusefulIDs));
% 
% NoDataIDs=find(~ismember(PSAUniq,MRI.ID));
% MeanAgeNoData=mean(AgePerID(NoDataIDs));
% StdAgeNoData=std(AgePerID(NoDataIDs));

%% Plots
figure(1)

x=18:.1:100;

hold on

Norm1=normpdf(x,MeanAgeAll,StdAgeAll);
plot(x,Norm1)

% Norm2=normpdf(x,MeanAgePSAnotuseful,StdAgePSAnotuseful);
% plot(x,Norm2)

% Norm3=normpdf(x,MeanAgeAllMRI,StdAgeAllMRI);
% plot(x,Norm3)

Norm4=normpdf(x,MeanAgeUseful,StdAgeUseful);
plot(x,Norm4)

Norm5=normpdf(x,MeanAgeNotUseful,StdAgeNotUseful);
plot(x,Norm5)

clearvars Norm4 Norm5

% Norm6=normpdf(x,MeanAgeNoData,StdAgeNoData);
% plot(x,Norm6)

hold off

xlabel('Age [years]')
title('Age distribution of different sets of data according to ECHO data')
% legend('PSA: All','PSA: Not useful','MRI: All','MRI: Useful','MRI: Not useful','MRI: No data')
legend('PSA: All','ECHO: Values','ECHO: No values')

figure(2)

x=0:.5:500;

hold on

Norm1=normpdf(x,MeanPSAall,StdPSAall);
plot(x,Norm1)

Norm2=normpdf(x,MeanPSAuseful,StdPSAuseful);
plot(x,Norm2)

Norm3=normpdf(x,MeanPSAnotUseful,StdPSAnotUseful);
plot(x,Norm3)

clearvars Norm1 Norm2 Norm3

hold off

xlabel('PSA [ug/L]')
title('PSA distribution of different sets of data according to ECHO data')
legend('PSA: All','ECHO: Values','ECHO: No values')

clearvars x lbl