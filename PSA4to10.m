% Aligning of the data
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Documents\MATLAB\OGO Computational Biology\OGO groep 5';

% Generate new dataset by merging all existing ones
Dataset = MergeDatasets(foldername);

%% What is happening for PSA values between 4 and 10? 
% find all PSA values which are higher than 4 and lower than 10
ipsa = find(Dataset(:,2)>=4 & Dataset(:,2)<=10);
psa = Dataset(ipsa,2);
PCa = Dataset(ipsa,7); % corresponding PCa diagnosis
mri = Dataset(ipsa,4);
biopt = Dataset(ipsa,5);

figure(1);
hist3([PCa,psa],'CdataMode','auto');
colorbar
xlabel('PCa (yes/no/NA)');
ylabel('PSA (microgram/liter)');

figure(2)
hist3([psa, biopt],'CdataMode','auto');
colorbar
xlabel('PSA (microgram/liter)');
ylabel('Gleason score');

figure(3)
hist3([psa,mri],'CdataMode','auto');
colorbar
xlabel('PSA (microgram/liter)');
ylabel('PI-RADS');

figure(4) 
h1 = hist3([PCa,mri],'CdataMode','auto');
hist3([PCa,mri],'CdataMode','auto');
colorbar
topbar4 = zeros(6,3); 
% each row in topbar contains the mean PSA of all patients which have a PSA
% value between 4 and 10 AND have a certain PI-RADS where every column  
% contains the PCa diagnosis (-1,0,1) respectively.
A = [-1,0,1]; 

for i = [0,1,2,3,4,5]
    for j = 1:3
        l = A(1,j);
        imri = find(Dataset(ipsa,4)==i);
        iPCa = find(Dataset(ipsa,7)==l);
        C = intersect(imri,iPCa);
        PSAvalues = psa(C,1);
        topbar4(i+1,j) = mean(PSAvalues); 
    end
end
B = [1,6,10];
C = [1,3,5,7,9,10];
for a = 1:3
    k = A(1,a);
    for b = 0:5
        text(k,b,h1(B(a),C(b+1)),num2str(topbar4(b+1,a)),'HorizontalAlignment','center','VerticalAlignment','bottom');
    end
end
xlabel('PCa (yes/no/NA)');
ylabel('PI-RADS');


figure(5) 
h2 = hist3([PCa,biopt],'CdataMode','auto')

hist3([PCa,biopt],'CdataMode','auto');
colorbar
topbar5 = zeros(11,3); 
for i = [0,1,2,3,4,5,6,7,8,9,10]
    for j = 1:3
        l = A(1,j);
        ibiopt = find(Dataset(ipsa,5)==i);
        iPCa = find(Dataset(ipsa,7)==l);
        C = intersect(ibiopt,iPCa);
        PSAvalues = psa(C,1);
        topbar5(i+1,j) = mean(PSAvalues); 
    end
end
A = [-1,0,1]; 
B = [1,6,10];
for a = 1:3
    k = A(1,a);
    for b = 0:10
        if b == 10
            text(k,b,h2(B(a),b),num2str(topbar5(b+1,a)),'HorizontalAlignment','right','VerticalAlignment','bottom');
        else
            text(k,b,h2(B(a),b+1),num2str(topbar5(b+1,a)),'HorizontalAlignment','right','VerticalAlignment','bottom');
        end
    end
end
xlabel('PCa (yes/no/NA)');
ylabel('Gleason score');

figure(6)
% Make a histogram of MRI values based on their PCa diagnosis
% all of these values still correspond with patients which had a 
% PSA value between 4 and 10 for their last PSA measurement.
PCatrue = find(PCa(:)==1);
mritrue = Dataset(PCatrue,4);
histogram(mritrue,6,'FaceColor','r','Normalization','probability');
hold on
PCafalse = find(PCa(:)==0);
mrifalse = Dataset(PCafalse,4);
histogram(mrifalse,6,'FaceColor','g','Normalization','probability');
xlabel('PI-RADS');

figure(7)
% Make a histogram of biopt values based on their PCa diagnosis
biopttrue = Dataset(PCatrue,5);
histogram(biopttrue,12,'FaceColor','r','Normalization','probability');
hold on 
bioptfalse = Dataset(PCafalse,5);
histogram(bioptfalse,12,'FaceColor','g','Normalization','probability');
xlabel('Gleason');


