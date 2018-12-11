function [statsStruct,statsArray]=DispersionAnalysis(input,varargin)
statsStruct.size=length(input);
statsStruct.mean=mean(input);
statsStruct.std=std(input);
statsStruct.iqr=iqr(input);
statsStruct.kurtosis=kurtosis(input);
statsStruct.skewness=skewness(input);

statsArray=[statsStruct.size; statsStruct.mean; statsStruct.std; statsStruct.iqr; statsStruct.kurtosis; statsStruct.skewness];

if strcmp(varargin,'Normplot')
    normplot(input)
    statType={'size dataset: ','mean: ','std: ','iqr: ','kurtosis: ','skewness: '};
    text(.02,.85,statType,'Units','normalized')
    text(.25,.85,num2str(statsArray),'Units','normalized')
end

end