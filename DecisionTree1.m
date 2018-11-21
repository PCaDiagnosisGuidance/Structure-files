load('echodata.mat')
load('mridata.mat')
load('psadata.mat')
load('dbcdata.mat')
load('bioptdata.mat')

gleason = bioptdata.Gleason;
volume = echodata.VOLUME;
pirads = mridata.PIRADS;
psa = psadata.PSA;
freepsa = psadata.VRIJPSA;
labels = mridata.PCA;

% Neem een COMPLEET willekeurige sampling van de data (dit heeft dus ook
% helemaal geen betekenis)
x = length(pirads);

compile = [gleason(1:x,:),volume(1:x,:),pirads,freepsa(1:x,:)];

% Er is ook nog geen onderscheid gemaakt tussen training en test data
% (training en test data moeten beide een compile en labels array hebben)

ctree = fitctree(compile,labels(1:x));
view(ctree,'mode','graph')
