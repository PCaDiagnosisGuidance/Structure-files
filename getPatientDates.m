function [patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, patientDatesFreePSA, patientDatesDBC...
    NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO,  ...
    methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA, methodsDBC...
    ValuePSA, ValueMRI, ValueBIOPT, ValueECHO, ValueFreePSA, ValueDBC]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC)    

maximumID=max(PSA.ID);
% patientDatesPSA=zeros(maximumID, 100);
% patientDatesMRI=zeros(maximumID, 100);
% patientDatesBIOPT=zeros(maximumID, 100);
% patientDatesECHO=zeros(maximumID, 100);
% NrOfDetectionsPSA=zeros(maximumID, 1); % deze worden sowieso niet gebruikt vm
% NrOfDetectionsMRI = zeros(maximumID,1); 
% NrOfDetectionsBIOPT = zeros(maximumID,1);
% NrOfDetectionsECHO = zeros(maximumID,1);
% NrOfDetectionsDBC = zeros(maximumID,1);
% NrOfDetectionsFPSA = zeros(maximumID,1); waarom bestaat deze niet? 
% 
% methodsPSA=zeros(maximumID, 100);
% methodsMRI=zeros(maximumID, 100);
% methodsBIOPT=zeros(maximumID, 100);
% methodsECHO=zeros(maximumID, 100);
% techniques=[PSA, MRI, BIOPT, ECHO];
% Create a matrix of the dates an examination is done per patientnumber 
% (one row = one patient)

UnderFourPSA = find(PSA.psa<=4);
FourToTenPSA = find(PSA.psa>4 & PSA.psa<=10);
AboveTenPSA = find(PSA.psa>10);


for i=1:length(maximumdID)
%   for i=1:length(techniques)
    %make a matrix of dates for PSA
    
    DateNrPSA=find(PSA.ID==i);
   
        NrOfDetectionsPSA(i)=length(DateNrPSA);
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA(i, 1:length(datesPSA))=datesPSA;
        methodsPSA(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        NrOfDetectionsMRI(i)=length(DateNrMRI);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI(i, 1:length(datesMRI))=datesMRI;
        methodsMRI(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        NrOfDetectionsBIOPT(i)=length(DateNrBIOPT);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        NrOfDetectionsECHO(i)=length(DateNrECHO);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO(i, 1:length(datesECHO))=datesECHO;
        methodsECHO(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(DBC.ID==i);
        NrOfDetectionsDBC(i)=length(DateNrDBC);
        datesDBC=DBC.edate(DateNrDBC)';
        patientDatesDBC(i, 1:length(datesDBC))=datesDBC;
        methodsDBC(i, 1:length(datesDBC))=5*ones(1, length(datesDBC));
        ValueDBC(i, 1:length(datesDBC))=DBC.PCa(DateNrDBC)';
    
end
    
    
patientDatesFreePSA=zeros(maximumID, size(patientDatesPSA, 2));
for i=1:size(ValueFreePSA, 1)
    for j=1:size(ValueFreePSA, 2)
        if ValueFreePSA(i, j)>0
            patientDatesFreePSA(i, j)=patientDatesPSA(i, j);
            methodsFreePSA(i, j)=5;
        else
            patientDatesFreePSA(i, j)=0;
            methodsFreePSA(i, j)=0;
        end
    end
end
    
