function [NrCombinations, DBCperOrder]=findOrderMethods(methodsperMRI, scalar, DBCcode)
%This function determines how many times a combination of different
%techniques is used. 
%It can be a combination of all possible four techniques and the DBC in an
%order of 2, 3 or 4
%scalar=2, only orders of two methods performed after each other
%scalar=3, only orders of three methods performed after each other
%scalar=4, only orders of four methods performed after each other
%Only orders that are in a specific timeslot and are performed after each
%other are noticed. So for [1 2 1] with scalar=2, order 1 2 and 2 1 are
%found, but not 1 1.

maximumID=size(methodsperMRI, 1);
switch scalar 
    case 1
        
    case 2 %gives orders of two methods combined
    combinations=getcombinations(scalar);            %[1, 2; 1, 3; 1, 4; 2, 1; 2, 2; 2, 3; 2, 4; 3, 1; 3, 2; 3, 4; 4, 1; 4, 2; 4, 3];
    NrCombinations=zeros(size(combinations, 1), 3);
    for i=1:maximumID
        methodsperMRI2=nonzeros(methodsperMRI(i, :))';
        for k=1:size(combinations, 1);
            for j=2:length(methodsperMRI2);
                if methodsperMRI2(j-1)==combinations(k, 1) && methodsperMRI2(j)==combinations(k, 2) ;
                    if DBCcode(i)==-1; %all the time frames with no DBC code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif DBCcode(i)==0; %with a DBC code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif DBCcode(i)==1; %with a DBC code of cancer
                        NrCombinations(k, 3)=NrCombinations(k, 3)+1;
                    end
                end
            end
        end
    end
       
    case 3
        
    combinations=getcombinations(scalar); 
    NrCombinations=zeros(size(combinations, 1), 3);
    for i=1:maximumID
        methodsperMRI2=nonzeros(methodsperMRI(i, :))';
        for k=1:size(combinations, 1);
            for j=2:(size(methodsperMRI2, 2)-1);
                if methodsperMRI2(j-1)==combinations(k, 1) && methodsperMRI2(j)==combinations(k, 2) && methodsperMRI2(j+1)==combinations(k, 3);
                    if DBCcode(i)==-1; %all the time frames with no DBC code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif DBCcode(i)==0; %with a DBC code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif DBCcode(i)==1; %with a DBC code of cancer
                        NrCombinations(k, 3)=NrCombinations(k, 3)+1;
                    end
                end
            end
        end
    end

    case 4

    combinations=getcombinations(scalar); 
    NrCombinations=zeros(size(combinations, 1), 3);
    for i=1:maximumID
        methodsperMRI2=nonzeros(methodsperMRI(i, :))';
        for k=1:size(combinations, 1);
            for j=2:(size(methodsperMRI2, 2)-2);
                 if methodsperMRI2(j-1)==combinations(k, 1) && methodsperMRI2(j)==combinations(k, 2) && methodsperMRI2(j+1)==combinations(k, 3) && methodsperMRI2(j+2)==combinations(k, 4);
                    if DBCcode(i)==-1; %all the time frames with no DBC code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif DBCcode(i)==0; %with a DBC code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif DBCcode(i)==1; %with a DBC code of cancer
                        NrCombinations(k, 3)=NrCombinations(k, 3)+1;
                    end
                 end
            end
    	end
     end

end
NrCombinations;
allcombinations=sum(NrCombinations); %give the total number of combinations of two methods used
figure;
bar(NrCombinations);
titleline=['how many times a combination of ', num2str(scalar), ' methods is used'];
title(titleline);
end


