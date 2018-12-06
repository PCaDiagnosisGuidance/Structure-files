%get the number of medical examinations and the order of the treatments

%read the dataset
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC);    

AllDates=[patientDatesPSA patientDatesMRI patientDatesBIOPT patientDatesECHO];
AllDates=sort(AllDates);
AllDates=AllDates(:, 1:100);

maximumID=max(PSA.ID);
Examinations=zeros(maximumID, 100);

for i=1:maximumID
    for j=1:length(AllDates(i,:));
        date=AllDates(i, j);
        if ismember(date, patientDatesPSA(i)) && Examinations(i, j)==0;
            Examinations(i, j)=1; %1 staat voor PSA
        elseif ismember(date, patientDatesMRI(i)) && Examinations(i, j)==0;
            Examinations(i, j)=2 && Examinations(i, j)==0; %2 staat voor MRI
        elseif ismember(date, patientDatesBIOPT(i));
            Examinations(i, j)=3 && Examinations(i, j)==0; %3 staat voor BIOPT
        elseif ismember(date, patientDatesECHO(i));
            Examinations(i, j)= 4 && Examinations(i, j)==0; %4 staat voor ECHO
        end
    end
 
end


%plot the number of medical examinations used
maxNrOfDetectionsPSA=max(NrOfDetectionsPSA);
TotalDetectionsPSA=zeros(maxNrOfDetectionsPSA, 1);

maxNrOfDetectionsMRI=max(NrOfDetectionsMRI);
TotalDetectionsMRI=zeros(maxNrOfDetectionsMRI, 1);

maxNrOfDetectionsBIOPT=max(NrOfDetectionsBIOPT);
TotalDetectionsBIOPT=zeros(maxNrOfDetectionsBIOPT, 1);

maxNrOfDetectionsECHO=max(NrOfDetectionsECHO);
TotalDetectionsECHO=zeros(maxNrOfDetectionsECHO, 1);

for i=1:maxNrOfDetectionsPSA
   TotalDetectionsPSA(i)=length(find(NrOfDetectionsPSA==i));
end

for i=1:maxNrOfDetectionsMRI
   TotalDetectionsMRI(i)=length(find(NrOfDetectionsMRI==i));
end

for i=1:maxNrOfDetectionsBIOPT
   TotalDetectionsBIOPT(i)=length(find(NrOfDetectionsBIOPT==i));
end

for i=1:maxNrOfDetectionsECHO
   TotalDetectionsECHO(i)=length(find(NrOfDetectionsECHO==i));
end

plotNumberofMethodsUsed(TotalDetectionsPSA, TotalDetectionsMRI, TotalDetectionsBIOPT, TotalDetectionsECHO)

% 

%%extra part I tried to get working but it didn't 
% classdef Scan
%     properties
%         Type
%         Date
%         PatientID
%         Score
%     end
% end
% 
% classdef Patient
%     properties
%         ID
%         Scans
%     end
%     methods 
%         function r = getScans()
%             r = Scans;
%         end
%     end
%end


    