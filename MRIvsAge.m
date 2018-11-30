close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');

%Find all indices for useful entries in score dataset
usefulEntryInd=find(~isnan(MRI.pirads));

%Create three arrays new arrays for only the useful entries
scores=MRI.pirads(usefulEntryInd);
dates=MRI.date(usefulEntryInd);
IDs=MRI.ID(usefulEntryInd);

%Label naming
lbl='PI-RADS';

%Strip the PSA dataset to only consist of useful data (for comp speed)
PSAentryID=find(ismember(PSA.ID,IDs));

PSA.ID=PSA.ID(PSAentryID);
PSA.age=PSA.age(PSAentryID);
PSA.date=PSA.date(PSAentryID);

age=zeros(size(scores));

%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSA.ID==IDs(i));
    diffdatearr=abs(PSA.age(ind)-dates(i));
    [~,indmin]=min(diffdatearr);
    age(i)=PSA.age(ind(indmin));
end


%Create a normal distribution plot per score (makes just a bit of sense
%out of data).
allscores=min(scores):max(scores);
meanage=zeros(size(allscores));
standev=meanage;

figure(1)
hold on
for i=1:length(allscores)
    ind=find(scores==allscores(i));
    meanage(i)=mean(age(ind));
    standev=std(age(ind));
    x=min(age(ind)):max(age(ind));
    y=normpdf(x,meanage(i),standev);
    plot(x,y)
end
hold off

xlabel('Age [years]')
title(['Normal distributions of age per ',lbl,' value.'])

legend(string(allscores))

figure(2)
plot(allscores,meanage)

xlabel(lbl)
ylabel('Age [years]')
title(['Mean age per ',lbl,' value.'])


%%
% andere dingen die ik had geprobeerd
%
% hold on
% for i=1:length(allscores)
%     ind=find(scores==allscores(i));
%     [x,y]=integerhistcount(age(ind));
%     y=smooth(y);
%     plot(x,y);
% end
% hold off

% for i=1:length(scores)
%     ind=find(PSA.ID==IDs(i));
%     meanage(i)=mean(PSA.age(ind));
% end