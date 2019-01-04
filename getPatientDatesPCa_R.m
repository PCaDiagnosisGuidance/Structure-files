function [patientDatesPSA1, patientDatesMRI1, patientDatesBIOPT1, patientDatesECHO1, patientDatesFreePSA1, patientDatesPCa1,...
    patientDatesPSA2, patientDatesMRI2, patientDatesBIOPT2, patientDatesECHO2, patientDatesFreePSA2, patientDatesPCa2,  ...
    patientDatesPSA3, patientDatesMRI3, patientDatesBIOPT3, patientDatesECHO3, patientDatesFreePSA3, patientDatesPCa3, ...
    methodsPSA1,  methodsMRI1,  methodsBIOPT1,  methodsECHO1, methodsFreePSA1, methodsPCa1,...
    methodsPSA2,  methodsMRI2,  methodsBIOPT2,  methodsECHO2, methodsFreePSA2, methodsPCa2,...
    methodsPSA3,  methodsMRI3,  methodsBIOPT3,  methodsECHO3, methodsFreePSA3, methodsPCa3,...
    ValuePSA1, ValueMRI1, ValueBIOPT1, ValueECHO1, ValueFreePSA1, ValuePCa1, ...
    ValuePSA2, ValueMRI2, ValueBIOPT2, ValueECHO2, ValueFreePSA2, ValuePCa2, ...
    ValuePSA3, ValueMRI3, ValueBIOPT3, ValueECHO3, ValueFreePSA3, ValuePCa3]=getPatientDatesPCa_R(PSA,MRI,BIOPT,ECHO,PCa)    
% This function returns the corresponding value, date and type of every
% measurement done per patient (per row). It does this for PCa, non-PCa and
% unknown PCa patients. 

% pre-allocation of patientdates, do this for the three PCa groups (where 1
% equals PCa=1, 2 equals PCa =0 and 3 equals PCa =-1). This is necessary 
% because the three different groups have different sizes of matrices (later
% on they will have to be concatenated). PCa = -1 means the DBC code is not
% known.

%% pre-allocation of patientdates
maximumID=max(PSA.ID);

patientDatesPSA1=zeros(maximumID, 100);
patientDatesMRI1=zeros(maximumID, 100);
patientDatesBIOPT1=zeros(maximumID, 100);
patientDatesECHO1=zeros(maximumID, 100);
patientDatesFreePSA1=zeros(maximumID,100);
patientDatesPCa1=zeros(maximumID,100);

patientDatesPSA2=zeros(maximumID, 100);
patientDatesMRI2=zeros(maximumID, 100);
patientDatesBIOPT2=zeros(maximumID, 100);
patientDatesECHO2=zeros(maximumID, 100);
patientDatesFreePSA2=zeros(maximumID,100);
patientDatesPCa2=zeros(maximumID,100);

patientDatesPSA3=zeros(maximumID, 100);
patientDatesMRI3=zeros(maximumID, 100);
patientDatesBIOPT3=zeros(maximumID, 100);
patientDatesECHO3=zeros(maximumID, 100);
patientDatesFreePSA3=zeros(maximumID,100);
patientDatesPCa3=zeros(maximumID,100);

% pre-allocation of methods
methodsPSA1=zeros(maximumID, 100);
methodsMRI1=zeros(maximumID, 100);
methodsBIOPT1=zeros(maximumID, 100);
methodsECHO1=zeros(maximumID, 100);
methodsFreePSA1=zeros(maximumID, 100);
methodsPCa1=zeros(maximumID, 100);

methodsPSA2=zeros(maximumID, 100);
methodsMRI2=zeros(maximumID, 100);
methodsBIOPT2=zeros(maximumID, 100);
methodsECHO2=zeros(maximumID, 100);
methodsFreePSA2=zeros(maximumID, 100);
methodsPCa2=zeros(maximumID, 100);

methodsPSA3=zeros(maximumID, 100);
methodsMRI3=zeros(maximumID, 100);
methodsBIOPT3=zeros(maximumID, 100);
methodsECHO3=zeros(maximumID, 100);
methodsFreePSA3=zeros(maximumID, 100);
methodsPCa3=zeros(maximumID, 100);

% pre-allocation of value
ValuePSA1=zeros(maximumID, 100);
ValueMRI1=zeros(maximumID, 100);
ValueBIOPT1=zeros(maximumID, 100);
ValueECHO1 =zeros(maximumID, 100);
ValueFreePSA1=zeros(maximumID, 100);
ValuePCa1=zeros(maximumID, 100);

ValuePSA2=zeros(maximumID, 100);
ValueMRI2 =zeros(maximumID, 100);
ValueBIOPT2=zeros(maximumID, 100);
ValueECHO2=zeros(maximumID, 100);
ValueFreePSA2=zeros(maximumID, 100);
ValuePCa2=zeros(maximumID, 100);

ValuePSA3 =zeros(maximumID, 100);
ValueMRI3=zeros(maximumID, 100);
ValueBIOPT3=zeros(maximumID, 100);
ValueECHO3=zeros(maximumID, 100);
ValueFreePSA3=zeros(maximumID, 100);
ValuePCa3=zeros(maximumID, 100);


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
    PCaNr = find(PCa.ID==i);
    currentPCa = PCa.PCa(PCaNr,1);
    % If DBCNr is empty then change DBC to -1, meaning it's unknown
    if isempty(PCaNr)==1
        currentPCa = -1;
    end
    % Vraag Saray: wat gebeurt er wanneer DateNrPSA leeg is?
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Create a condition here on wether or not the respective patient has a
    % PCa of 1 or 0 (yes or no) or if it's not known (PCa = -1). Based on 
    % this it gets put into set 1,2 or 3 of the matrices respectively.

    if currentPCa == 1
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA1(i, 1:length(datesPSA))=datesPSA;
        methodsPSA1(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA1(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA1(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI1(i, 1:length(datesMRI))=datesMRI;
        methodsMRI1(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI1(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT1(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT1(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT1(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO1(i, 1:length(datesECHO))=datesECHO;
        methodsECHO1(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO1(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(PCa.ID==i);
        datesDBC=PCa.date(DateNrDBC)';
        patientDatesPCa1(i, 1:length(datesDBC))=datesDBC;
        methodsPCa1(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValuePCa1(i, 1:length(datesDBC))=PCa.PCa(DateNrDBC)';
    
    elseif currentPCa == 0
        
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA2(i, 1:length(datesPSA))=datesPSA;
        methodsPSA2(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA2(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA2(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI2(i, 1:length(datesMRI))=datesMRI;
        methodsMRI2(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI2(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT2(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT2(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT2(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO2(i, 1:length(datesECHO))=datesECHO;
        methodsECHO2(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO2(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(PCa.ID==i);
        datesDBC=PCa.date(DateNrDBC)';
        patientDatesPCa2(i, 1:length(datesDBC))=datesDBC;
        methodsPCa2(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValuePCa2(i, 1:length(datesDBC))=PCa.PCa(DateNrDBC)';
        
    elseif currentPCa == -1
        datesPSA=PSA.date(DateNrPSA)';
        patientDatesPSA3(i, 1:length(datesPSA))=datesPSA;
        methodsPSA3(i, 1:length(datesPSA))=ones(1, length(datesPSA));
        ValuePSA3(i, 1:length(datesPSA))=PSA.psa(DateNrPSA)';

        ValueFreePSA3(i, 1:length(datesPSA))=PSA.freepsa(DateNrPSA)';

        %make a matrix of dates for MRI
        DateNrMRI=find(MRI.ID==i);
        datesMRI=MRI.date(DateNrMRI)';
        patientDatesMRI3(i, 1:length(datesMRI))=datesMRI;
        methodsMRI3(i, 1:length(datesMRI))=2*ones(1, length(datesMRI));
        ValueMRI3(i, 1:length(datesMRI))=MRI.pirads(DateNrMRI)';

        %make a matrix of dates for BIOPT
        DateNrBIOPT=find(BIOPT.ID==i);
        datesBIOPT=BIOPT.date(DateNrBIOPT)';
        patientDatesBIOPT3(i, 1:length(datesBIOPT))=datesBIOPT;
        methodsBIOPT3(i, 1:length(datesBIOPT))=3*ones(1, length(datesBIOPT));
        ValueBIOPT3(i, 1:length(datesBIOPT))=BIOPT.gleason(DateNrBIOPT)';

        %make a matrix of dates for ECHO
        DateNrECHO=find(ECHO.ID==i);
        datesECHO=ECHO.date(DateNrECHO)';
        patientDatesECHO3(i, 1:length(datesECHO))=datesECHO;
        methodsECHO3(i, 1:length(datesECHO))=4*ones(1, length(datesECHO));
        ValueECHO3(i, 1:length(datesECHO))=ECHO.volume(DateNrECHO)';

        %make a matrix of dates for DBC (taking the closing date of the DBC
        DateNrDBC=find(PCa.ID==i);
        datesDBC=PCa.date(DateNrDBC)';
        patientDatesPCa3(i, 1:length(datesDBC))=datesDBC;
        methodsPCa3(i, 1:length(datesDBC))=6*ones(1, length(datesDBC));
        ValuePCa3(i, 1:length(datesDBC))=PCa.PCa(DateNrDBC)';
        
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
