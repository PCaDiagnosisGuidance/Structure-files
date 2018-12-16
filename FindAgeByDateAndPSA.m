function [age,psaval]=FindAgeByDateAndPSA(PSA,scores,dates,IDs,PSAwindow)
%Find entry IDs in PSA database
PSAentryID=find(ismember(PSA.ID,IDs));

PSAID=PSA.ID(PSAentryID);
PSAval=PSA.psa(PSAentryID);
PSAage=PSA.age(PSAentryID);
PSAdate=PSA.date(PSAentryID);

k=1;
%Find corresponding age with score by using nearest date
for i=1:length(scores)
    ind=find(PSAID==IDs(i));
    PSAperID=PSAval(ind);
    if PSAperID(1) >= PSAwindow(1) && PSAperID(1) < PSAwindow(2)
        diffdatearr=abs(PSAdate(ind)-dates(i));
        [~,indmin]=min(diffdatearr);
        age(k)=PSAage(ind(indmin));
        psaval(k)=PSAval(ind(indmin));
        k=k+1;
    end
end
end