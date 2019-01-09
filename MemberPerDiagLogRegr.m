clearvars -except BIOPT MRI PSA ECHO DBC PCa
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Inputs
PSAwindow=[-Inf Inf];   %[-Inf Inf] [4 10]

%% Creation of PSA per ID dataset
%Definitions for means of PSA and age per patient (ID)
PSAUniq=unique(PSA.ID);
PSAperID=zeros(size(PSAUniq));
AgePerID=PSAperID;

%Calculating first PSA val and age per patient
for i=1:length(PSAUniq)
    PSAarr=PSA.psa(PSA.ID==PSAUniq(i));
    AgeArr=PSA.age(PSA.ID==PSAUniq(i));
    PSAperID(i)=PSAarr(1);
    AgePerID(i)=AgeArr(1);
end

%% Creating member arrays
BIOPTmember=ismember(PSAUniq,BIOPT.ID);
MRImember=ismember(PSAUniq,MRI.ID);
ECHOmember=ismember(PSAUniq,ECHO.ID);
DBCmember=ismember(PSAUniq,DBC.ID);

%% PSAwindow application
ind=find(PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
AgePerID=AgePerID(ind);
PSAperID=PSAperID(ind);
BIOPTmember=categorical(BIOPTmember(ind));
MRImember=categorical(MRImember(ind));
ECHOmember=categorical(ECHOmember(ind));
DBCmember=categorical(DBCmember(ind));

%% Regressions
X=[AgePerID PSAperID];

%Adding zeros for distinction beta, conf. intervals and p.
[~,~,stats]=mnrfit(X,BIOPTmember);
BIOPTdata=[stats.beta(:,1) zeros(3,1) stats.beta-1.96*stats.se stats.beta+1.96*stats.se zeros(3,1) stats.p];

[~,~,stats]=mnrfit(X,MRImember);
MRIdata=[stats.beta(:,1) zeros(3,1) stats.beta-1.96*stats.se stats.beta+1.96*stats.se zeros(3,1) stats.p];

[~,~,stats]=mnrfit(X,ECHOmember);
ECHOdata=[stats.beta(:,1) zeros(3,1) stats.beta-1.96*stats.se stats.beta+1.96*stats.se zeros(3,1) stats.p];

[~,~,stats]=mnrfit(X,DBCmember);
DBCdata=[stats.beta(:,1) zeros(3,1) stats.beta-1.96*stats.se stats.beta+1.96*stats.se zeros(3,1) stats.p];