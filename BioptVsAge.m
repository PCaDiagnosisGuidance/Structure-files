close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

%% Creation of PSA per ID dataset
%Definitions for means of PSA and age per patient (ID)
PSAUniq=unique(PSA.ID);
PSAperID=zeros(size(PSAUniq));
AgePerID=PSAperID;
%AgeDiffPerID=PSAperID; %niet nodig, max hiervan is 8

%Calculating means per patient
for i=1:length(PSAUniq)
    PSAperID(i)=mean(PSA.psa(PSA.ID==PSAUniq(i)));
    AgePerID(i)=mean(PSA.age(PSA.ID==PSAUniq(i)));
end

%% Analysis of BIOPT dataset
%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(BIOPT.gleason));

%Create three arrays new arrays for only the useful entries
scores=BIOPT.gleason(usefulEntryInd);
dates=BIOPT.date(usefulEntryInd);
IDs=BIOPT.ID(usefulEntryInd);

%Label naming
lbl='Gleason';

%Strip the PSA dataset to only consist of useful data
PSAentryID=find(ismember(PSA.ID,IDs));

PSAID=PSA.ID(PSAentryID);
PSAage=PSA.age(PSAentryID);
PSAdate=PSA.date(PSAentryID);

age=zeros(size(scores));

%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSAID==IDs(i));
    diffdatearr=abs(PSAdate(ind)-dates(i));
    [~,indmin]=min(diffdatearr);
    age(i)=PSAage(ind(indmin));
end

%% Find ages for not useful entries
%Find all indices for not useful entries in score dataset
notusefulEntryInd=find(isnan(BIOPT.gleason));

%Create three arrays new arrays for only the not useful entries
notscores=BIOPT.gleason(notusefulEntryInd);
notdates=BIOPT.date(notusefulEntryInd);
notIDs=BIOPT.ID(notusefulEntryInd);

%Strip the PSA dataset to only consist of not useful data
notPSAentryID=find(ismember(PSA.ID,notIDs));

notPSAID=PSA.ID(notPSAentryID);
notPSAage=PSA.age(notPSAentryID);
notPSAdate=PSA.date(notPSAentryID);

notage=zeros(size(notscores));

%Find corresponding age with score by using nearest date
for i=1:length(notscores)
    ind=find(notPSAID==notIDs(i));
    diffdatearr=abs(notPSAdate(ind)-notdates(i));
    [~,indmin]=min(diffdatearr);
    notage(i)=notPSAage(ind(indmin));
end

%% Calculation of means and std of different sets of data
MeanAgeAll=mean(AgePerID);
StdAgeAll=std(AgePerID);

MeanAgeUseful=mean(age);
StdAgeUseful=std(age);

MeanAgeAllMRI=mean([age' notage']);
StdAgeAllMRI=std([age' notage']);

MeanAgeNotUseful=mean(notage);
StdAgeNotUseful=std(notage);

PSAnotusefulIDs=find(~ismember(PSAUniq,IDs));
MeanAgePSAnotuseful=mean(AgePerID(PSAnotusefulIDs));
StdAgePSAnotuseful=std(AgePerID(PSAnotusefulIDs));

NoDataIDs=find(~ismember(PSAUniq,MRI.ID));
MeanAgeNoData=mean(AgePerID(NoDataIDs));
StdAgeNoData=std(AgePerID(NoDataIDs));

%%
%Create a normal distribution plot per score (makes just a bit of sense
%out of data).
allscores=[0 3:10];
meanage=zeros(size(allscores));
standev=meanage;
x=18:.1:100;

figure(1)
hold on
for i=1:length(allscores)
    ind=find(scores==allscores(i));
    meanage(i)=mean(age(ind));
    standev=std(age(ind));
    y=normpdf(x,meanage(i),standev);
    plot(x,y)
end
hold off

xlabel('Age [years]')
title(['Normal distributions of age per ',lbl,' value.'])

legend(string(allscores))

figure(2)
plot(allscores,meanage)

xlabel(lbl)
ylabel('Age [years]')
title(['Mean age per ',lbl,' value.'])

%%
figure(3)
hold on

Norm1=normpdf(x,MeanAgeAll,StdAgeAll);
plot(x,Norm1)

Norm2=normpdf(x,MeanAgePSAnotuseful,StdAgePSAnotuseful);
plot(x,Norm2)

Norm3=normpdf(x,MeanAgeAllMRI,StdAgeAllMRI);
plot(x,Norm3)

Norm4=normpdf(x,MeanAgeUseful,StdAgeUseful);
plot(x,Norm4)

Norm5=normpdf(x,MeanAgeNotUseful,StdAgeNotUseful);
plot(x,Norm5)

Norm6=normpdf(x,MeanAgeNoData,StdAgeNoData);
plot(x,Norm6)

hold off

xlabel('Age [years]')
title('Age distribution of different sets of data according to biopt data')
legend('PSA: All','PSA: Not useful','BIOPT: All','BIOPT: Useful','BIOPT: Not useful','BIOPT: No data')