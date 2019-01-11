%visualiseOrderOfMethods_PCa_old_version

%visualiseOrderOfMethods_PCa_old_version is a script that makes a bargraph of how many times a order of diagnostic techniques is used. 
%the order of methods can consists of 2, 3 (or 4) methods in a row. 
%The order of methods are visualised for PSA<4, 4=<PSA<10 and PSA>=10
%Only the methods that are in a given timeframe [-1, 119] are used

tic
close all
%%
%read out the given data
[PSA,MRI,BIOPT,ECHO,DBC,PCa]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%%
%make a list of dates, methods and values of the measurement for (1)PSA<4  (2)4<=PSA<10 and (3)PSA>=10 and sort the list based on the date
%Sort the Values and Methods based on the dates given
%In the given time frame [minboundary, maxboundary] find all the methods used in this time and all the values of these measurement within the PSA groups (PSA>=4, 4<PSA<=10 and PSA>10).
%The timeframe is based on the first PSA measurement, so the time frame [-1, 119] 
%is the day of the PSA measurement till 119 days after the first PSA measurement. -1<day<=119
%The PCA_code is calculated per patient per PSA group.

[AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
    AllValuesperPSA3, methodsperPSA3, PCa_code]=findDataPerPCa_old_version(PSA,MRI,BIOPT,ECHO,PCa, -1, 119);
%for methods: 1:PSA, 2:MRI, 3:Biopt, 4:Echo, 5:Free PSA, 6:PCa value

%%
%calculate the number of times an order of methods is used and visualise
%this in a bar graph. Add PCa values to the bar graph, to visualise how
%many people with which order have PCa/no PCa/no PCa present. 

scalar=3; 
% defines the length of the combinations you want to examine. Can be 2 or 3 (4 is implemented, but not used in our research)
%So if you choose three, any order of three techniques used is found, for example PSA -> MRI -> BIOPT.

NrCombinations1=findOrderMethods(methodsperPSA1, scalar, PCa_code(:, 1));
NrCombinations2=findOrderMethods(methodsperPSA2, scalar, PCa_code(:, 2));
NrCombinations3=findOrderMethods(methodsperPSA3, scalar, PCa_code(:, 3));

figure(1) 
b=bar(NrCombinations1, 'stacked');
b(1).FaceColor = 'b'; %no PCa code given
b(2).FaceColor = 'g'; %no prostate cancer
b(3).FaceColor = 'r'; %prostate cancer
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