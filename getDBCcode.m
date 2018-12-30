function DBC_code=getDBCcode(AllValuesperPSA_number, methodsperPSA_number)
%gives the DBC code per patient
    DBC_code=-1*ones(size(methodsperPSA_number, 1), 1);
    for i=1:size(methodsperPSA_number, 1);
        index=find(methodsperPSA_number(i, :)==6);
        if length(index)>0;
            DBC_code(i)=AllValuesperPSA_number(i, index);
        end
    end
end
    