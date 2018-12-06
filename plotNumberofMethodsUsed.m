function plotNumberofMethodsUsed(TotalDetectionsPSA, TotalDetectionsMRI, TotalDetectionsBIOPT, TotalDetectionsECHO)
figure,
subplot(2,2,1)
    bar(TotalDetectionsPSA)
    xlabel('Number of PSA measurements')
    ylabel('number of patients')
    
subplot(2, 2, 2)
    bar(TotalDetectionsMRI)
    xlabel('Number of MRI measurements')
    ylabel('number of patients')
    
subplot(2, 2, 3)
    bar(TotalDetectionsBIOPT)
    xlabel('Number of BIOPT measurements')
    ylabel('number of patients')

subplot(2, 2, 4)
    bar(TotalDetectionsECHO)
    xlabel('Number of ECHO measurements')
    ylabel('number of patients')




    