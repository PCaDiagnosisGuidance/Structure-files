%get the number of medical examinations and the order of the treatments

%read the dataset
data=DataReadOut('C:\Users\s169977\Desktop\OGO 5 computational biology\OGO groep 5');

maximumID=max(data.ID);
patientDates=zeros(maximumID, 100);
NrOfDetections=zeros(maximumID, 1);

%create a matrix of the dates a examination is done per patientnumber (one
%row = one patient)
for i=1:maximumID
    DateNr=find(data.ID==i);
    NrOfDetections(i)=length(DateNr);
    dates=sort(data.date(DateNr)');
    patientDates(i, 1:length(dates))=dates;
end

%find how many examinations are done per patient
maxNrOfDetections=max(NrOfDetections);
TotalDetections=zeros(maxNrOfDetections, 1);
for i=1:maxNrOfDetections
   TotalDetections(i)=length(find(NrOfDetections==i));
end

%plot the number of examinations done in general
bar(TotalDetections)
xlabel('number of medical examinations done on the patient')
ylabel('number of times a patient this many examinations')


    