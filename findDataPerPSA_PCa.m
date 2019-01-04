function [AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
    AllValuesperPSA3, methodsperPSA3, PCa_code]=findDataPerPSA_PCa(Dates1, Dates2, Dates3, Methods1, Methods2, Methods3, Values1, Values2, Values3, patientDatesPSA1, patientDatesPSA2, patientDatesPSA3, minBoundary, maxBoundary)

%find timeslots based PSA data. 
%Order of steps taken in the script
%1)Read out of data
%2)Gets all PSA, MRI, BIOPT and ECHO data per patient and a list of which
%method is used
%3)Gives one big list of dates and methods used per patient
%4)Sort the methods used based on the dates
%5)Find the first PSA examination used
%6)find the maximal and minimal time of the timeslot
%7)find all the examinations done in this timeslot

%read the dataset
close all

%find the Dates per patient per method and how many times it is detected. 
%Also find out which method is used at which time

maximumID=size(Dates1, 1); %find the maximal patient ID (how many patients we have in the dataset)

% Loop over all dates, methods and values for the three PSA groups
for k = 1:3 
    if k == 1
    %Making a list of all the dates sorted
    AllDates=Dates1;
    AllMethods=Methods1;
    AllValues=Values1;
    [AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods
   
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
    for i=1:maximumID
        for j=1:size(AllMethods, 2)
            AllMethods2(i, j)=AllMethods(i, IndexDates(i, j));
            AllValues2(i, j)=AllValues(i, IndexDates(i, j));
        end
    end
        methodsperPSA1=zeros(maximumID, size(AllMethods2, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        AllValuesperPSA1=zeros(maximumID, size(AllValues2, 2));
        PCa_code1=-1*ones(maximumID, 1);

        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA1(i, :))>0 %remove all patient without a PSA measurement
                firstPSA=find(AllMethods2(i, :)==1, 1, 'first'); %find the first PSA measurement
                firstPCa=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa)==1;
                    PCa_code1(i)=AllValues2(i, firstPCa);
                end
                minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=90) && (AllDates(i, j)>minDates);
                        methodsperPSA1(i, j)=AllMethods2(i, j);
                        AllValuesperPSA1(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
    end
    
    
    clear firstPSA firstPCa minDates maxDates AllMethods2 AllValues2 AllDates ...
        IndexDates AllValues AllMethods AllDates
    if k == 2
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
                firstPCa=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa)==1;
                    PCa_code2(i)=AllValues2(i, firstPCa);
                end
                minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=90) && (AllDates(i, j)>minDates);
                        methodsperPSA2(i, j)=AllMethods2(i, j);
                        AllValuesperPSA2(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
    end
    
    clear firstPSA firstPCa minDates maxDates AllMethods2 AllValues2 AllDates ...
        IndexDates AllValues AllMethods AllDates
    if k == 3 
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
                firstPCa=find(AllMethods2(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa)==1;
                    PCa_code3(i)=AllValues2(i, firstPCa);
                end
                minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
                maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
                for j=1:size(AllMethods2, 2)
                    if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=90) && (AllDates(i, j)>minDates);
                        methodsperPSA3(i, j)=AllMethods2(i, j);
                        AllValuesperPSA3(i, j)=AllValues2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
    end
        
     
end
PCa_code=[PCa_code1, PCa_code2, PCa_code3];

end