% Loading of the data in the form of structs
load('echodata.mat')
load('psadata.mat')
load('dbcdata.mat')
load('bioptdata.mat')

%% PSA data Read-out
psaID = psadata.patientID; 
age = psadata.Leeftijd;
psa = psadata.PSA;      % unit is microgram/L
freepsa = psadata.VRIJPSA;
psadate = psadata.datumtijd; 
psadate = datenum(psadate); % Converting of date to a numeric value


%% MRI data Read-out --> ik heb deze nu anders gedaan omdat dit er voor zorgt 
% dat er geen NaN's verschijnen in de data
% Initialize variables.
filename = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5\OGO PSA - MRI data.csv';
delimiter = ',';
startRow = 2;
% Format string for each line of text:
%   column1: double (%f)
%	column2: text (%q)
%   column3: text (%q)
%	column4: text (%q)
%   column5: text (%q)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%q%q%q%q%[^\n\r]';
% Open the text file.
fileID = fopen(filename,'r');
% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
% Close the text file.
fclose(fileID);

% Allocate imported array to column variable names
mriID = dataArray{:, 1};
mridate = dataArray{:, 2};
%OMSCHR = dataArray{:, 3};  deze is waarschijnlijk niet nodig
pirads = dataArray{:, 4};
mriPCa = dataArray{:, 5};

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% MRI data manipulations
% Converting of date to a numeric value
mridate = datenum(mridate); 

% PI-RADS values completion, set all unknown and negative values to 0
for i=1:length(pirads)
    if strcmp(pirads(i,1),'neg') == 1 || strcmp(pirads(i,1),'geen')== 1 ...
            || strcmp(pirads(i,1),'?') == 1
        pirads(i,1) = {'0'}; 
    end
end
pirads = str2double(pirads);

% mriPCa completion, applying 1 to PCa positve and 0 to PCa negative cases
%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Biopt data Read-out
filename = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5\OGO PSA - biopt data.csv';
delimiter = ',';
startRow = 2;

formatSpec = '%f%q%q%q%[^\n\r]';

fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

bioptID = dataArray{:, 1};
bioptdate = dataArray{:, 2};
bioptPCa = dataArray{:, 3};
gleason = dataArray{:, 4};

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Biopt data manipulations
% Converting of date to a numeric value
bioptdate = datenum(bioptdate); 

% Gleason values completion, set all unknown and negative values to 0
for i=1:length(gleason)
    if strcmp(gleason(i,1),'neg') == 1 || strcmp(gleason(i,1),'?') == 1
        gleason(i,1) = {'0'}; 
    elseif strcmp(gleason(i,1),'prostatectomie') == 1
        gleason(i,1) = {'0'};   % Ik heb deze er nu los bij gezet, omdat we deze later misschien willen weghalen
    end
end
gleason = str2double(gleason);

% bioptPCa completion, applying 1 to PCa positve and 0 to PCa negative cases
%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%%
bioptPCa = lower(bioptPCa);
for i=1:length(bioptPCa)
    if strcmp(bioptPCa(i,1),'nee') == 1 || strcmp(bioptPCa(i,1),'?') == 1 
        bioptPCa(i,1) = {'0'}; 
    elseif strcmp(bioptPCa(i,1),'ja') == 1 || strcmp(bioptPCa(i,1),'ja (eerder)') == 1 ...
            || strcmp(bioptPCa(i,1),'ja (later)') == 1 
        bioptPCa(i,1) = {'1'};
    elseif strcmp(bioptPCa(i,1),'mogelijk') == 1 % niet zeker hoe we dit moeten doen
        bioptPCa(i,1) = {'0.5'};                 % 0.5 als mogelijke uitkomst?
    end
end
bioptPCa = str2double(bioptPCa);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Echo data Read-out
filename = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5\OGO PSA - Echo data.csv';
delimiter = ',';
startRow = 2;

formatSpec = '%f%q%q%[^\n\r]';

fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

echoID = dataArray{:, 1};
echodate = dataArray{:, 2};
volume = dataArray{:, 3};

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Converting of date to a numeric value
echodate = datenum(echodate); 

% Gleason values completion, set all unknown and negative values to 0
for i=1:length(volume)
    if strcmp(volume(i,1),'NA') == 1 || strcmp(volume(i,1),'?') == 1
        volume(i,1) = {'0'}; 
    elseif strcmp(volume(i,1),'>116') == 1 % Deze twee elseif statements zouden wel 'mooier' kunnen
        volume(i,1) = {'116'};  
    elseif strcmp(volume(i,1),'>150') == 1
        volume(i,1) = {'150'};
    end
end
volume = str2double(volume);


%% DBC data read-out
filename = 'C:\Users\s165635\Desktop\DBL Computational Biology (8QC00)\OGO groep 5\OGO PSA - DBC data.csv.csv';
delimiter = ',';
startRow = 2;

formatSpec = '%f%q%q%q%[^\n\r]';
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

dbcID = dataArray{:, 1};
dbcsdate = dataArray{:, 2};
dbcedate = dataArray{:, 3};
dbcPCa = dataArray{:, 4};

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Converting of dates to a numeric value
dbcsdate = datenum(dbcsdate);
dbcedate = datenum(dbcedate);

% dbcPCa completion, applying 1 to PCa positve and 0 to PCa negative cases
for i=1:length(dbcPCa)
    if strcmp(dbcPCa(i,1),'niet-PCa') == 1 
        dbcPCa(i,1) = {'0'}; 
    elseif strcmp(dbcPCa(i,1),'PCA') == 1
        dbcPCa(i,1) = {'1'};
    end
end
dbcPCa = str2double(dbcPCa);
