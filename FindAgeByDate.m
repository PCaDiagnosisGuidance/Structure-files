function [age,psaval]=FindAgeByDate(PSA,scores,dates,IDs)
%Find entry IDs in PSA database
PSAentryID=find(ismember(PSA.ID,IDs));

PSAID=PSA.ID(PSAentryID);
PSAval=PSA.psa(PSAentryID);
PSAage=PSA.age(PSAentryID);
PSAdate=PSA.date(PSAentryID);

age=zeros(size(scores));
psaval=age;

%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSAID==IDs(i));
    diffdatearr=abs(PSAdate(ind)-dates(i));
    [~,indmin]=min(diffdatearr);
    age(i)=PSAage(ind(indmin));
    psaval(i)=PSAval(ind(indmin));
end
end