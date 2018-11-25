clearvars -except BIOPT DBC ECHO MRI PSA

%Set "0" values to NaN so mean can be calculated w/o using 0's
MRI.pirads(MRI.pirads==0)=NaN;

%All unique identifiers in MRI.PCa
PCaUniq=string(unique(MRI.PCa));

PCaString=string(MRI.PCa);

averages=zeros(size(PCaUniq));

for i=1:length(PCaUniq)
    averages(i)=nanmean(MRI.pirads(PCaString==PCaUniq{i}));
end

%Checken dat alleen enkele classes bruikbare waarden hebben
ind=find(isnan(MRI.pirads)==0);
usefulClasses=unique(PCaString(ind));

clearvars ind i