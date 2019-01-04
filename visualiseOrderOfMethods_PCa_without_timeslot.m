tic
close all
%%
%read out the given data

[PSA,MRI,BIOPT,ECHO,DBC, PCa]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%%
%make a list of sorted dates, methods and values of the measurement for 
%(1)PSA=<4  (2)4<PSA<=10 and (3)PSA>10

[Dates1, Dates2, Dates3, Methods1, Methods2, Methods3, Values1, Values2, Values3, patientDatesPSA1, patientDatesPSA2, patientDatesPSA3]=getPatientDates_PCa(PSA,MRI,BIOPT,ECHO,PCa);

%%
%In the given time frame [minboundary, maxboundary] find all the methods 
%used in this time and all the values of these measurement within the PSA groups (PSA>=4, 4<PSA<=10 and PSA>10).

%The timeframe is based on the first PSA measurement, so the time frame [-1, 119] 
%is one day before till 119 days after the first PSA measurement

[ValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
 ValuesperPSA3, methodsperPSA3, PCa_code]=findDataPerPSA_PCa(Dates1, Dates2, Dates3, Methods1, Methods2, Methods3, Values1, Values2, Values3, patientDatesPSA1, patientDatesPSA2, patientDatesPSA3, -1, 119);

%%
close all
%Define how many techniques used after each other you want to examine.
%So if you choose three, any order of three techniques used is found, for
%example PSA -> MRI -> BIOPT
%Scalar=2/3/4 is possible
scalar=2;

NrCombinations1=findOrderMethods(methodsperPSA1, scalar, PCa_code(:, 1));
NrCombinations2=findOrderMethods(methodsperPSA2, scalar, PCa_code(:, 2));
NrCombinations3=findOrderMethods(methodsperPSA3, scalar, PCa_code(:, 3));

figure(1) 
b=bar(NrCombinations1, 'stacked');
b(1).FaceColor = 'b';
b(2).FaceColor = 'g';
b(3).FaceColor = 'r';
legend(b, 'no DBC code', 'no prostate cancer', 'prostate cancer')

figure(2)
b2=bar(NrCombinations2, 'stacked');
b2(1).FaceColor = 'b';
b2(2).FaceColor = 'g';
b2(3).FaceColor = 'r';
legend(b2, 'no DBC code', 'no prostate cancer', 'prostate cancer')

figure(3)
b3=bar(NrCombinations3, 'stacked');
b3(1).FaceColor = 'b';
b3(2).FaceColor = 'g';
b3(3).FaceColor = 'r';
legend(b3, 'no DBC code', 'no prostate cancer', 'prostate cancer')

toc