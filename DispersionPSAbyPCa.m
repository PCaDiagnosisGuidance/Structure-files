clearvars -except BIOPT MRI PSA ECHO DBC PCa
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% Define PSA boundaries
lowerbound=4;
upperbound=10;

%% Create new PSA and PCa matrices per patient ID
PSAUniq=unique(PSA.ID);

PSAval=zeros(size(PSAUniq));
PCaval=PSAval;

for i=1:length(PSAUniq)
    PSAind=find(PSA.ID==PSAUniq(i));
    PCaind=find(PCa.ID==PSAUniq(i));
    
    PSAperpatient=PSA.psa(PSAind);
    PCaperpatient=PCa.PCa(PCaind);
    
    PSAval(i)=PSAperpatient(1);
    
    if isempty(PCaperpatient)
        PCaval(i) = -1; % geef het een negatieve waarde als de DBC diagnose onbekend is 
    else 
        PCaval(i) = PCaperpatient;
    end
end

%Dataset slicing and creation
%% PSA under 4
U4ind = find(PSAval < lowerbound);
U4PSAval=PSAval(U4ind);
U4PCaval=PCaval(U4ind); 

%Slice by PCa diagnosis
U4pospsa=U4PSAval(U4PCaval==1);
U4negpsa=U4PSAval(U4PCaval==0);
U4unknownpsa=U4PSAval(U4PCaval==-1);

%Apply dispersion analysis
U4pospsaStats=ShortDispersionStats(U4pospsa);
U4negpsaStats=ShortDispersionStats(U4negpsa);
U4unknownpsaStats=ShortDispersionStats(U4unknownpsa);

%% PSA between 4 and 10
O4U10ind = find(PSAval >= lowerbound & PSAval < upperbound);
O4U10PSAval=PSAval(O4U10ind);
O4U10PCaval=PCaval(O4U10ind);

%Slice by PCa diagnosis
O4U10pospsa=O4U10PSAval(O4U10PCaval==1);
O4U10negpsa=O4U10PSAval(O4U10PCaval==0);
O4U10unknownpsa=O4U10PSAval(O4U10PCaval==-1);

%Apply dispersion analysis
O4U10pospsaStats=ShortDispersionStats(O4U10pospsa);
O4U10negpsaStats=ShortDispersionStats(O4U10negpsa);
O4U10unknownpsaStats=ShortDispersionStats(O4U10unknownpsa);

%% PSA over 10
O10ind = find(PSAval >= upperbound);
O10PSAval=PSAval(O10ind);
O10PCaval=PCaval(O10ind);

%Slice by PCa diagnosis
O10pospsa=O10PSAval(O10PCaval==1);
O10negpsa=O10PSAval(O10PCaval==0);
O10unknownpsa=O10PSAval(O10PCaval==-1);

%Apply dispersion analysis
O10pospsaStats=ShortDispersionStats(O10pospsa);
O10negpsaStats=ShortDispersionStats(O10negpsa);
O10unknownpsaStats=ShortDispersionStats(O10unknownpsa);

