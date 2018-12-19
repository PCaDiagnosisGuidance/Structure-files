function combinations=getcombinations(scalar)
%script all possible combinations of methods
switch scalar
    case 2 %for an order of two methods
        combinations=[];
        for i=1:5
            for j=1:5
                combinations=[combinations; i, j];
            end
        end
        
    case 3 %for an order of three methods
        combinations=[];
        for i=1:5
            for j=1:5
                for k=1:5   
                     combinations=[combinations; i, j, k];
                end
            end
        end
    
    case 4 %for an order of four methods
        combinations=[];
        for i=1:5
            for j=1:5
                for k=1:5
                     for l=1:5
                            combinations=[combinations; i, j, k, l];
                     end
                end
            end
        end
        
end
end

              