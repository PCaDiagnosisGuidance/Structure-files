clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%Determine unique IDs that are in both sets
Crosscheckind=find(~isnan(BIOPT.PCa));
comparisonIDs=unique(DBC.ID(ismember(DBC.ID,BIOPT.ID(Crosscheckind))));

% BIOPTind=find(ismember(BIOPT.ID,comparisonIDs));
% DBCind=find(ismember(DBC.ID,comparisonIDs));

%Since some patients have multiple PCa entries, comparing last ones.
LastPCaComparison=0;
for i=1:length(comparisonIDs)
    BIOPTind=find(BIOPT.ID==comparisonIDs(i));
    DBCind=find(DBC.ID==comparisonIDs(i));
    
    if BIOPT.PCa(BIOPTind(end))==DBC.PCa(DBCind(end))
        LastPCaComparison=LastPCaComparison+1;
    end
end

%Comparing all PCa entries in both datasets and checking if any combination
%matches.
AnyPCaComparison=0;
for i=1:length(comparisonIDs)
    BIOPTind=find(BIOPT.ID==comparisonIDs(i));
    DBCind=find(DBC.ID==comparisonIDs(i));
    
    if sum(ismember(BIOPT.PCa(BIOPTind),DBC.PCa(DBCind))) >= 1
        AnyPCaComparison=AnyPCaComparison+1;
    end
end