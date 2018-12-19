function varargout=RemoveOutliers(varargin)
varargout=cell(size(varargin));
for n=1:length(varargin)
    varargout{n}=varargin{n}(~isoutlier(varargin{n},'mean'));
end