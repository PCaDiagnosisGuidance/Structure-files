%read the dataset
close all
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%find the Dates per patient per method and how many times it is detected. 
%Also find out which method is used
[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, NrOfDetectionsPSA, NrOfDetectionsMRI, NrOfDetectionsBIOPT, NrOfDetectionsECHO...
 ,methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO]=getPatientDates(PSA,MRI,BIOPT,ECHO,DBC);    

%make a list of all the dates a medical examination is done per patient
AllDates=[patientDatesPSA patientDatesMRI patientDatesBIOPT patientDatesECHO];
AllMethods=[methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO];
[AllDates, IndexDates]=sort(AllDates, 2); %get the index the dates are sorted towards to use this for the sorting of the methods


maximumID=max(PSA.ID); %find the maximal patient ID (how many patients we have in the dataset)
Examinations=zeros(maximumID, 100);

%Arrange the methods on the same order as the dates are sorted, so now you
%get all the methods sorted on date. 
for i=1:maximumID
    for j=1:size(AllMethods, 2)
        AllMethods2(i, j)=AllMethods(i, IndexDates(i, j))
    end
end

%choose how long the combination of methods is you want to find:
lenghtOfCombinations=2;  %1: order of only one method
                         %2: order of two methods
                         %3: order of three methods
                         %(4: order of four methods)

                         
switch lenghtOfCombinations

    case 1 %how many times one method is used
    combinations=[1; 2; 3; 4];
    NrCombinations=zeros(size(combinations, 1), 1);
    for i=1:maximumID
        AllMethods3=nonzeros(AllMethods2(i, :))';
        for k=1:size(combinations, 1);
            for j=1:(size(AllMethods3, 2));
                if AllMethods3(j)==combinations(k, 1);
                    NrCombinations(k)=NrCombinations(k)+1;
                end
            end
        end
    end
    allcombinations=sum(NrCombinations) %give the total number of combinations of two methods used
    figure;
    bar(NrCombinations)
    title('How many times one method is used');
    %volgorde: 1:'PSA', 2:'MRI', 3:'BIOPT', 4:'ECHO'
    
    
    case 2 %how many times a combination of two methods is used
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
  
    allcombinations=sum(NrCombinations) %give the total number of combinations of two methods used
    figure;
    bar(NrCombinations)
    title('%how many times a combination of two methods is used');
    %de volgorde is: (1:'PSA-MRI', 2:'PSA-BIOPT', 3:'PSA-ECHO', 4:'MRI-PSA', 5:'MRI-BIOPT', 6:'MRI-ECHO', 7:'BIOPT-PSA', 8:'BIOPT-MRI', 9:'BIOPT-ECHO', 10:'ECHO-PSA', 11:'ECHO-MRI', 12:'ECHO-BIOPT')
    %dit heb ik niet geplot want dat paste niet goed in het figuur. 
   
    case 3 %how many times a combination of three methods is used
    combinations=[1 4 3; 1 2 3; 1 3 4; 2 3 4; 3 4 1; 3 4 2; 4 3 2];
    %combinations=[1];
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
   
    

%     case 4 %how many times a combination of four methods is used. 
%     v=1:4;
%     combinations=perms(v); %give all the possible combinations of techniques
%     NrCombinations=zeros(size(combinations, 1), 1);
%     for i=1:maximumID
%         AllMethods3=nonzeros(AllMethods2(i, :))';
%         for k=1:size(combinations, 1);
%             for j=2:(size(AllMethods3, 2)-2);
%                 if AllMethods3(j-1)==combinations(k, 1) && AllMethods3(j)==combinations(k, 2) && AllMethods3(j+1)==combinations(k, 3) && AllMethods3(j+2)==combinations(k, 4);
%                     NrCombinations(k)=NrCombinations(k)+1;
%                 end
%             end
%         end
%     end
end
 
%%
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
