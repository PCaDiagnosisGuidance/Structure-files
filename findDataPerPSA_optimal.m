function methodsperPSA=findDataPerPSA_optimal(patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, patientDatesFreePSA, methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA, minBoundary, maxBoundary, methodsperPSA)

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
%[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, patientDatesFreePSA, methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC);    

%Making a list of all the dates sorted
AllDates=[patientDatesPSA patientDatesMRI patientDatesBIOPT patientDatesECHO patientDatesFreePSA];
AllMethods=[methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA];
[AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods

maximumID=size(patientDatesPSA, 1); %find the maximal patient ID (how many patients we have in the dataset)

%Arrange the methods on the same order as the dates are sorted, so now you
%get all the methods sorted on date. 
for i=1:maximumID
    for j=1:size(AllMethods, 2)
        AllMethods2(i, j)=AllMethods(i, IndexDates(i, j));
    end
end

methodsperPSA=0;         %zeros(maximumID, 1); %this will become the methods used in the timeslot of the first PSA measurement

%find the methods used in the timeslot of the first PSA measurement
for i=1:maximumID
    if sum(patientDatesPSA(i, :))>0 %remove all patient without an PSA measurement
        firstPSA=find(AllMethods2(i, :)==1, 1, 'first'); %find the first PSA measurement
        minDates=AllDates(i, firstPSA)+minBoundary; %find minimal date in timeslot
        maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
        for j=1:size(AllMethods2, 2)
            if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=maxBoundary) && (AllDates(i, j)>minDates);
                methodsperPSA=methodsperPSA+1;
                %the date should be smaller than the maximum date and
                %bigger than the minimal date, 
                %also bigger than 0 and not be 90 (to avoid getting 0's in
                %the list
            end
        end
       
    end
%methodsperPSA1=methodsperPSA
end
% for i=1:maximumID
%     if sum(patientDatesPSA(i, :))>0 %remove all patient without an PSA measurement
%         firstPSA=find(AllMethods2(i, :)==1, 1, 'first'); %find the first PSA measurement
%         minDates=AllDates(i, firstPSA)-minBoundary; %find minimal date in timeslot
%         maxDates=AllDates(i, firstPSA)+maxBoundary; %find maximal date in timeslot
%         for j=1:size(AllMethods2, 2)
%             if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=90) && (AllDates(i, j)>minDates);
%                 methodsperPSA(i, j)=AllMethods2(i, j);
%                 %the date should be smaller than the maximum date and
%                 %bigger than the minimal date, 
%                 %also bigger than 0 and not be 90 (to avoid getting 0's in
%                 %the list
%             end
%         end
%        
%     end
% 
% end