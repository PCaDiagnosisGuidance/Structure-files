clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%%
upperbounds=10:20;
ratio=zeros(size(upperbounds));

for j=1:length(upperbounds)
    
    upperbound=upperbounds(j);

    lowerbound=4;

    PSAUniq=unique(PSA.ID);

    PSAval=zeros(size(PSAUniq));
    DBCval=PSAval;

    for i=1:length(PSAUniq)
        PSAind=find(PSA.ID==PSAUniq(i));
        DBCind=find(DBC.ID==PSAUniq(i));

        PSAperpatient=PSA.psa(PSAind);
        DBCperpatient=DBC.PCa(DBCind);

        PSAval(i)=PSAperpatient(1);

        if isempty(DBCperpatient)
            DBCval(i) = -1; % geef het een negatieve waarde als de DBC diagnose onbekend is 
        else 
            DBCval(i) = DBCperpatient(end);
        end
    end

    U4ind = find(PSAval < lowerbound);
    U4PSAval=PSAval(U4ind);
    U4DBCval=DBCval(U4ind); 

    U4pospsa=U4PSAval(U4DBCval==1);
    U4negpsa=U4PSAval(U4DBCval==0);
    U4unknownpsa=U4PSAval(U4DBCval==-1);

    O10ind = find(PSAval >= upperbound);
    O10PSAval=PSAval(O10ind);
    O10DBCval=DBCval(O10ind); 

    O10pospsa=O10PSAval(O10DBCval==1);
    O10negpsa=O10PSAval(O10DBCval==0);
    O10unknownpsa=O10PSAval(O10DBCval==-1);
    
    ratio(j)=length(O10pospsa)/(length(O10negpsa)+length(O10pospsa));
end

figure(1)
subplot(1,3,1)

U4posStats=DispersionAnalysis(U4pospsa,'Normplot');
title('Initial PSA values < 4 dataset for patients with PCa')
subplot(1,3,2)

U4negStats=DispersionAnalysis(U4negpsa,'Normplot');
title('Initial PSA values < 4 dataset for patients without PCa')

subplot(1,3,3)

U4unknownStats=DispersionAnalysis(U4unknownpsa,'Normplot');
title('Initial PSA values < 4 dataset for patients without a DBC entry')

figure(2)
subplot(1,3,1)

O10posStats=DispersionAnalysis(O10pospsa,'Normplot');
title('Initial PSA values >= 10 dataset for patients with PCa')

subplot(1,3,2)

O10negStats=DispersionAnalysis(O10negpsa,'Normplot');
title('Initial PSA values >= 10 dataset for patients without PCa')

subplot(1,3,3)

O10unknownStats=DispersionAnalysis(O10unknownpsa,'Normplot');
title('Initial PSA values >= 10 dataset for patients without a DBC entry')

figure(3)
plot(upperbounds,ratio)