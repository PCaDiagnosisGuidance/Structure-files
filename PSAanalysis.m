close all

%Definitions for means of PSA and age per patient (ID)
IDUniq=unique(PSA.ID);
PSAperID=zeros(size(IDUniq));
AgePerID=PSAperID;
%AgeDiffPerID=PSAperID; %niet nodig, max hiervan is 8

%Calculating means per patient
for i=1:length(IDUniq)
    PSAperID(i)=mean(PSA.psa(PSA.ID==IDUniq(i)));
    AgePerID(i)=mean(PSA.age(PSA.ID==IDUniq(i)));
    
    %AgeDiffPerID(i)=max(PSA.age(PSA.ID==IDUniq(i)))-min(PSA.age(PSA.ID==IDUniq(i))); 
end

%Delete outliers; don't forget to alter titlestr
ind=find(isoutlier(PSAperID)==1);
for i=1:length(ind)
    PSAperID(ind(i)-i+1)=[];
    AgePerID(ind(i)-i+1)=[];
end
titlestr='w/o outliers';

%Further analysis of PSA versus age by different age-group sizes

%Define AgePerID stats for speed
minAgePerID=min(AgePerID); maxAgePerID=max(AgePerID);
AgeDifference=maxAgePerID-minAgePerID;

%Define age-group slice lengths here. I.e. 2 = slice per two years
AgeSlices=[1 2 5 10];

%Pre-allocating PSAmeans and AgeMeans
PSAmeans=NaN(length(AgeSlices),AgeDifference);
PSAvar=PSAmeans;
AgeMeans=PSAmeans;

for i=1:length(AgeSlices)
    DataPointCount=ceil(AgeDifference/AgeSlices(i));    
    
    %Amount of data points on x-axis
    for j=0:DataPointCount-1    
        
        %Define slice min age and max age
        Slicemin=minAgePerID+j*AgeSlices(i);
        Slicemax=minAgePerID+(j+1)*AgeSlices(i);
        
        %Find all indices of values of AgePerID that are in the slice range
        ind=find(and(AgePerID>=Slicemin,AgePerID<Slicemax));
        
        %Calculating means and variance
        PSAmeans(i,j+1)=mean(PSAperID(ind));
        PSAvar(i,j+1)=var(PSAperID(ind));
        AgeMeans(i,j+1)=mean(AgePerID(ind));    %Not taking median of slice, would skey data as would be not weigthed
    end
end

%Plots

figure(1)
legstr={};
hold on
for i=1:length(AgeSlices)
    plot(AgeMeans(i,:),PSAmeans(i,:))
    legstr=[legstr,strcat('Age group width:',{' '},string(AgeSlices(i)))];
end
hold off

title(strcat('Mean concentration of PSA by different age group widths',{' '},titlestr))
ylabel('Mean PSA concentration [µg/L]')
xlabel('Age [years]')
legend(legstr)

figure(2)
legstr={};
hold on
for i=1:length(AgeSlices)
    plot(AgeMeans(i,:),PSAvar(i,:))
    legstr=[legstr,strcat('Age group width:',{' '},string(AgeSlices(i)))];
end
hold off

title(strcat('Variance of PSA by different age group widths',{' '},titlestr))
ylabel('Variance of PSA concentration [µg/L]')
xlabel('Age [years]')
legend(legstr)