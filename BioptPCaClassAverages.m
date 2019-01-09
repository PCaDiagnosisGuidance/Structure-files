%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

clearvars -except BIOPT DBC ECHO MRI PSA PCa

%All unique identifiers in MRI.PCa
BioptUniq=string(unique(BIOPT.PCa));

BioptString=string(BIOPT.PCa);

averages=zeros(size(BioptUniq));

for i=1:length(BioptUniq)
    averages(i)=nanmean(BIOPT.gleason(BioptString==BioptUniq{i}));
end

Averages=table(BioptUniq,averages);

%Checking that only a few classes contain useful values
ind=find(isnan(BIOPT.gleason)==0);
usefulClasses=unique(BioptString(ind));

clearvars ind i

%Number of useful "ja" entries
jaDataset=BIOPT.gleason(and(BioptString=="ja",isnan(BIOPT.gleason)==0));
jaStats=DispersionStats(jaDataset,1);

%Number of useful "ja (eerder)" entries
jaEerderDataset=BIOPT.gleason(and(BioptString=="ja (eerder)",isnan(BIOPT.gleason)==0));
jaEerderStats=DispersionStats(jaEerderDataset,1);

%Number of useful "ja (later)" entries
jaLaterDataset=BIOPT.gleason(and(BioptString=="ja (later)",isnan(BIOPT.gleason)==0));
jaLaterStats=DispersionStats(jaLaterDataset,1);

%Number of useful "nee" entries
neeDataset=BIOPT.gleason(and(BioptString=="nee",isnan(BIOPT.gleason)==0));
neeStats=DispersionStats(neeDataset,1);

QMcount=sum(BioptString=="?");
mogelijkCount=sum(BioptString=="mogelijk");

%%
% entryArr=[jaEntryCount; jaEerderEntryCount; jaLaterEntryCount; neeEntryCount];
% 
% clearvars jaEntryCount neeEntryCount jaEerderEntryCount jaLaterEntryCount
% 
% %Table for entry counts
% entryCounts=table({'ja';'jaEerderEntryCount';'jaLaterEntryCount';'nee'},entryArr);
