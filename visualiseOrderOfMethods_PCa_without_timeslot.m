tic
close all
%visualiseOrderOfMethods_PCa_without_timeslot is a script that makes a bargraph of which methods are used in which order. 
%the order of methods can consists of 2, 3 or 4 methods in a row. 
%The order of methods are visualised for PSA<=4, 4<PSA<=10 and PSA>10
%Only the methods that are in a given timeframe, one day before till 119 days after the first PSA measurement, are used. 
%The PCa value should not necessary be given in the timeframe.
%%
%read out the given data

[PSA,MRI,BIOPT,ECHO,DBC, PCa]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%%
%make a list of dates, methods and values of the measurement for 
%(1)PSA=<4  (2)4<PSA<=10 and (3)PSA>10 and sort the list based on the date

[Dates1, Dates2, Dates3, Methods1, Methods2, Methods3, Values1, Values2, Values3, patientDatesPSA1, patientDatesPSA2, patientDatesPSA3]=sortDatesMethodValue(PSA,MRI,BIOPT,ECHO,PCa);

%%
%Sort the Values and Methods based on the dates given
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
scalar=3;

NrCombinations1=findOrderMethods(methodsperPSA1, scalar, PCa_code(:, 1));
NrCombinations2=findOrderMethods(methodsperPSA2, scalar, PCa_code(:, 2));
NrCombinations3=findOrderMethods(methodsperPSA3, scalar, PCa_code(:, 3));

figure(1) 
b=bar(NrCombinations1, 'stacked');
b(1).FaceColor = 'b';
b(2).FaceColor = 'g';
b(3).FaceColor = 'r';
legend(b, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic techniques used');
ylabel('Uses of the order of techniques');
title('Order of two diagnostic techniques with PSA<=4');

figure(2)
b2=bar(NrCombinations2, 'stacked');
b2(1).FaceColor = 'b';
b2(2).FaceColor = 'g';
b2(3).FaceColor = 'r';
legend(b2, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic techniques used');
ylabel('Uses of the order of techniques');
title('Order of two diagnostic techniques with 4<PSA<=10');

figure(3)
b3=bar(NrCombinations3, 'stacked');
b3(1).FaceColor = 'b';
b3(2).FaceColor = 'g';
b3(3).FaceColor = 'r';
legend(b3, 'no PCa code', 'no prostate cancer', 'prostate cancer')
xlabel('Order of diagnostic techniques used');
ylabel('Uses of the order of techniques');
title('Order of two diagnostic techniques with PSA>10');

toc