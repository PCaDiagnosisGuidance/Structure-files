function [ValuesperPSA1, MethodsperPSA1,ValuesperPSA2, MethodsperPSA2, ...
    ValuesperPSA3, MethodsperPSA3, PCa_code]=findDataPerPSA_PCa(Dates1, Dates2, Dates3, Methods1, Methods2, Methods3, Values1, Values2, Values3, patientDatesPSA1, patientDatesPSA2, patientDatesPSA3, minBoundary, maxBoundary)
%find the methods and values of the measurements in given timeframe for for PSA<=4, 4<PSA<=10 and PSA>10

%steps done in the script:
%1)Find the first PSA examination
%2)find the maximal and minimal time of the timeslot
%3)find all the examinations done in this timeslot and the values
%4)find the first PCa given for this patient

%read the dataset
close all

%find the Dates per patient per method and how many times it is detected. 
%Also find out which method is used at which time

maximumID=size(Dates1, 1); %find the maximal patient ID (how many patients we have in the dataset)

%PSA<=4 group
   
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
        MethodsperPSA1=zeros(maximumID, size(Methods1, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        ValuesperPSA1=zeros(maximumID, size(Values1, 2));
        PCa_code1=-1*ones(maximumID, 1);

        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA1(i, :))>0 %remove all patient without a PSA measurement
                firstPSA1=find(Methods1(i, :)==1, 1, 'first'); %find the first PSA measurement
                firstPCa1=find(Methods1(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa1)==1;
                    PCa_code1(i)=Values1(i, firstPCa1); %first the first PCa value of this patient
                end
                minDates1=Dates1(i, firstPSA1)-minBoundary; %find minimal date in timeslot
                maxDates1=Dates1(i, firstPSA1)+maxBoundary; %find maximal date in timeslot
                for j=1:size(Methods1, 2)
                    if (Dates1(i, j)<=maxDates1) && (Dates1(i, j)>0) && (Dates1(i, j)~=90) && (Dates1(i, j)>minDates1);
                        MethodsperPSA1(i, j)=Methods1(i, j);
                        ValuesperPSA1(i, j)=Values1(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
   
    
%4<PSA<=10
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
        MethodsperPSA2=zeros(maximumID, size(Methods2, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        ValuesperPSA2=zeros(maximumID, size(Values2, 2));
        PCa_code2=-1*ones(maximumID, 1);
        
        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA2(i, :))>0 %remove all patient without a PSA measurement
                firstPSA2=find(Methods2(i, :)==1, 1, 'first'); %find the first PSA measurement
                firstPCa2=find(Methods2(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa2)==1;
                    PCa_code2(i)=Values2(i, firstPCa2); %first the first PCa value of this patient
                end
                minDates2=Dates2(i, firstPSA2)-minBoundary; %find minimal date in timeslot
                maxDates2=Dates2(i, firstPSA2)+maxBoundary; %find maximal date in timeslot
                for j=1:size(Methods2, 2)
                    if (Dates2(i, j)<=maxDates2) && (Dates2(i, j)>0) && (Dates2(i, j)~=90) && (Dates2(i, j)>minDates2);
                        MethodsperPSA2(i, j)=Methods2(i, j);
                        ValuesperPSA2(i, j)=Values2(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
    
    
    %Arrange the methods on the same order as the dates are sorted, so now you
    %get all the methods sorted on date. 
        MethodsperPSA3=zeros(maximumID, size(Methods3, 2)); %this will become the methods used in the timeslot of the first PSA measurement
        ValuesperPSA3=zeros(maximumID, size(Values3, 2));
        PCa_code3=-1*ones(maximumID, 1);
        %find the methods used in the timeslot of the first PSA measurement
        for i=1:maximumID
            if sum(patientDatesPSA3(i, :))>0 %remove all patient without a PSA measurement
                firstPSA3=find(Methods3(i, :)==1, 1, 'first'); %find the first PSA measurement
                firstPCa3=find(Methods3(i, :)==6, 1, 'first'); %finds the first DBC code
                if length(firstPCa3)==1;
                    PCa_code3(i)=Values3(i, firstPCa3); %first the first PCa value of this patient
                end
                minDates3=Dates3(i, firstPSA3)-minBoundary; %find minimal date in timeslot
                maxDates3=Dates3(i, firstPSA3)+maxBoundary; %find maximal date in timeslot
                for j=1:size(Methods3, 2)
                    if (Dates3(i, j)<=maxDates3) && (Dates3(i, j)>0) && (Dates3(i, j)~=90) && (Dates3(i, j)>minDates3);
                        MethodsperPSA3(i, j)=Values3(i, j);
                        ValuesperPSA3(i, j)=Values3(i, j);
                        %the date should be smaller than the maximum date and
                        %bigger than the minimal date, 
                        %also bigger than 0 and not be 90 (to avoid getting 0's in
                        %the list
                    end
                end

            end

        end
     

PCa_code=[PCa_code1, PCa_code2, PCa_code3]; %make a [maximumID, 3] matrix for the PCa value

end