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

%Data useful "ja" entries
jaPiradsDataset=MRI.pirads(and(PCaString=="ja",isnan(MRI.pirads)==0));
jaStats=DispersionStats(jaPiradsDataset,1);

%Data useful "recidief" entries
recidiefPiradsDataset=MRI.pirads(and(PCaString=="recidief",isnan(MRI.pirads)==0));
recidiefStats=DispersionStats(recidiefPiradsDataset,1);

%Data useful "nee" entries
neePiradsDataset=MRI.pirads(and(PCaString=="nee",isnan(MRI.pirads)==0));
neeStats=DispersionStats(neePiradsDataset,1);

%Data useful "?" entries
QMPiradsDataset=MRI.pirads(and(PCaString=="?",isnan(MRI.pirads)==0));
QMStats=DispersionStats(QMPiradsDataset,1);

%%
% entryArr=[jaEntryCount; neeEntryCount; recidiefEntryCount];
% 
% clearvars jaEntryCount recidiefEntryCount neeEntryCount
% 
% %Table for entry counts
% entryCounts=table({'ja';'nee';'recidief'},entryArr);
