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

%% PSAwindow
ind=find(PSAperID >= PSAwindow(1) & PSAperID < PSAwindow(2));
AgePerID=AgePerID(ind);
PSAperID=PSAperID(ind);
BIOPTmember=BIOPTmember(ind);
MRImember=MRImember(ind);
ECHOmember=ECHOmember(ind);
DBCmember=DBCmember(ind);

%% Regressions
X=[ones(size(AgePerID)) AgePerID PSAperID];

[B_BIOPT,confIntBIOPT,~,~,R2Fp_BIOPT]=regress(BIOPTmember,X);
[B_MRI,confIntMRI,~,~,R2Fp_MRI]=regress(MRImember,X);
[B_ECHO,confIntECHO,~,~,R2Fp_ECHO]=regress(ECHOmember,X);
[B_DBC,confIntDBC,~,~,R2Fp_DBC]=regress(DBCmember,X);

[BioptAgeStats,BioptAgeRanksum]=DispersionStats(AgePerID(BIOPTmember==0),AgePerID(BIOPTmember==1));
[BioptPSAstats,BioptPSAranksum]=DispersionStats(PSAperID(BIOPTmember==0),PSAperID(BIOPTmember==1));

[MRIAgeStats,MRIAgeRanksum]=DispersionStats(AgePerID(MRImember==0),AgePerID(MRImember==1));
[MRIPSAstats,MRIPSAranksum]=DispersionStats(PSAperID(MRImember==0),PSAperID(MRImember==1));

[ECHOAgeStats,ECHOAgeRanksum]=DispersionStats(AgePerID(ECHOmember==0),AgePerID(ECHOmember==1));
[ECHOPSAstats,ECHOPSAranksum]=DispersionStats(PSAperID(ECHOmember==0),PSAperID(ECHOmember==1));

[DBCAgeStats,DBCAgeRanksum]=DispersionStats(AgePerID(DBCmember==0),AgePerID(DBCmember==1));
[DBCPSAstats,DBCPSAranksum]=DispersionStats(PSAperID(DBCmember==0),PSAperID(DBCmember==1));