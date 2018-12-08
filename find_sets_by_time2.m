%find timeslots based MRI data. 
%Order of steps taken in the script
%1)Read out of data
%2)Gets all PSA, MRI, BIOPT and ECHO data per patient and a list of which
%method is used
%3)Gives one big list of dates and methods used per patient
%4)Sort the methods used based on the dates
%5)Find the first MRi examination used
%6)find the maximal and minimal time of the timeslot
%7)find all the examinations done in this timeslot

%read the dataset
close all
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%find the Dates per patient per method and how many times it is detected. 
%Also find out which method is used at which time
[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO...
 ,methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC);    

%Making a list of all the dates sorted
AllDates=[patientDatesPSA patientDatesMRI patientDatesBIOPT patientDatesECHO];
AllMethods=[methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO];
[AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods

maximumID=max(PSA.ID); %find the maximal patient ID (how many patients we have in the dataset)

%Arrange the methods on the same order as the dates are sorted, so now you
%get all the methods sorted on date. 
for i=1:maximumID
    for j=1:size(AllMethods, 2)
        AllMethods2(i, j)=AllMethods(i, IndexDates(i, j));
    end
end

methodsperMRI=zeros(maximumID, size(AllMethods2, 2)); %this will become the methods used in the timeslot of the first MRI measurement

%find the methods used in the timeslot of the first MRI measurement
for i=1:maximumID
    if sum(patientDatesMRI(i, :))>0 %remove all patient without an MRI measurement
        firstMRI=find(AllMethods2(i, :)==2, 1, 'first'); %find the first MRI measurement
        minDates=AllDates(i, firstMRI)-30; %find minimal date in timeslot
        maxDates=AllDates(i, firstMRI)+90; %find maximal date in timeslot
        for j=1:size(AllMethods2, 2)
            if (AllDates(i, j)<=maxDates) && (AllDates(i, j)>0) && (AllDates(i, j)~=90) && (AllDates(i, j)>minDates);
                %the date should be smaller than the maximum date and
                %bigger than the minimal date, 
                %also bigger than 0 and not be 90 (to avoid getting 0's in
                %the list
            end
        end
       
    end

end



% 
% DOEST WORK YET
% combinations=[1, 2; 1, 3; 1, 4; 2, 1; 2, 2; 2, 3; 2, 4; 3, 1; 3, 2; 3, 4; 4, 1; 4, 2; 4, 3];
%     NrCombinations=zeros(size(combinations, 1), 1);
%     for i=1:maximumID
%         methodsperMRI2=nonzeros(methodsperMRI(i, :))';
%         for k=1:size(combinations, 1);
%             for j=2:length(methodsperMRI2);
%                 if methodsperMRI(j-1)==combinations(k, 1) && methodsperMRI(j)==combinations(k, 2) ;
%                     NrCombinations(k)=NrCombinations(k)+1
%                 end
%             end
%         end
%     end
%     
% allcombinations=sum(NrCombinations); %give the total number of combinations of two methods used
% figure;
% bar(NrCombinations);
% title('%how many times a combination of two methods is used');


%  combinations=[2 4 3; 2 3 4; 2 1 4; 2 4 1; 2 1 3; 2 3 1; 4 2 3; 3 2 4; 1 2 4; 4 2 1; 3 2 1; 1 2 3; 1 3 2; 1 4 2; 3 1 2; 4 1 2];
%  NrCombinations=zeros(size(combinations, 1), 1);
% for i=1:maximumID
%      AllMethods3=nonzeros(AllMethods2(i, :))';
%      for k=1:size(combinations, 1);
%          for j=2:(size(AllMethods3, 2)-1);
%              if AllMethods3(j-1)==combinations(k, 1) && AllMethods3(j)==combinations(k, 2) && AllMethods3(j+1)==combinations(k, 3);
%                  NrCombinations(k)=NrCombinations(k)+1;
%              end
%          end
%      end
% end
%     
% allcombinations=sum(NrCombinations); %give the total number of combinations of two methods used
% figure;
% bar(NrCombinations);
% title('%how many times a combination of two methods is used');

% 
% %de volgorde is: (1:'PSA-ECHO-BIOPT', 2:'PSA-MRI-BIOPT', 3:'PSA-BIOPT-ECHO',
% %4:'MRI-BIOPT-ECHO', 5:'BIOPT-ECHO-PSA', 6:'BIOPT-ECHO-MRI', 7:'ECHO-BIOPT-MRI')
% %dit heb ik niet geplot want dat paste niet goed in het figuur. 
%    

