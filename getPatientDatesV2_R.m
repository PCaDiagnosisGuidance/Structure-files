function [patientDatesPSA1, patientDatesMRI1, patientDatesBIOPT1, patientDatesECHO1, patientDatesFreePSA1, patientDatesDBC1,...
    patientDatesPSA2, patientDatesMRI2, patientDatesBIOPT2, patientDatesECHO2, patientDatesFreePSA2, patientDatesDBC2,  ...
    patientDatesPSA3, patientDatesMRI3, patientDatesBIOPT3, patientDatesECHO3, patientDatesFreePSA3, patientDatesDBC3, ...
    methodsPSA1,  methodsMRI1,  methodsBIOPT1,  methodsECHO1, methodsFreePSA1, methodsDBC1,...
    methodsPSA2,  methodsMRI2,  methodsBIOPT2,  methodsECHO2, methodsFreePSA2, methodsDBC2,...
    methodsPSA3,  methodsMRI3,  methodsBIOPT3,  methodsECHO3, methodsFreePSA3, methodsDBC3,...
    ValuePSA1, ValueMRI1, ValueBIOPT1, ValueECHO1, ValueFreePSA1, ValueDBC1, ...
    ValuePSA2, ValueMRI2, ValueBIOPT2, ValueECHO2, ValueFreePSA2, ValueDBC2, ...
    ValuePSA3, ValueMRI3, ValueBIOPT3, ValueECHO3, ValueFreePSA3, ValueDBC3]=getPatientDatesV2_R(PSA,MRI,BIOPT,ECHO,DBC)    

% pre-allocation of patientdates, do this for the three PSA groups (where 1 is PSA=<4, 2 is 4<PSA=<10 and 3 is PSA>10) 
% This is necessary because the three different groups have different sizes of matrices. Later on they will have to be concatenated.

%% pre-allocation of patientdates
maximumID=max(PSA.ID);

patientDatesPSA1=zeros(maximumID, 100);
patientDatesMRI1=zeros(maximumID, 100);
patientDatesBIOPT1=zeros(maximumID, 100);
patientDatesECHO1=zeros(maximumID, 100);
patientDatesFreePSA1=zeros(maximumID,100);
patientDatesDBC1=zeros(maximumID,100);

patientDatesPSA2=zeros(maximumID, 100);
patientDatesMRI2=zeros(maximumID, 100);
patientDatesBIOPT2=zeros(maximumID, 100);
patientDatesECHO2=zeros(maximumID, 100);
patientDatesFreePSA2=zeros(maximumID,100);
patientDatesDBC2=zeros(maximumID,100);

patientDatesPSA3=zeros(maximumID, 100);
patientDatesMRI3=zeros(maximumID, 100);
patientDatesBIOPT3=zeros(maximumID, 100);
patientDatesECHO3=zeros(maximumID, 100);
patientDatesFreePSA3=zeros(maximumID,100);
patientDatesDBC3=zeros(maximumID,100);

% pre-allocation of methods
methodsPSA1=zeros(maximumID, 100);
methodsMRI1=zeros(maximumID, 100);
methodsBIOPT1=zeros(maximumID, 100);
methodsECHO1=zeros(maximumID, 100);
methodsFreePSA1=zeros(maximumID, 100);
methodsDBC1=zeros(maximumID, 100);

methodsPSA2=zeros(maximumID, 100);
methodsMRI2=zeros(maximumID, 100);
methodsBIOPT2=zeros(maximumID, 100);
methodsECHO2=zeros(maximumID, 100);
methodsFreePSA2=zeros(maximumID, 100);
methodsDBC2=zeros(maximumID, 100);

methodsPSA3=zeros(maximumID, 100);
methodsMRI3=zeros(maximumID, 100);
methodsBIOPT3=zeros(maximumID, 100);
methodsECHO3=zeros(maximumID, 100);
methodsFreePSA3=zeros(maximumID, 100);
methodsDBC3=zeros(maximumID, 100);

% pre-allocation of value
ValuePSA1=zeros(maximumID, 100);
ValueMRI1=zeros(maximumID, 100);
ValueBIOPT1=zeros(maximumID, 100);
ValueECHO1 =zeros(maximumID, 100);
ValueFreePSA1=zeros(maximumID, 100);
ValueDBC1=zeros(maximumID, 100);

ValuePSA2=zeros(maximumID, 100);
ValueMRI2 =zeros(maximumID, 100);
ValueBIOPT2=zeros(maximumID, 100);
ValueECHO2=zeros(maximumID, 100);
ValueFreePSA2=zeros(maximumID, 100);
ValueDBC2=zeros(maximumID, 100);

ValuePSA3 =zeros(maximumID, 100);
ValueMRI3=zeros(maximumID, 100);
ValueBIOPT3=zeros(maximumID, 100);
ValueECHO3=zeros(maximumID, 100);
ValueFreePSA3=zeros(maximumID, 100);
ValueDBC3=zeros(maximumID, 100);

%% Create a matrix of the dates an examination is done per patientnumber 
% (one row = one patient)
% Create a matrix of the dates an examination is done per patientnumber 
% (one row = one patient)

for i=1:maximumID
%   for i=1:length(techniques)
    %make a matrix of dates for PSA
    
    % VOEG HIER NOG STUK SARAY TOE, ZODAT DIE ALLEEN KIJKT NAAR UNIEKE ID'S
    % NU GEEFT HET SCRIPT EEN FOUTMELDING WANNEER DateNrPSA leeg is.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DateNrPSA=find(PSA.ID==i);
    % Take only the first PSA measurement date to compare to the thresholds
    % if it's empty then nothing will be added
    if isempty(DateNrPSA)==1
        DateNrFirstPSA = DateNrPSA;
    else
        DateNrFirstPSA=DateNrPSA(1,1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Create a condition here on wether or not the respective patient has a
    % PSA value under 4, between 4 and 10 or higher than 10. Based on this

    % it puts the values in one of the three sets of matrices (1,2 or 3).
    if PSA.psa(DateNrFirstPSA,1)<=4

        NrOfDetectionsPSA1(i)=length(DateNrPSA);
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA1(i, 1:length(datesPSA))=datesPSA;
        methodsPSA1(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA1(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA1(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        NrOfDetectionsMRI1(i)=length(DateNrMRI);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI1(i, 1:length(datesMRI))=datesMRI;
        methodsMRI1(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI1(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        NrOfDetectionsBIOPT1(i)=length(DateNrBIOPT);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT1(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT1(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT1(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        NrOfDetectionsECHO1(i)=length(DateNrECHO);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO1(i, 1:length(datesECHO))=datesECHO;
        methodsECHO1(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO1(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(DBC.ID==i);
        NrOfDetectionsDBC1(i)=length(DateNrDBC);
        datesDBC=DBC.edate(DateNrDBC)';
        patientDatesDBC1(i, 1:length(datesDBC))=datesDBC;
        methodsDBC1(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValueDBC1(i, 1:length(datesDBC))=DBC.PCa(DateNrDBC)';
    
    elseif PSA.psa(DateNrFirstPSA,1)>4 & PSA.psa(DateNrFirstPSA)<=10
        
        NrOfDetectionsPSA2(i)=length(DateNrPSA);
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA2(i, 1:length(datesPSA))=datesPSA;
        methodsPSA2(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA2(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA2(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        NrOfDetectionsMRI2(i)=length(DateNrMRI);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI2(i, 1:length(datesMRI))=datesMRI;
        methodsMRI2(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI2(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        NrOfDetectionsBIOPT2(i)=length(DateNrBIOPT);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT2(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT2(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT2(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        NrOfDetectionsECHO2(i)=length(DateNrECHO);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO2(i, 1:length(datesECHO))=datesECHO;
        methodsECHO2(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO2(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(DBC.ID==i);
        NrOfDetectionsDBC2(i)=length(DateNrDBC);
        datesDBC=DBC.edate(DateNrDBC)';
        patientDatesDBC2(i, 1:length(datesDBC))=datesDBC;
        methodsDBC2(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValueDBC2(i, 1:length(datesDBC))=DBC.PCa(DateNrDBC)';
        
    elseif PSA.psa(DateNrFirstPSA,1)>10
        NrOfDetectionsPSA3(i)=length(DateNrPSA);
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA3(i, 1:length(datesPSA))=datesPSA;
        methodsPSA3(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA3(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA3(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        NrOfDetectionsMRI3(i)=length(DateNrMRI);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI3(i, 1:length(datesMRI))=datesMRI;
        methodsMRI3(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI3(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        NrOfDetectionsBIOPT3(i)=length(DateNrBIOPT);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT3(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT3(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT3(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        NrOfDetectionsECHO3(i)=length(DateNrECHO);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO3(i, 1:length(datesECHO))=datesECHO;
        methodsECHO3(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO3(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(DBC.ID==i);
        NrOfDetectionsDBC3(i)=length(DateNrDBC);
        datesDBC=DBC.edate(DateNrDBC)';
        patientDatesDBC3(i, 1:length(datesDBC))=datesDBC;
        methodsDBC3(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValueDBC3(i, 1:length(datesDBC))=DBC.PCa(DateNrDBC)';
    end
end
    
% FreePSA is a special case as this information is contained in the same
% dataset as PSA. First an assessment is made on wether or not the FPSA
% value exists (>0) or not (=0). Based on this the respective matrices gain
% a value attached to FPSA. This is done for the three PSA groups.
patientDatesFreePSA1=zeros(maximumID, size(patientDatesPSA1, 2));
for i=1:size(ValueFreePSA1, 1)
    for j=1:size(ValueFreePSA1, 2)
        if ValueFreePSA1(i, j)>0
            patientDatesFreePSA1(i, j)=patientDatesPSA1(i, j);
            methodsFreePSA1(i, j)=5;
        else
            patientDatesFreePSA1(i, j)=0;
            methodsFreePSA1(i, j)=0;
        end
    end
end

patientDatesFreePSA2=zeros(maximumID, size(patientDatesPSA2, 2));
for i=1:size(ValueFreePSA2, 1)
    for j=1:size(ValueFreePSA2, 2)
        if ValueFreePSA2(i, j)>0
            patientDatesFreePSA2(i, j)=patientDatesPSA2(i, j);
            methodsFreePSA2(i, j)=5;
        else
            patientDatesFreePSA2(i, j)=0;
            methodsFreePSA2(i, j)=0;
        end
    end
end

patientDatesFreePSA3=zeros(maximumID, size(patientDatesPSA3, 2));
for i=1:size(ValueFreePSA3, 1)
    for j=1:size(ValueFreePSA3, 2)
        if ValueFreePSA3(i, j)>0
            patientDatesFreePSA3(i, j)=patientDatesPSA3(i, j);
            methodsFreePSA3(i, j)=5;
        else
            patientDatesFreePSA3(i, j)=0;
            methodsFreePSA3(i, j)=0;
        end
    end
end
    
end
