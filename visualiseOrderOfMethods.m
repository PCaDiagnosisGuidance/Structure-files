tic
close all
%[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%visualise order of methods
% [AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
%  AllValuesperPSA3, methodsperPSA3]=findDataPerPSAV2_Saray(PSA,MRI,BIOPT,ECHO,DBC, -1, 119);

DBC_code1=getDBCcode(AllValuesperPSA1, methodsperPSA1);
DBC_code2=getDBCcode(AllValuesperPSA2, methodsperPSA2);
DBC_code3=getDBCcode(AllValuesperPSA3, methodsperPSA3);

%[AllValuesperPSA2, methodsperPSA2]=findDataPerPSA(PSA,MRI,BIOPT,ECHO,DBC, 0, 140);
scalar=4; % defines the length of the combinations you want to examine. 
% scalar=2; %only orders of two methods performed after each other
% %scalar=3; %only orders of three methods performed after each other
% %scalar=4; %only orders of four methods performed after each other
% 
NrCombinations1=findOrderMethods(methodsperPSA1, scalar, DBC_code1);
NrCombinations2=findOrderMethods(methodsperPSA2, scalar, DBC_code2);
NrCombinations3=findOrderMethods(methodsperPSA3, scalar, DBC_code3);

figure(1) 
b=bar(NrCombinations1, 'stacked');
legend(b, 'no DBC code', 'no prostate cancer', 'prostate cancer')

figure(2)
b2=bar(NrCombinations2, 'stacked');
legend(b2, 'no DBC code', 'no prostate cancer', 'prostate cancer')

figure(3)
b3=bar(NrCombinations3, 'stacked');
legend(b3, 'no DBC code', 'no prostate cancer', 'prostate cancer')
toc


