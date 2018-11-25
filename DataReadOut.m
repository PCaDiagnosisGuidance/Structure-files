function [PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut(datalocation)
% datalocation should be a string of the folder location where the csv data
% files are saved. 
% This document reads out the 5 data files and assigns the columns
% corresponding to different kinds of data to column vectors. The output 
% contains 5 structs: PSA,MRI,BIOPT,ECHO,DBC. The strings in the data
% are converted to numerical values so that they can easily be used in
% computation later on. 

% Give error when input is not a string
% if ~isstring(datalocation)
%    error('Error. \nInput must be a string, not a %s.',class(datalocation))
% end

%% PSA data Read-out
% Initialize variables.
filename = strcat(datalocation,'\OGO PSA - PSA waarde data.csv');
delimiter = ',';
startRow = 2;

% Format string for each line of text:
%   column1: double (%f)
%	column2: text (%q)
%   column3: double (%f)
%	column4: text (%q)
%   column5: text (%q)
%	column6: text (%q)
%   column7: text (%q)
%	column8: text (%q)
%   column9: text (%q)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%q%f%q%q%q%q%q%q%[^\n\r]';

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
psaID = dataArray{:, 1};
gender = dataArray{:, 2};
age = dataArray{:, 3};
psa = dataArray{:, 4};
freepsa = dataArray{:, 5};
unit = dataArray{:, 6};
datepsa = dataArray{:, 7};
specialism = dataArray{:, 8};
activity = dataArray{:, 9};

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

datepsa = datenum(datepsa); % Converting of date to a numeric value

% PSA values completion
for i=1:length(psa)
    if strcmp(psa(i,1),'<0,0030') == 1 
        psa(i,1) = {'0.0030'}; 
    elseif strcmp(psa(i,1),'<0,0031')== 1
        psa(i,1) = {'0.0031'}; 
    elseif strcmp(psa(i,1),'<0,10') == 1
        psa(i,1) = {'0.10'}; 
    elseif strcmp(psa(i,1),'>100') == 1
        psa(i,1) = {'100'}; 
    elseif strcmp(psa(i,1),'>5000') == 1
        psa(i,1) = {'5000'}; 
    end
end
psa = str2double(psa);


% FreePSA values completion
for i=1:length(freepsa)
    if strcmp(freepsa(i,1),'<0,10') == 1 
        freepsa(i,1) = {'0.10'}; 
    elseif strcmp(freepsa(i,1),'>50') == 1
        freepsa(i,1) = {'50'}; 
    elseif strcmp(freepsa(i,1),'NA') == 1
        freepsa(i,1) = {'0'};
    end
end
freepsa = str2double(freepsa);

% Creating a struct of the data
PSA.ID = psaID;
PSA.gender = gender;
PSA.age = age;
PSA.psa = psa;
PSA.freepsa = freepsa; 
PSA.date = datepsa;

%% MRI data Read-out 
filename = strcat(datalocation,'\OGO PSA - MRI data.csv');
delimiter = ',';
startRow = 2;

formatSpec = '%f%q%q%q%q%[^\n\r]';

fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

mriID = dataArray{:, 1};
mridate = dataArray{:, 2};
%OMSCHR = dataArray{:, 3};  deze is waarschijnlijk niet nodig
pirads = dataArray{:, 4};
mriPCa = dataArray{:, 5};

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

% Creating a struct of the data
MRI.ID = mriID; 
MRI.date = mridate; 
MRI.pirads = pirads;
MRI.PCa = mriPCa;

%% Biopt data Read-out
filename = strcat(datalocation, '\OGO PSA - biopt data.csv');
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

% Creating a struct of the data
BIOPT.ID = bioptID;
BIOPT.date = bioptdate; 
BIOPT.PCa = bioptPCa;
BIOPT.gleason = gleason;


%% Echo data Read-out
filename = strcat(datalocation, '\OGO PSA - Echo data.csv');
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

% Creating a struct of the data
ECHO.ID = echoID;
ECHO.date = echodate;
ECHO.volume = volume;

%% DBC data read-out
filename = strcat(datalocation, '\OGO PSA - DBC data.csv.csv');
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

% dbcedate completion, applying the date '3000-01-01' to NA values which
% corresponds to the datenum value: 1095729. This way the date will always
% be later than any other date in the data set.
for i=1:length(dbcedate)
    if strcmp(dbcedate(i,1),'NA') == 1 
        dbcedate(i,1) = {'3000-01-01'};
    end
end
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

% Creating a struct of the data
DBC.ID = dbcID;
DBC.sdate = dbcsdate;
DBC.edate = dbcedate;
DBC.PCa = dbcPCa;
