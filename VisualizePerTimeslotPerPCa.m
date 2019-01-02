% To run this script first PSA, MRI, BIOPT, ECHO and DBC have to be known.
% This has to be done by running DataReadOut as a function. 

[AllValuesperPSA1, methodsperPSA1,AllValuesperPSA2, methodsperPSA2, ...
    AllValuesperPSA3, methodsperPSA3]=findDataPerPCa_R(PSA,MRI,BIOPT,ECHO,DBC, -1, 119);
% By exchanging findDataPerPCa_R for findDataPerPSAgroups_R you can plot
% the figures for the three PSA groups instead of the three PCa groups.

psa_value1=zeros(13939, 1);
mri_value1=zeros(13939,1);
biopt_value1=zeros(13939,1);
echo_value1=zeros(13939,1);
freepsa_value1=zeros(13939,1);
dbc_value1=zeros(13939,1); 

% Extract all the right values for the parameters in the given timeslot. Do
% this per group (1, 2 and 3). Where 1 corresponds to either PCa = 1 or 
% PSA<=4; 2 corresponds to PCa = 0 or 4<PSA<=10 and 3 corresponds to 
% PCa = -1 or PSA > 10.

for i=1:13939
    psa_index=find(methodsperPSA1(i, :)==1, 1, 'first');
    if isempty(psa_index)==0
        psa_value1(i, 1:length(psa_index))=AllValuesperPSA1(i, psa_index);
    end
        
    mri_index=find(methodsperPSA1(i, :)==2, 1, 'first');
    if isempty(mri_index)==0
        mri_value1(i, 1:length(mri_index))=AllValuesperPSA1(i, mri_index);
    else
        mri_value1(i, 1)=0;
    end

    biopt_index=find(methodsperPSA1(i, :)==3, 1, 'first');
    if isempty(biopt_index)==0
        biopt_value1(i, 1:length(biopt_index))=AllValuesperPSA1(i, biopt_index);
    else
        biopt_value1(i, 1)=0;
    end
    
    echo_index=find(methodsperPSA1(i, :)==4, 1, 'first');
    if isempty(echo_index)==0
        echo_value1(i, 1:length(echo_index))=AllValuesperPSA1(i, echo_index);
    else
        echo_value1(i, 1)=0;
    end
    
    freepsa_index=find(methodsperPSA1(i, :)==5, 1, 'first');
    if isempty(freepsa_index)==0
        freepsa_value1(i, 1:length(freepsa_index))=AllValuesperPSA1(i, freepsa_index);
    else
        freepsa_value1(i, 1)=0;
    end
    
    dbc_index=find(methodsperPSA1(i, :)==6, 1, 'first');
    if isempty(dbc_index)==0
        dbc_value1(i, 1:length(dbc_index))=AllValuesperPSA1(i, dbc_index);
    else
        dbc_value1(i, 1)=0;
    end
end

psa_value2=zeros(13939, 1);
mri_value2=zeros(13939,1);
biopt_value2=zeros(13939,1);
echo_value2=zeros(13939,1);
freepsa_value2=zeros(13939,1);
dbc_value2=zeros(13939,1);

for i=1:13939
    psa_index=find(methodsperPSA2(i, :)==1, 1, 'first');
    if isempty(psa_index)==0
        psa_value2(i, 1:length(psa_index))=AllValuesperPSA2(i, psa_index);
    end
        
    mri_index=find(methodsperPSA2(i, :)==2, 1, 'first');
    if isempty(mri_index)==0
        mri_value2(i, 1:length(mri_index))=AllValuesperPSA2(i, mri_index);
    else
        mri_value2(i, 1)=0;
    end

    biopt_index=find(methodsperPSA2(i, :)==3, 1, 'first');
    if isempty(biopt_index)==0
        biopt_value2(i, 1:length(biopt_index))=AllValuesperPSA2(i, biopt_index);
    else
        biopt_value2(i, 1)=0;
    end
    
    echo_index=find(methodsperPSA2(i, :)==4, 1, 'first');
    if isempty(echo_index)==0
        echo_value2(i, 1:length(echo_index))=AllValuesperPSA2(i, echo_index);
    else
        echo_value2(i, 1)=0;
    end
    
    freepsa_index=find(methodsperPSA2(i, :)==5, 1, 'first');
    if isempty(freepsa_index)==0
        freepsa_value2(i, 1:length(freepsa_index))=AllValuesperPSA2(i, freepsa_index);
    else
        freepsa_value2(i, 1)=0;
    end
    
    dbc_index=find(methodsperPSA2(i, :)==6, 1, 'first');
    if isempty(dbc_index)==0
        dbc_value2(i, 1:length(dbc_index))=AllValuesperPSA2(i, dbc_index);
    else
        dbc_value2(i, 1)=0;
    end
end

psa_value3=zeros(13939, 1);
mri_value3=zeros(13939,1);
biopt_value3=zeros(13939,1);
echo_value3=zeros(13939,1);
freepsa_value3=zeros(13939,1);
dbc_value3=zeros(13939,1);

for i=1:13939
    psa_index=find(methodsperPSA3(i, :)==1, 1, 'first');
    if isempty(psa_index)==0
        psa_value3(i, 1:length(psa_index))=AllValuesperPSA3(i, psa_index);
    end
        
    mri_index=find(methodsperPSA3(i, :)==2, 1, 'first');
    if isempty(mri_index)==0
        mri_value3(i, 1:length(mri_index))=AllValuesperPSA3(i, mri_index);
    else
        mri_value3(i, 1)=0;
    end

    biopt_index=find(methodsperPSA3(i, :)==3, 1, 'first');
    if isempty(biopt_index)==0
        biopt_value3(i, 1:length(biopt_index))=AllValuesperPSA3(i, biopt_index);
    else
        biopt_value3(i, 1)=0;
    end
    
    echo_index=find(methodsperPSA3(i, :)==4, 1, 'first');
    if isempty(echo_index)==0
        echo_value3(i, 1:length(echo_index))=AllValuesperPSA3(i, echo_index);
    else
        echo_value3(i, 1)=0;
    end
    
    freepsa_index=find(methodsperPSA3(i, :)==5, 1, 'first');
    if isempty(freepsa_index)==0
        freepsa_value3(i, 1:length(freepsa_index))=AllValuesperPSA3(i, freepsa_index);
    else
        freepsa_value3(i, 1)=0;
    end
    
    dbc_index=find(methodsperPSA3(i, :)==6, 1, 'first');
    if isempty(dbc_index)==0
        dbc_value3(i, 1:length(dbc_index))=AllValuesperPSA3(i, dbc_index);
    else
        dbc_value3(i, 1)=0;
    end
end

% Now scatter all the possible combinations of parameters.
figure(1); scatter(biopt_value1,echo_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,echo_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,echo_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Gleason score'); 
ylabel('Volume (mL)');

figure(2); scatter(biopt_value1,mri_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,mri_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,mri_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Gleason score'); 
ylabel('PI-RADS');

figure(3); scatter(biopt_value1,psa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,psa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,psa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Gleason score'); 
ylabel('PSA concentration (ug/mL)');
ylim([0 50]);

figure(4); scatter(biopt_value1,freepsa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,freepsa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,freepsa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Gleason score'); 
ylabel('Free PSA concentration (ug/mL)');

figure(5); scatter(mri_value1,psa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,psa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,psa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('PI-RADS'); 
ylabel('PSA concentration (ug/mL)');
ylim([0 50]);

figure(6); scatter(mri_value1,freepsa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,freepsa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,freepsa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('PI-RADS'); 
ylabel('Free PSA concentration (ug/mL)');

figure(7); scatter(mri_value1,echo_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(biopt_value2,echo_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(biopt_value3,echo_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('PI-RADS'); 
ylabel('Volume (mL)');

figure(8); scatter(freepsa_value1,psa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(freepsa_value2,psa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(freepsa_value3,psa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Free PSA concentration (ug/mL)'); 
ylabel('PSA concentration (ug/mL)');
ylim([0 50]);

figure(9); scatter(echo_value1,psa_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(echo_value2,psa_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(echo_value3,psa_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Volume (mL)'); 
ylabel('PSA concentration (ug/mL)');
ylim([0 50]);

figure(10); scatter(freepsa_value1,echo_value1, 'r','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
hold on 
scatter(freepsa_value2,echo_value2, 'g','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
scatter(freepsa_value3,echo_value3, 'b','filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4);
xlabel('Free PSA concentration (ug/mL)'); 
ylabel('Volume (mL)');

