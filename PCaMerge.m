clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');


%% Some analysis
BIOPTUniq=unique(BIOPT.ID);
DBCUniq=unique(DBC.ID);

% BIOPTentryCount=zeros(size(BIOPTUniq));
% DBCentryCount=zeros(size(DBCUniq));
% 
% BioptMultiple=0;
% BioptMismatch=0;
% DBCMultiple=0;
% DBCMismatch=0;
% 
% for i=1:length(BIOPTUniq)
%     BIOPTentryCount(i)=sum(BIOPT.ID==BIOPTUniq(i));
%     ind=find(BIOPT.ID==BIOPTUniq(i));
%     
%     if length(ind) >= 2
%         BioptMultiple=BioptMultiple+1;
%         
%         if BIOPT.PCa(ind(1))~=BIOPT.PCa(ind(end))
%             BioptMismatch=BioptMismatch+1;
%         end
%     end
% end
% 
% for i=1:length(DBCUniq)
%     DBCentryCount(i)=sum(DBC.ID==DBCUniq(i));
%     ind=find(DBC.ID==DBCUniq(i));
%     
%     if length(ind) >= 2
%         DBCMultiple=DBCMultiple+1;
%         
%         if DBC.PCa(ind(1))~=DBC.PCa(ind(end))
%             DBCMismatch=DBCMismatch+1;
%         end
%     end
% end

%% Merging datasets
%Create PCa struct with BIOPT data
PCa.ID=BIOPTUniq;

PCa.PCa=zeros(size(BIOPTUniq));
PCa.date=PCa.PCa;

for i=1:length(BIOPTUniq)
    ind=find(BIOPT.ID==BIOPTUniq(i));
    PCa.PCa(i)=BIOPT.PCa(ind(end));
    PCa.date(i)=BIOPT.date(ind(end));
end

%Create DBC arrays for IDs that are not in BIOPT
DBCLeftoverID=DBCUniq(~ismember(DBCUniq,BIOPTUniq));
DBCLeftoverPCa=zeros(size(DBCLeftoverID));
DBCLeftoverDate=DBCLeftoverPCa;

for i=1:length(DBCLeftoverID)
    ind=find(DBC.ID==DBCLeftoverID(i));
    DBCLeftoverPCa(i)=DBC.PCa(ind(end));
    DBCLeftoverDate(i)=DBC.sdate(ind(end));
end

%Concatenate PCa arrays with DBC data
PCa.ID=[PCa.ID' DBCLeftoverID']';
PCa.PCa=[PCa.PCa' DBCLeftoverPCa']';
PCa.date=[PCa.date' DBCLeftoverDate']';

%Sort both PCa data arrays
[PCa.ID,ind]=sort(PCa.ID);
PCa.PCa=PCa.PCa(ind);
PCa.date=PCa.date(ind);

%Remove NaN entries
ind=find(~isnan(PCa.PCa));
PCa.ID=PCa.ID(ind);
PCa.PCa=PCa.PCa(ind);
PCa.date=PCa.date(ind);