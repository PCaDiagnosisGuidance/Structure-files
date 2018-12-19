clearvars -except BIOPT MRI PSA ECHO DBC
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

%% PSAwindow
ind=find(PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
AgePerID=AgePerID(ind);
PSAperID=PSAperID(ind);
BIOPTmember=BIOPTmember(ind);
MRImember=MRImember(ind);
ECHOmember=ECHOmember(ind);

%% Regressions
X=[ones(size(AgePerID)) AgePerID PSAperID];

[B_BIOPT,confIntBIOPT,~,~,R2Fp_BIOPT]=regress(BIOPTmember,X);
[B_MRI,confIntMRI,~,~,R2Fp_MRI]=regress(MRImember,X);
[B_ECHO,confIntECHO,~,~,R2Fp_ECHO]=regress(ECHOmember,X);

figure(1)
scatter3(AgePerID,PSAperID,BIOPTmember,'filled')
hold on
x1fit=min(AgePerID):max(AgePerID);
x2fit=min(PSAperID):(max(PSAperID)-min(PSAperID))/100:max(PSAperID);
[X1FIT,X2FIT]=meshgrid(x1fit,x2fit);
YFIT=B_BIOPT(1)+B_BIOPT(2)*X1FIT+B_BIOPT(3)*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
hold off