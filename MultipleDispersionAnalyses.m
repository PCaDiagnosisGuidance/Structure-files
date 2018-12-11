function datasetStruct=MultipleDispersionAnalyses(varargin)

datasetCount=length(varargin);

datasetStruct=zeros(datasetCount,6);

for i=1:datasetCount
    subplot(1,datasetCount,i)
    [~,datasetStruct(i,:)]=DispersionAnalysis(varargin{i});
end
end