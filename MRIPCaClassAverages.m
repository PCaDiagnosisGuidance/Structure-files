%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

clearvars -except BIOPT DBC ECHO MRI PSA

%Set "0" values to NaN so mean can be calculated w/o using 0's
%MRI.pirads(MRI.pirads==0)=NaN;

%All unique identifiers in MRI.PCa
PCaUniq=string(unique(MRI.PCa));

PCaString=string(MRI.PCa);

averages=zeros(size(PCaUniq));

for i=1:length(PCaUniq)
    averages(i)=nanmean(MRI.pirads(PCaString==PCaUniq{i}));
end

Averages=table(PCaUniq,averages);

%Checking that only a few classes contain useful values
ind=find(isnan(MRI.pirads)==0);
usefulClasses=unique(PCaString(ind));

clearvars ind i

%Number of useful "ja" entries
jaEntryCount=sum(and(PCaString=="ja",isnan(MRI.pirads)==0));

%Number of useful "recidief" entries
recidiefEntryCount=sum(and(PCaString=="recidief",isnan(MRI.pirads)==0));

%Number of useful "nee" entries
neeEntryCount=sum(and(PCaString=="nee",isnan(MRI.pirads)==0));

entryArr=[jaEntryCount; neeEntryCount; recidiefEntryCount];

clearvars jaEntryCount recidiefEntryCount neeEntryCount

%Table for entry counts
entryCounts=table({'ja';'nee';'recidief'},entryArr);

%test
