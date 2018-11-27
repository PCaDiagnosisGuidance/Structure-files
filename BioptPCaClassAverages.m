%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

clearvars -except BIOPT DBC ECHO MRI PSA

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
jaEntryCount=sum(and(BioptString=="ja",isnan(BIOPT.gleason)==0));

%Number of useful "ja (eerder)" entries
jaEerderEntryCount=sum(and(BioptString=="ja (eerder)",isnan(BIOPT.gleason)==0));

%Number of useful "ja (later)" entries
jaLaterEntryCount=sum(and(BioptString=="ja (later)",isnan(BIOPT.gleason)==0));

%Number of useful "nee" entries
neeEntryCount=sum(and(BioptString=="nee",isnan(BIOPT.gleason)==0));

entryArr=[jaEntryCount; jaEerderEntryCount; jaLaterEntryCount; neeEntryCount];

clearvars jaEntryCount neeEntryCount jaEerderEntryCount jaLaterEntryCount

%Table for entry counts
entryCounts=table({'ja';'jaEerderEntryCount';'jaLaterEntryCount';'nee'},entryArr);
