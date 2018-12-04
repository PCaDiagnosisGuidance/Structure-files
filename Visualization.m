% Aligning of the data
clear
close all 
% Read-out of the data, foldername is the folder where all 5 of the csv 
% data sets are saved. 
foldername = 'C:\Users\s165635\Documents\MATLAB\OGO Computational Biology\OGO groep 5';
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
figure(1);
subplot(2,3,1);
imri = find(Dataset(:,4));
psa = Dataset(imri,2);
pirads = Dataset(imri,4);
scatter(psa,pirads,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.02,'MarkerEdgeAlpha',.2);
axis([0 20 0 6]);
xlabel('PSA');
ylabel('PI-RADS'); 
clearvars psa imri pirads

% PSA versus free PSA
subplot(2,3,2);
ifpsa = find(Dataset(:,3));
fpsa = Dataset(ifpsa,3);
psa = Dataset(ifpsa,2);
scatter(psa,fpsa,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.2);
axis([0 10 0 5]);
xlabel('PSA');
ylabel('fPSA');
clearvars psa fpsa ifpsa

% PSA versus Gleason score
subplot(2,3,3);
igleason = find(Dataset(:,5));
psa = Dataset(igleason,2);
gleason = Dataset(igleason,5);
scatter(psa,gleason,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.2);
axis([0 20 0 10]);
xlabel('PSA');
ylabel('Gleason');
clearvars psa gleason igleason

% PSA versus Echo volume
subplot(2,3,4);
ivolume = find(Dataset(:,6));
psa = Dataset(ivolume,2);
volume = Dataset(ivolume,6);
scatter(psa,volume,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
axis([0 20 0 150]);
xlabel('PSA');
ylabel('Volume');
clearvars psa volume ivolume

% Echo versus fPSA 
subplot(2,3,5);
ivolume = find(Dataset(:,6));
fpsa = Dataset(ivolume,3);
volume = Dataset(ivolume,6);
scatter(fpsa,volume,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
axis([0.05 10 0 150]);
xlabel('fPSA');
ylabel('Volume');
clearvars fpsa volume ivolume

% PCa versus PSA
figure(2);
subplot(2,3,1);     
iPCa1 = find(Dataset(:,7) == 1);
psa1 = Dataset(iPCa1,2);
h1 = histogram(psa1,10000,'FaceColor','g','Normalization','probability'); % show the amount of PCa cases
hold on
iPCa2 = find(Dataset(:,7) == 0);
psa2 = Dataset(iPCa2,2);
h2 = histogram(psa2,10000,'FaceColor','r','Normalization','probability'); % show the amount of non PCa cases
xlim([0 25]);
ylim([0 0.1]);
xlabel('PSA');
clearvars psa1 psa2

% PCa versus MRI
subplot(2,3,2);     
mri1 = Dataset(iPCa1,4);
h1 = histogram(mri1,6,'FaceColor','g','Normalization','probability');
hold on
mri2 = Dataset(iPCa2,4);
h2 = histogram(mri2,6,'FaceColor','r','Normalization','probability');
xlim([1 6]);
ylim([0 0.4]); 
xlabel('PI-RADS');
clearvars mri1 mri2

% PCa versus freePSA
subplot(2,3,3);     
fPSA1 = Dataset(iPCa1,3);
h1 = histogram(fPSA1,150,'FaceColor','g','Normalization','probability');
hold on
fPSA2 = Dataset(iPCa2,3);
h2 = histogram(fPSA2,150,'FaceColor','r','Normalization','probability');
xlim([0 3]);
ylim([0 1]);
xlabel('fPSA');
clearvars fPSA1 fPSA2

% PCa versus Gleason score
subplot(2,3,4);     
biopt1 = Dataset(iPCa1,5);
h1 = histogram(biopt1,12,'FaceColor','g','Normalization','probability');
hold on
biopt2 = Dataset(iPCa2,5);
h2 = histogram(biopt2,12,'FaceColor','r','Normalization','probability');
xlim([1 10.2]);
ylim([0 0.4]);
xlabel('Gleason');
clearvars biopt1 biopt2

% PCa versus volume
subplot(2,3,5);     
echo1 = Dataset(iPCa1,6);
h1 = histogram(echo1,120,'FaceColor','g','Normalization','probability');
hold on
echo2 = Dataset(iPCa2,6);
h2 = histogram(echo2,120,'FaceColor','r','Normalization','probability');
xlim([0.02 60]);
ylim([0 0.05]);
xlabel('Volume');
clearvars echo1 echo2 iPCa1 iPCa2

%% Further visualisation of data
% Either uncomment the Visualize(1) or Visualize(2) for ALL subplots
figure(3);
% MRI versus FPSA
subplot(2,3,1);
imri = find(Dataset(:,4));

% Visualize(1) the relation between the two parameters
pirads =Dataset(imri,4);
fpsa = Dataset(imri,3);
scatter(pirads,fpsa,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.2);


% % Visualize(2) the relation with PCa diagnosis
% iPCa1 = find(Dataset(imri,7) == 1);
% iPCa2 = find(Dataset(imri,7) == 0); 
% fpsa1 = Dataset(iPCa1,3);
% pirads1 = Dataset(iPCa1,4); % green dots are PCa positive and red are PCa negative
% scatter(pirads1,fpsa1,'LineWidth',0.5,'MarkerFaceColor','g','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
% hold on;
% fpsa2 = Dataset(iPCa2,3);
% pirads2 = Dataset(iPCa2,4);
% scatter(pirads2,fpsa2,'LineWidth',0.5,'MarkerFaceColor','r','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);


xlabel('PI-RADS');
ylabel('Free PSA'); 
xlim([0 5.2]);
ylim([0.2,6.5]);
clearvars fpsa

% MRI versus Biopsy
subplot(2,3,2);

% Visualize(1) the relation between the two parameters
gleason = Dataset(imri,5);
scatter(pirads,gleason,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.02,'MarkerEdgeAlpha',.2);

% % Visualize(2) the relation with PCa diagnosis
% gleason1 = Dataset(iPCa1,5);
% pirads1 = Dataset(iPCa1,4);
% scatter(pirads1,gleason1,'LineWidth',0.5,'MarkerFaceColor','g','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
% hold on;
% gleason2 = Dataset(iPCa2,5);
% pirads2 = Dataset(iPCa2,4);
% scatter(pirads2,gleason2,'LineWidth',0.5,'MarkerFaceColor','r','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);


xlabel('PI-RADS');
ylabel('Gleason'); 
xlim([0 5.2]);
ylim([5 10]);
clearvars gleason

% MRI versus volume
subplot(2,3,3);

% Visualize(1) the relation between the two parameters
volume = Dataset(imri,6);
scatter(pirads,volume,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.2);


% % Visualize(2) the relation with PCa diagnosis
% volume1 = Dataset(iPCa1,6);
% pirads1 = Dataset(iPCa1,4);
% scatter(pirads1,volume1,'LineWidth',0.5,'MarkerFaceColor','g','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
% hold on;
% volume2 = Dataset(iPCa2,6);
% pirads2 = Dataset(iPCa2,4);
% scatter(pirads2,volume2,'LineWidth',0.5,'MarkerFaceColor','r','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);


xlabel('PI-RADS');
ylabel('Volume'); 
xlim([0 5.2]);
ylim([0.2 200]);
clearvars volume pirads imri

% Biopsy versus FPSA
subplot(2,3,4);
igleason = find(Dataset(:,5));

% Visualize(1) the relation between the two parameters
fpsa = Dataset(igleason,3);
gleason = Dataset(igleason,5);
scatter(gleason,fpsa,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);

% % Visualize(2) the relation with PCa diagnosis
% iPCa1 = find(Dataset(igleason,7) == 1);
% iPCa2 = find(Dataset(igleason,7) == 0);
% gleason1 = Dataset(iPCa1,5);
% fpsa1 = Dataset(iPCa1,3);
% scatter(gleason1,fpsa1,'LineWidth',0.5,'MarkerFaceColor','g','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
% hold on;
% gleason2 = Dataset(iPCa2,5);
% fpsa2 = Dataset(iPCa2,3);
% scatter(gleason2,fpsa2,'LineWidth',0.5,'MarkerFaceColor','r','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);


xlabel('Gleason');
ylabel('Free PSA'); 
xlim([3 10]);
ylim([0.2 5]);
clearvars fpsa

% Biopsy versus Volume
subplot(2,3,5);

% Visualize(1) the relation between the two parameters
volume = Dataset(igleason,6);
scatter(gleason,volume,'LineWidth',0.5,'MarkerFaceColor','b','MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.2);

% % Visualize(2) the relation with PCa diagnosis
% gleason1 = Dataset(iPCa1,5);
% volume1 = Dataset(iPCa1,6);
% scatter(gleason1,volume1,'LineWidth',0.5,'MarkerFaceColor','g','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);
% hold on;
% gleason2 = Dataset(iPCa2,5);
% volume2 = Dataset(iPCa2,6);
% scatter(gleason2,volume2,'LineWidth',0.5,'MarkerFaceColor','r','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.2);


xlabel('Gleason');
ylabel('Volume'); 
ylim([0.2 ,160]);
clearvars volume gleason igleason


