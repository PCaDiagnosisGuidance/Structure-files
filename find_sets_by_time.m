%get sets of data that belong together
%find a minimal and maximal date which can be found in a timeslot

%read the dataset
close all
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%find the Dates per patient per method and how many times it is detected. 
%Also find out which method is used
[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO...
 ,methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC);    


%ik ga nu proberen om de data in tijdsloten te delen aan de hand van MRI
%data
maxDatesMRI=nonzeros(patientDatesMRI)+90;
minDatesMRI=nonzeros(patientDatesMRI)-30;

%make a list of all the dates a medical examination is done per patient
AllDates=[patientDatesPSA patientDatesMRI patientDatesBIOPT patientDatesECHO];
AllMethods=[methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO];
[AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods

%make a list of all the dates a medical examination is done per patient
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

methodsperMRI=zeros(maximumID, 100);

for i=1:maximumID
    if sum(patientDatesMRI(i, :))>0;
        for j=1:size(AllMethods2, 2)
            if AllDates(i, j)<maxDatesMRI(i, 1) && AllDates(i, j)>0 && AllDates(i, j)>minDatesMRI(i, 1);
                methodsperMRI(i, j)=AllMethods2(i, j);
            end
        end
    end

end

combinations=[1, 2; 1, 3; 1, 4; 2, 1; 2, 3; 2, 4; 3, 1; 3, 2; 3, 4; 4, 1; 4, 2; 4, 3];
    %combinations=[1];
    NrCombinations=zeros(size(combinations, 1), 1);
    for i=1:maximumID
        AllMethods3=nonzeros(AllMethods2(i, :))';
        for k=1:size(combinations, 1);
            for j=2:(size(AllMethods3, 2));
                if AllMethods3(j-1)==combinations(k, 1) && AllMethods3(j)==combinations(k, 2) ;%&& AllMethods3(j+1)==combinations(k, 3) && AllMethods3(j+2)==combinations(k, 3);
                    NrCombinations(k)=NrCombinations(k)+1;
                end
            end
        end
    end
  
 combinations=[2 4 3; 2 3 4; 2 1 4; 2 4 1; 2 1 3; 2 3 1; 4 2 3; 3 2 4; 1 2 4; 4 2 1; 3 2 1; 1 2 3; 1 3 2; 1 4 2; 3 1 2; 4 1 2]
 NrCombinations=zeros(size(combinations, 1), 1);
for i=1:maximumID
     AllMethods3=nonzeros(AllMethods2(i, :))';
     for k=1:size(combinations, 1);
         for j=2:(size(AllMethods3, 2)-1);
             if AllMethods3(j-1)==combinations(k, 1) && AllMethods3(j)==combinations(k, 2) && AllMethods3(j+1)==combinations(k, 3);
                 NrCombinations(k)=NrCombinations(k)+1;
             end
         end
     end
end
    
allcombinations=sum(NrCombinations) %give the total number of combinations of two methods used
figure;
bar(NrCombinations);
title('%how many times a combination of three methods is used');


%de volgorde is: (1:'PSA-ECHO-BIOPT', 2:'PSA-MRI-BIOPT', 3:'PSA-BIOPT-ECHO',
%4:'MRI-BIOPT-ECHO', 5:'BIOPT-ECHO-PSA', 6:'BIOPT-ECHO-MRI', 7:'ECHO-BIOPT-MRI')
%dit heb ik niet geplot want dat paste niet goed in het figuur. 
   

