clearvars -except BIOPT MRI PSA ECHO DBC
close all

%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('E:\Scyonite\Documents\MATLAB\OGOPSAdata');
%[PSA,MRI,BIOPT,ECHO,DBC] = DataReadOut('C:\Users\s129625\Desktop\OGO groep 5');

%% PSA change rate per patient with over 2 PSA measurements

%Specification of date window, psa range of first measurement and analysis
%with or without outliers (by mean, not median)

datewindow=[120];  %Leave empty for no date window
psarange=[4 10];    %Use [-Inf Inf] to select whole range
Outliers=false;   %true for analysis including outliers, false for without

%% Script
PSAUniq=unique(PSA.ID);

totalDiffCancer=[];
totalDiffNoCancer=[];

hold on
for i=1:length(PSAUniq)
    
    ind=find(PSA.ID==PSAUniq(i));
    dates=PSA.date(ind);    %Dates per patient
    if ~isempty(datewindow)
        dates=dates(dates <= datewindow+dates(1));  %Apply date window
    end
    
    if length(dates) > 2    %Patients with less than three dates become a single point in the plot        
        psaval=PSA.psa(ind);
        
        if psaval(1) >= psarange(1) && psaval(1) <= psarange(2) %Apply range window (to first value)
        
            if ~isempty(datewindow)
                psaval=psaval(dates <= datewindow+dates(1));
            end

            %Find the patient in BIOPT and DBC
            indBIOPT=find(BIOPT.ID==PSAUniq(i));    
            indDBC=find(DBC.ID==PSAUniq(i));

            %Check biopt first, since golden standard
            if ~isempty(indBIOPT)  && ~isnan(BIOPT.PCa(indBIOPT(end)))
                if BIOPT.PCa(indBIOPT(end))
                    colour='r';

                    change=diff(psaval)./max(1,diff(dates));    %max(1,) because sometimes change is inf
                    totalchange=(psaval(end)-psaval(1))/(dates(end)-dates(1));
                    totalDiffCancer=[totalDiffCancer totalchange];
                else
                    colour='g';

                    change=diff(psaval)./max(1,diff(dates));
                    totalchange=(psaval(end)-psaval(1))/(dates(end)-dates(1));
                    totalDiffNoCancer=[totalDiffNoCancer totalchange];
                end
                plot(change,colour)

            %Check DBC if patient is not in BIOPT, patient is not plotted if
            %PCa is not known in either of two datasets
            elseif ~isempty(indDBC)
                if DBC.PCa(indDBC(end))
                    colour='r';

                    change=diff(psaval)./max(1,diff(dates));
                    totalchange=(psaval(end)-psaval(1))/(dates(end)-dates(1));
                    totalDiffCancer=[totalDiffCancer totalchange];
                else
                    colour='g';

                    change=diff(psaval)./max(1,diff(dates));
                    totalchange=(psaval(end)-psaval(1))/(dates(end)-dates(1));
                    totalDiffNoCancer=[totalDiffNoCancer totalchange];
                end 
                plot(change,colour)
            end
        end
    end
end
hold off

title('Change rate of PSA per day after every measurement for all patients meeting criteria')
ylabel('Change rate [ug L^{-1} day^{-1}]')
xlabel('Measurement number')

if ~Outliers
    totalDiffCancer=totalDiffCancer(~isoutlier(totalDiffCancer,'mean'));
    totalDiffNoCancer=totalDiffNoCancer(~isoutlier(totalDiffNoCancer,'mean'));
end

% plot(1:length(totalDiffCancer),totalDiffCancer,'r',...
%     1:length(totalDiffNoCancer),totalDiffNoCancer,'g')

% hold on
% scatter(totalDiffCancer,2*ones(size(totalDiffCancer)),'r')
% scatter(totalDiffNoCancer,ones(size(totalDiffNoCancer)),'g')
% % xlim([-.05 .05])
% ylim([.5 2.5])
% hold off

figure(2)
subplot(1,2,1)
statsCancer=DispersionAnalysis(totalDiffCancer,'Normplot');
title('Normal prob. plot of data of patients with cancer')
xlabel('\DeltaPSA/day for first to last measurement')

subplot(1,2,2)
statsNoCancer=DispersionAnalysis(totalDiffNoCancer,'Normplot');
title('Normal prob. plot of data of patients without cancer')
xlabel('\DeltaPSA/day for first to last measurement')

