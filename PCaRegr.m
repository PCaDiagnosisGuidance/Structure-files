clearvars -except BIOPT MRI PSA ECHO DBC PCa
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Inputs
PSAwindow=[4 10];   %[-Inf Inf] [4 10]

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
BIOPTind=find(ismember(PCa.ID,BIOPT.ID));
MRIind=find(ismember(PCa.ID,MRI.ID));
ECHOind=find(ismember(PCa.ID,ECHO.ID));
DBCind=find(ismember(PCa.ID,DBC.ID));

BIOPTPCa=PCa.PCa(BIOPTind);
MRIPCa=PCa.PCa(MRIind);
ECHOPCa=PCa.PCa(ECHOind);
DBCPCa=PCa.PCa(DBCind);

BIOPTIDs=PCa.ID(BIOPTind);
MRIIDs=PCa.ID(MRIind);
ECHOIDs=PCa.ID(ECHOind);
DBCIDs=PCa.ID(DBCind);

BIOPTAgePerID=AgePerID(ismember(PSAUniq,BIOPTIDs));
BIOPTPSAperID=PSAperID(ismember(PSAUniq,BIOPTIDs));

MRIAgePerID=AgePerID(ismember(PSAUniq,MRIIDs));
MRIPSAperID=PSAperID(ismember(PSAUniq,MRIIDs));

ECHOAgePerID=AgePerID(ismember(PSAUniq,ECHOIDs));
ECHOPSAperID=PSAperID(ismember(PSAUniq,ECHOIDs));

DBCAgePerID=AgePerID(ismember(PSAUniq,DBCIDs));
DBCPSAperID=PSAperID(ismember(PSAUniq,DBCIDs));

%% PSAwindow
ind=find(BIOPTPSAperID >= PSAwindow(1) & BIOPTPSAperID < PSAwindow(2));
BIOPTAgePerID=BIOPTAgePerID(ind);
BIOPTPSAperID=BIOPTPSAperID(ind);
BIOPTPCa=BIOPTPCa(ind);

ind=find(MRIPSAperID >= PSAwindow(1) & MRIPSAperID < PSAwindow(2));
MRIAgePerID=MRIAgePerID(ind);
MRIPSAperID=MRIPSAperID(ind);
MRIPCa=MRIPCa(ind);

ind=find(ECHOPSAperID >= PSAwindow(1) & ECHOPSAperID < PSAwindow(2));
ECHOAgePerID=ECHOAgePerID(ind);
ECHOPSAperID=ECHOPSAperID(ind);
ECHOPCa=ECHOPCa(ind);

ind=find(DBCPSAperID >= PSAwindow(1) & DBCPSAperID < PSAwindow(2));
DBCAgePerID=DBCAgePerID(ind);
DBCPSAperID=DBCPSAperID(ind);
DBCPCa=DBCPCa(ind);

%% Regressions
BIOPTX=[ones(size(BIOPTAgePerID)) BIOPTAgePerID BIOPTPSAperID];
MRIX=[ones(size(MRIAgePerID)) MRIAgePerID MRIPSAperID];
ECHOX=[ones(size(ECHOAgePerID)) ECHOAgePerID ECHOPSAperID];
DBCX=[ones(size(DBCAgePerID)) DBCAgePerID DBCPSAperID];

[B_BIOPT,confIntBIOPT,~,~,R2Fp_BIOPT]=regress(BIOPTPCa,BIOPTX);
[B_MRI,confIntMRI,~,~,R2Fp_MRI]=regress(MRIPCa,MRIX);
[B_ECHO,confIntECHO,~,~,R2Fp_ECHO]=regress(ECHOPCa,ECHOX);
[B_DBC,confIntDBC,~,~,R2Fp_DBC]=regress(DBCPCa,DBCX);

figure(1)
scatter3(BIOPTAgePerID,BIOPTPSAperID,BIOPTPCa,'filled')
hold on
x1fit = min(BIOPTAgePerID):max(BIOPTAgePerID);
x2fit = min(BIOPTPSAperID):.1:max(BIOPTPSAperID);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = B_BIOPT(1) + B_BIOPT(2)*X1FIT + B_BIOPT(3)*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('Age')
ylabel('PSA')
zlabel('PCa')
hold off

[BioptAgeStats,BioptAgeRanksum]=DispersionStats(BIOPTAgePerID(BIOPTPCa==0),BIOPTAgePerID(BIOPTPCa==1));
[BioptPSAstats,BioptPSAranksum]=DispersionStats(BIOPTPSAperID(BIOPTPCa==0),BIOPTPSAperID(BIOPTPCa==1));

[MRIAgeStats,MRIAgeRanksum]=DispersionStats(MRIAgePerID(MRIPCa==0),MRIAgePerID(MRIPCa==1));
[MRIPSAstats,MRIPSAranksum]=DispersionStats(MRIPSAperID(MRIPCa==0),MRIPSAperID(MRIPCa==1));

[ECHOAgeStats,ECHOAgeRanksum]=DispersionStats(ECHOAgePerID(ECHOPCa==0),ECHOAgePerID(ECHOPCa==1));
[ECHOPSAstats,ECHOPSAranksum]=DispersionStats(ECHOPSAperID(ECHOPCa==0),ECHOPSAperID(ECHOPCa==1));

[DBCAgeStats,DBCAgeRanksum]=DispersionStats(DBCAgePerID(DBCPCa==0),DBCAgePerID(DBCPCa==1));
[DBCPSAstats,DBCPSAranksum]=DispersionStats(DBCPSAperID(DBCPCa==0),DBCPSAperID(DBCPCa==1));