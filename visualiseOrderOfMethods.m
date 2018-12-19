tic
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s165635\Documents\MATLAB\OGO Computational Biology\OGO groep 5');

%visualise order of methods
[AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
 AllValuesperPSA3, methodsperPSA3]=findDataPerPSAV2_R(PSA,MRI,BIOPT,ECHO,DBC, 0, 120);

%[AllValuesperPSA2, methodsperPSA2]=findDataPerPSA(PSA,MRI,BIOPT,ECHO,DBC, 0, 140);
%scalar=2; % defines the length of the combinations you want to examine. 
scalar=2; %only orders of two methods performed after each other
%scalar=3; %only orders of three methods performed after each other
%scalar=4; %only orders of four methods performed after each other

NrCombinations1=findOrderMethods(methodsperPSA1, scalar);
NrCombinations2=findOrderMethods(methodsperPSA2, scalar);
NrCombinations3=findOrderMethods(methodsperPSA3, scalar);

figure(1) 
bar(NrCombinations1);

figure(2)
bar(NrCombinations2);

figure(3)
bar(NrCombinations3);
toc


