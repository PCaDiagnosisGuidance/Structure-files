%Voert analyse uit op dataset input en geeft de grootte van de dataset, het
%gemiddelde, de standaarddeviatie, de iqr, de Kurtosis waarde (tailedness)
%en skewness (assymetrie) terug als output. De plot is standaard en vereist
%geen 'Normplot' als tweede input meer.

function [statsStruct,statsArray]=DispersionAnalysis(input,varargin)
statsStruct.size=length(input);
statsStruct.mean=mean(input);
statsStruct.std=std(input);
statsStruct.iqr=iqr(input);
statsStruct.kurtosis=kurtosis(input);
statsStruct.skewness=skewness(input);

statsArray=[statsStruct.size; statsStruct.mean; statsStruct.std; statsStruct.iqr; statsStruct.kurtosis; statsStruct.skewness];

normplot(input)
    statType={'size dataset: ','mean: ','std: ','iqr: ','kurtosis: ','skewness: '};
    text(.02,.85,statType,'Units','normalized')
    text(.25,.85,num2str(statsArray),'Units','normalized')

% if strcmp(varargin,'Normplot')
%     normplot(input)
%     statType={'size dataset: ','mean: ','std: ','iqr: ','kurtosis: ','skewness: '};
%     text(.02,.85,statType,'Units','normalized')
%     text(.25,.85,num2str(statsArray),'Units','normalized')
% end

end