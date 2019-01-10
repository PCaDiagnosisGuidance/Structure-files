function [NrCombinations]=findOrderMethods(methodsperPSA, scalar, PCa_code)
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

maximumID=size(methodsperPSA, 1);
switch scalar 
        
    case 2 %gives orders of two methods combined
    combinations=getcombinations(scalar);   
    NrCombinations=zeros(size(combinations, 1), 3);
    for i=1:maximumID
        methodsperPSA2=methodsperPSA(i, :);
        for k=1:size(combinations, 1);
            for j=2:length(methodsperPSA2);
                if methodsperPSA2(j-1)==combinations(k, 1) && methodsperPSA2(j)==combinations(k, 2) ;
                    if PCa_code(i)==-1; %all the time frames with no PCa code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif PCa_code(i)==0; %with a PCa code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif PCa_code(i)==1; %with a PCa code of cancer
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
        methodsperPSA2=nonzeros(methodsperPSA(i, :))';
        for k=1:size(combinations, 1);
            for j=2:(size(methodsperPSA2, 2)-1);
                if methodsperPSA2(j-1)==combinations(k, 1) && methodsperPSA2(j)==combinations(k, 2) && methodsperPSA2(j+1)==combinations(k, 3);
                    if PCa_code(i)==-1; %all the time frames with no PCa code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif PCa_code(i)==0; %with a PCa code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif PCa_code(i)==1; %with a PCa code of cancer
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
        methodsperPSA2=nonzeros(methodsperPSA(i, :))';
        for k=1:size(combinations, 1);
            for j=2:(size(methodsperPSA2, 2)-2);
                 if methodsperPSA2(j-1)==combinations(k, 1) && methodsperPSA2(j)==combinations(k, 2) && methodsperPSA2(j+1)==combinations(k, 3) && methodsperPSA2(j+2)==combinations(k, 4);
                    if PCa_code(i)==-1; %all the time frames with no PCa code
                        NrCombinations(k, 1)=NrCombinations(k, 1)+1;
                    elseif PCa_code(i)==0; %with a PCa code of no cancer
                        NrCombinations(k, 2)=NrCombinations(k, 2)+1;
                    elseif PCa_code(i)==1; %with a PCa code of cancer
                        NrCombinations(k, 3)=NrCombinations(k, 3)+1;
                    end
                 end
            end
    	end
     end

end
NrCombinations;
allcombinations=sum(NrCombinations); %give the total number of combinations of two methods used
end


