%find the optimal value for the timeslot

%read the data
[PSA,MRI,BIOPT,ECHO,DBC]=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

%get the lists of methods per patient and dates of the techniques per
%patient
[patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, patientDatesFreePSA, methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA]=getPatientDatesV3(PSA,MRI,BIOPT,ECHO,DBC);    

%get the boundaries
minboundary=[0, 3];
maxboundary=[120, 120];


methodsperPSA1=zeros(length(minboundary), 1);

for i=1:length(minboundary)
     methodsperPSA=0;
     methodsperPSA=findDataPerPSA_optimal(patientDatesPSA, patientDatesMRI, patientDatesBIOPT, patientDatesECHO, patientDatesFreePSA, methodsPSA,  methodsMRI,  methodsBIOPT,  methodsECHO, methodsFreePSA, minboundary(i), maxboundary(i), methodsperPSA);
     methodsperPSA1(i)=methodsperPSA
end

figure;
plot(minboundary, methodsperPSA1)
xlabel('minboundary')
ylabel('number of techniques in this timeslot')

