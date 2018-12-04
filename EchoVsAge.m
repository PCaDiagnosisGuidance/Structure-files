close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(ECHO.volume));

%Create three arrays new arrays for only the useful entries
scores=ECHO.volume(usefulEntryInd);
dates=ECHO.date(usefulEntryInd);
IDs=ECHO.ID(usefulEntryInd);

%Label naming
lbl='Prostate volume [mL]';

%Strip the PSA dataset to only consist of useful data (for comp speed)
PSAentryID=find(ismember(PSA.ID,IDs));

PSA.ID=PSA.ID(PSAentryID);
PSA.age=PSA.age(PSAentryID);
PSA.date=PSA.date(PSAentryID);

age=zeros(size(scores));

%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSA.ID==IDs(i));
    diffdatearr=abs(PSA.date(ind)-dates(i));
    [~,indmin]=min(diffdatearr);
    age(i)=PSA.age(ind(indmin));
end

figure(1)
scatter(age,scores)

X=[ones(size(age)) age];
[b,bint,r,rint,stats]=regress(scores,X);

hold on
plot(age,b(1)+b(2)*age)
hold off

ylabel(lbl)
xlabel('Age [years]')
title('Prostate volume by age with regression; a = 20, b = .5')

save('regr_stats.mat','b','bint','r','rint','stats')

age2=age;
scores2=scores;

ind=find(isoutlier(scores2)==1);
for i=1:length(ind)
    scores2(ind(i)-i+1)=[];
    age2(ind(i)-i+1)=[];
end

X=[ones(size(age2)) age2];
[b,bint,r,rint,stats]=regress(scores2,X);

figure(2)
scatter(age2,scores2)

hold on
plot(age,b(1)+b(2)*age)
hold off

ylabel(lbl)
xlabel('Age [years]')
title('Prostate volume by age w/o outliers with regression; a = 27, b = .4')

save('regr_stats_wo_outliers.mat','b','bint','r','rint','stats')



