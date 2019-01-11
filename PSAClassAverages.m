%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

clearvars -except BIOPT DBC ECHO MRI PSA PCa

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

FirstStats=DispersionStats(AgePerID,PSAperID);

AllStats=DispersionStats(PSA.age,PSA.psa);