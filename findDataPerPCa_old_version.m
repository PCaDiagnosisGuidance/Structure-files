function [AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
    AllValuesperPSA3, methodsperPSA3, PCa_code]=findDataPerPCa_old_version(PSA,MRI,BIOPT,ECHO,PCa, minBoundary, maxBoundary)

%find timeslots based PSA data. 
%Order of steps taken in the script
%1)Get a list of all measurements performed per patient, all values for these measurements and all dates of the measurement.
%  The patients are sorted in a PSA group, so (1)PSA=<4  (2)4<PSA<=10 and (3)PSA>10
%2)Sort all the measurement done and the values given in chronological order. 
%3)Find the first PSA examination used
%4)find the maximal and minimal time of the timeslot
%5)find all the examinations done in this timeslot


%  Get a list of measurements per technique performed per patient with the combining values and dates of the measurements.
%  These patients are thereby sorted in a PSA group based on their first
%  PSA measurement.
[patientDatesPSA1, patientDatesMRI1, patientDatesBIOPT1, patientDatesECHO1, patientDatesFreePSA1, patientDatesPCa1,...
    patientDatesPSA2, patientDatesMRI2, patientDatesBIOPT2, patientDatesECHO2, patientDatesFreePSA2, patientDatesPCa2,  ...
    patientDatesPSA3, patientDatesMRI3, patientDatesBIOPT3, patientDatesECHO3, patientDatesFreePSA3, patientDatesPCa3, ...
    methodsPSA1,  methodsMRI1,  methodsBIOPT1,  methodsECHO1, methodsFreePSA1, methodsPCa1,...
    methodsPSA2,  methodsMRI2,  methodsBIOPT2,  methodsECHO2, methodsFreePSA2, methodsPCa2,...
    methodsPSA3,  methodsMRI3,  methodsBIOPT3,  methodsECHO3, methodsFreePSA3, methodsPCa3,...
    ValuePSA1, ValueMRI1, ValueBIOPT1, ValueECHO1, ValueFreePSA1, ValuePCa1, ...
    ValuePSA2, ValueMRI2, ValueBIOPT2, ValueECHO2, ValueFreePSA2, ValuePCa2, ...
    ValuePSA3, ValueMRI3, ValueBIOPT3, ValueECHO3, ValueFreePSA3, ValuePCa3]=getPatientDatesPSAgroups_R(PSA,MRI,BIOPT,ECHO,PCa);    

% Combine all patient per method into one list of all methods/values/dates
% per patient
Dates1 = [patientDatesPSA1, patientDatesMRI1, patientDatesBIOPT1, patientDatesECHO1, patientDatesFreePSA1, patientDatesPCa1];
Dates2 = [patientDatesPSA2, patientDatesMRI2, patientDatesBIOPT2, patientDatesECHO2, patientDatesFreePSA2, patientDatesPCa2];
Dates3 = [patientDatesPSA3, patientDatesMRI3, patientDatesBIOPT3, patientDatesECHO3, patientDatesFreePSA3, patientDatesPCa3];
Methods1 = [methodsPSA1,  methodsMRI1,  methodsBIOPT1,  methodsECHO1, methodsFreePSA1, methodsPCa1];
Methods2 = [methodsPSA2,  methodsMRI2,  methodsBIOPT2,  methodsECHO2, methodsFreePSA2, methodsPCa2];
Methods3 = [methodsPSA3,  methodsMRI3,  methodsBIOPT3,  methodsECHO3, methodsFreePSA3, methodsPCa3];
Values1 = [ValuePSA1, ValueMRI1, ValueBIOPT1, ValueECHO1, ValueFreePSA1, ValuePCa1];
Values2 = [ValuePSA2, ValueMRI2, ValueBIOPT2, ValueECHO2, ValueFreePSA2, ValuePCa2];
Values3 = [ValuePSA3, ValueMRI3, ValueBIOPT3, ValueECHO3, ValueFreePSA3, ValuePCa3];

maximumID=max(PSA.ID); %find the maximal patient ID (how many patients we have in the dataset)

% Loop over all dates, methods and values for the three PSA groups
for k = 1:3 
    if k == 1 %This is the group of patients with PSA<=4
    %Making a list of all the dates sorted
    AllDates=Dates1;
    AllMethods=Methods1;
    AllValues=Values1;
    [AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods
    
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods and values sorted on date. 
    for i=1:maximumID
        for j=1:size(AllMethods, 2)
            AllMethods2(i, j)=AllMethods(i, IndexDates(i, j)); %sorted list
            AllValues2(i, j)=AllValues(i, IndexDates(i, j)); %sorted list
        end
    end
    
        methodsperPSA1=zeros(maximumID, size(AllMethods2, 2));
        AllValuesperPSA1=zeros(maximumID, size(AllValues2, 2));
        PCa_code1=-1*ones(maximumID, 1); %will be initiated as -1 (unknown)
        
        %find the methods used and corresponding values in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA1(i, :))>0                      %remove all patient without a PSA measurement
                firstPSA=find(AllMethods2(i, :)==1, 1, 'first');  %find the first PSA measurement
                minDates=AllDates(i, firstPSA)-minBoundary;       %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary;       %find maximal date in timeslot
                firstPCa1=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first PCa value
                
                %PCA_code1 is a list of the first PCa values per patient with PSA<=4
                if length(firstPCa1)==1;
                    PCa_code1(i)=AllValues2(i, firstPCa1);
                end
                
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=maxBoundary) && (AllDates(i, j)>minDates)
                        methodsperPSA1(i, j)=AllMethods2(i, j);
                        AllValuesperPSA1(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be the maxboundary (to
                        %avoid getting values for a date of 0)
                    end
                end

            end

        end
    end
    
    
    clear firstPSA minDates maxDates AllMethods2 AllValues2 AllDates ...
        IndexDates AllValues AllMethods AllDates
    
    if k == 2  %for 4<PSA<=10
    %Making a list of all the dates sorted
    AllDates=Dates2;
    AllMethods=Methods2;
    AllValues=Values2;
    [AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods
    
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
    for i=1:maximumID
        for j=1:size(AllMethods, 2)
            AllMethods2(i, j)=AllMethods(i, IndexDates(i, j));
            AllValues2(i, j)=AllValues(i, IndexDates(i, j));
        end
    end
        methodsperPSA2=zeros(maximumID, size(AllMethods2, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        AllValuesperPSA2=zeros(maximumID, size(AllValues2, 2));
        PCa_code2=-1*ones(maximumID, 1);

        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA2(i, :))>0 %remove all patient without a PSA measurement
                firstPSA=find(AllMethods2(i, :)==1, 1, 'first'); %find the first PSA measurement
                minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
                firstPCa2=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first PCa value
                
                if length(firstPCa2)==1;
                    PCa_code2(i)=AllValues2(i, firstPCa2); %the first PCa value of this patient
                end
                
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=maxBoundary) && (AllDates(i, j)>minDates)
                        methodsperPSA2(i, j)=AllMethods2(i, j);
                        AllValuesperPSA2(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be the maxboundary (to
                        %avoid getting values for a date of 0)
                    end
                end

            end

        end
    end
    
    clear firstPSA minDates maxDates AllMethods2 AllValues2 AllDates ...
        IndexDates AllValues AllMethods AllDates
    
    if k == 3 %for PSA>10
    %Making a list of all the dates sorted
    AllDates=Dates3;
    AllMethods=Methods3;
    AllValues=Values3;
    [AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods
   
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
    for i=1:maximumID
        for j=1:size(AllMethods, 2)
            AllMethods2(i, j)=AllMethods(i, IndexDates(i, j));
            AllValues2(i, j)=AllValues(i, IndexDates(i, j));
        end
    end
        methodsperPSA3=zeros(maximumID, size(AllMethods2, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        AllValuesperPSA3=zeros(maximumID, size(AllValues2, 2));
        PCa_code3=-1*ones(maximumID, 1);
        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA3(i, :))>0 %remove all patient without a PSA measurement
                firstPSA=find(AllMethods2(i, :)==1, 1, 'first'); %find the first PSA measurement
                minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
                firstPCa3=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first PCa value
                
                if length(firstPCa3)==1;
                    PCa_code3(i)=AllValues2(i, firstPCa3); %the first PCa value of this patient
                end
                
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=maxBoundary) && (AllDates(i, j)>minDates)
                        methodsperPSA3(i, j)=AllMethods2(i, j);
                        AllValuesperPSA3(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be the maxboundary (to
                        %avoid getting values for a date of 0)
                    end
                end

            end

        end
    end
            
end
PCa_code=[PCa_code1, PCa_code2, PCa_code3]; %make a size(maximumID, 3) matrix for all the PCa values
end