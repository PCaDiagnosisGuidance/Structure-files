% Aligning of the data
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5';
[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut(foldername);

%% Aligning of the data in a new dataset
Dataset = [];

for i = 1:length(PSA.ID)
    pID = PSA.ID(i,1);
    psaTrue = find(PSA.ID == pID);
    fpsaTrue = find(PSA.ID == pID);    
    mriTrue = find(MRI.ID == pID);
    bioptTrue = find(BIOPT.ID == pID);
    echoTrue = find(ECHO.ID == pID);
    DBCTrue = find(DBC.ID == pID);
       
    if isempty(mriTrue)
        MRIvalue = 0;
    else
        % Currently the script takes the last measured value of a certain
        % parameter. Another possibility is to average all of the measured
        % values per patient
        MRIvalue = MRI.pirads(mriTrue(end),1); 
    end 
    
    if isempty(bioptTrue)
        bioptvalue = 0;
    else 
        bioptvalue = BIOPT.gleason(bioptTrue(end),1);
    end
    
    if isempty(echoTrue) 
        echovalue = 0;
    else 
        echovalue = ECHO.volume(echoTrue(end),1);
    end
    
    if isempty(DBCTrue)
        DBCvalue = -1; % geef het een negatieve waarde als de DBC diagnose onbekend is 
    else 
        DBCvalue = DBC.PCa(DBCTrue(end),1);
    end
    
    Dataset = [Dataset; pID, PSA.psa(psaTrue(end),1), PSA.freepsa(fpsaTrue(end),1), MRIvalue, bioptvalue, echovalue, DBCvalue];
end

% Eliminate the duplicate rows which occur due to multiple PSA level
% measurements 
Dataset = unique(Dataset, 'rows');

%% Visualization of data
% Eventueel mogelijk om 
% PSA versus PI-RADS score
subplot(2,5,1);
imri = find(Dataset(:,4));
psa = Dataset(imri,2);
pirads = Dataset(imri,4);
scatter(psa,pirads,'LineWidth',0.5);
axis([0 20 0 6]);
xlabel('PSA');
ylabel('PI-RADS'); 
clearvars psa

% PSA versus free PSA
subplot(2,5,2);
ifpsa = find(Dataset(:,3));
fpsa = Dataset(ifpsa,3);
psa = Dataset(ifpsa,2);
scatter(psa,fpsa,'LineWidth',0.5);
axis([0 10 0 5]);
xlabel('PSA');
ylabel('fPSA');
clearvars psa

% PSA versus Gleason score
subplot(2,5,3);
igleason = find(Dataset(:,5));
psa = Dataset(igleason,2);
gleason = Dataset(igleason,5);
scatter(psa,gleason,'LineWidth',0.5);
axis([0 20 0 10]);
xlabel('PSA');
ylabel('Gleason');
clearvars psa

% PSA versus Echo volume
subplot(2,5,4);
ivolume = find(Dataset(:,6));
psa = Dataset(ivolume,2);
volume = Dataset(ivolume,6);
scatter(psa,volume,'LineWidth',0.5);
axis([0 20 0 150]);
xlabel('PSA');
ylabel('Volume');
clearvars psa

% Echo versus fPSA 
subplot(2,5,5);
ivolume = find(Dataset(:,6));
fpsa = Dataset(ivolume,3);
volume = Dataset(ivolume,6);
scatter(fpsa,volume,'LineWidth',0.5);
axis([0.05 10 0 150]);
xlabel('fPSA');
ylabel('Volume');
clearvars fpsa

% PCa versus PSA
subplot(2,5,6);     
iPCa1 = find(Dataset(:,7) == 1);
psa1 = Dataset(iPCa1,2);
h1 = histogram(psa1,10000,'FaceColor','g'); % show the amount of PCa cases
hold on
iPCa2 = find(Dataset(:,7) == 0);
psa2 = Dataset(iPCa2,2);
h2 = histogram(psa2,10000); % show the amount of non PCa cases
xlim([0 25]);
xlabel('PSA');
clearvars psa1 psa2 

% PCa versus MRI
subplot(2,5,7);     
mri1 = Dataset(iPCa1,4);
h1 = histogram(mri1,6,'FaceColor','g');
hold on
mri2 = Dataset(iPCa2,4);
h2 = histogram(mri2,6);
xlim([1 6]);
ylim([0 500]); 
xlabel('PI-RADS');
clearvars mri1 mri2

% PCa versus freePSA
subplot(2,5,8);     
fPSA1 = Dataset(iPCa1,3);
h1 = histogram(fPSA1,50,'FaceColor','g');
hold on
fPSA2 = Dataset(iPCa2,3);
h2 = histogram(fPSA2,50);
xlim([0 10]);
ylim([0 300]);
xlabel('fPSA');
clearvars fPSA1 fPSA2

% PCa versus Gleason score
subplot(2,5,9);     
biopt1 = Dataset(iPCa1,5);
h1 = histogram(biopt1,12,'FaceColor','g');
hold on
biopt2 = Dataset(iPCa2,5);
h2 = histogram(biopt2,12);
xlim([0 12]);
ylim([0 350]);
xlabel('Gleason');
clearvars biopt1 biopt2

% PCa versus volume
subplot(2,5,10);     
echo1 = Dataset(iPCa1,6);
h1 = histogram(echo1,20,'FaceColor','g');
hold on
echo2 = Dataset(iPCa2,6);
h2 = histogram(echo2,20);
xlim([0 200]);
ylim([0 100]);
xlabel('Volume');
clearvars echo1 echo2

%test

