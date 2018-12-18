%[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%visualise order of methods
[AllValuesperPSA1, methodsperPSA1]=findDataPerPSA(PSA,MRI,BIOPT,ECHO,DBC, 0, 120);
%[AllValuesperPSA2, methodsperPSA2]=findDataPerPSA(PSA,MRI,BIOPT,ECHO,DBC, 0, 140);
%scalar=2; % defines the length of the combinations you want to examine. 
%scalar=2; %only orders of two methods performed after each other
%scalar=3; %only orders of three methods performed after each other
scalar=3; %only orders of four methods performed after each other

NrCombinations1=findOrderMethods(methodsperPSA1, scalar)
%NrCombinations2=findOrderMethods(methodsperPSA2, scalar)
% 
% difference12=NrCombinations1-NrCombinations2;
% 
% bar(difference12)
