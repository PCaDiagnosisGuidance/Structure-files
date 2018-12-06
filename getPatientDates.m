function [patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO,  methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC)    

maximumID=max(PSA.ID);
% patientDatesPSA=zeros(maximumID, 100);
% patientDatesMRI=zeros(maximumID, 100);
% patientDatesBIOPT=zeros(maximumID, 100);
% patientDatesECHO=zeros(maximumID, 100);
% NrOfDetectionsPSA=zeros(maximumID, 1);
% 
% methodsPSA=zeros(maximumID, 100);
% methodsMRI=zeros(maximumID, 100);
% methodsBIOPT=zeros(maximumID, 100);
% methodsECHO=zeros(maximumID, 100);
%techniques=[PSA, MRI, BIOPT, ECHO];
%create a matrix of the dates a examination is done per patientnumber (one
%row = one patient)
for i=1:maximumID
%   for i=1:length(techniques)
    %make a matrix of dates for PSA
    DateNrPSA=find(PSA.ID==i);
    NrOfDetectionsPSA(i)=length(DateNrPSA);
    datesPSA=sort(PSA.date(DateNrPSA)');
    patientDatesPSA(i, 1:length(datesPSA))=datesPSA;
    methodsPSA(i, 1:length(datesPSA))=ones(1, length(datesPSA));
    %end
    
    %make a matrix of dates for MRI
    DateNrMRI=find(MRI.ID==i);
    NrOfDetectionsMRI(i)=length(DateNrMRI);
    datesMRI=sort(MRI.date(DateNrMRI)');
    patientDatesMRI(i, 1:length(datesMRI))=datesMRI;
    methodsMRI(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
    
    %make a matrix of dates for BIOPT
    DateNrBIOPT=find(BIOPT.ID==i);
    NrOfDetectionsBIOPT(i)=length(DateNrBIOPT);
    datesBIOPT=sort(BIOPT.date(DateNrBIOPT)');
    patientDatesBIOPT(i, 1:length(datesBIOPT))=datesBIOPT;
    methodsBIOPT(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
    
    %make a matrix of dates for ECHO
    DateNrECHO=find(ECHO.ID==i);
    NrOfDetectionsECHO(i)=length(DateNrECHO);
    datesECHO=sort(ECHO.date(DateNrECHO)');
    patientDatesECHO(i, 1:length(datesECHO))=datesECHO;
    methodsECHO(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
end