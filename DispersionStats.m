function [stats,ranksumStat]=DispersionStats(data,data2)
stats(1,1)=length(data);
stats(1,2)=min(data);
stats(1,3)=max(data);
stats(1,4)=mean(data);
stats(1,5)=std(data);
stats(1,6)=kurtosis(data);
stats(1,7)=median(data);
stats(1,8)=iqr(data);
stats(1,9)=skewness(data);

stats(2,1)=length(data2);
stats(2,2)=min(data2);
stats(2,3)=max(data2);
stats(2,4)=mean(data2);
stats(2,5)=std(data2);
stats(2,6)=kurtosis(data2);
stats(2,7)=median(data2);
stats(2,8)=iqr(data2);
stats(2,9)=skewness(data2);

ranksumStat=ranksum(data,data2);