function stats=ShortDispersionStats(data)
stats(1)=length(data);
stats(2)=min(data);
stats(3)=max(data);
stats(4)=mean(data);
stats(5)=std(data);
stats(6)=kurtosis(data);
stats(7)=median(data);
stats(8)=iqr(data);