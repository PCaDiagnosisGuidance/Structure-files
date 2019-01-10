%visualiseOrderOfMethods_PCa_old_version
tic
close all
%[PSA,MRI,BIOPT,ECHO,DBC, PCa]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');
% 
%get per patient the dates sorted. Also the methods and values are sorted
%depending on the dates
[AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
    AllValuesperPSA3, methodsperPSA3, PCa_code]=findDataPerPCa_old_version(PSA,MRI,BIOPT,ECHO,PCa, -1, 119);

% %visualise order of methods
%%

scalar=3; % defines the length of the combinations you want to examine. 

NrCombinations1=findOrderMethods(methodsperPSA1, scalar, PCa_code(:, 1));
NrCombinations2=findOrderMethods(methodsperPSA2, scalar, PCa_code(:, 2));
NrCombinations3=findOrderMethods(methodsperPSA3, scalar, PCa_code(:, 3));

figure(1) 
b=bar(NrCombinations1, 'stacked');
b(1).FaceColor = 'b';
b(2).FaceColor = 'g';
b(3).FaceColor = 'r';
legend(b, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic technique');
ylabel('Occurrences of the order');
title('Order of two diagnostic techniques with PSA<=4');

figure(2)
b2=bar(NrCombinations2, 'stacked');
b2(1).FaceColor = 'b';
b2(2).FaceColor = 'g';
b2(3).FaceColor = 'r';
legend(b2, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic technique');
ylabel('Occurrences of the order');
title('Order of two diagnostic techniques with 4<PSA<=10');

figure(3)
b3=bar(NrCombinations3, 'stacked');
b3(1).FaceColor = 'b';
b3(2).FaceColor = 'g';
b3(3).FaceColor = 'r';
legend(b3, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic technique');
ylabel('Occurrences of the order');
title('Order of two diagnostic techniques with PSA>10');

toc