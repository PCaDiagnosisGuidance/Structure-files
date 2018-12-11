[AllValuesperMRI, methodsperMRI]=findDataPerMRI();
psa_value=zeros(13939, 1);

for i=1:size(methodsperMRI, 1);
    psa_index=find(methodsperMRI(i, :)==1, 1, 'first');
    if length(psa_index)>0
        psa_value(i, 1:length(psa_index))=AllValuesperMRI(i, psa_index);
    else
        psa_value(i, 1)=0;
    end
        
    mri_index=find(methodsperMRI(i, :)==2, 1, 'first');
    if length(mri_index)>0
        mri_value(i, 1:length(mri_index))=AllValuesperMRI(i, mri_index);
    else
        mri_value(i, 1)=0;
    end

    biopt_index=find(methodsperMRI(i, :)==3, 1, 'first');
    if length(biopt_index)>0
        biopt_value(i, 1:length(biopt_index))=AllValuesperMRI(i, biopt_index);
    else
        biopt_value(i, 1)=0;
    end
    
    echo_index=find(methodsperMRI(i, :)==4, 1, 'first');
    if length(echo_index)>0
        echo_value(i, 1:length(echo_index))=AllValuesperMRI(i, echo_index);
    else
        echo_value(i, 1)=0;
    end
end

figure;
subplot(3, 2, 1)
    scatter(mri_value, psa_value);
    xlabel('mri value'); ylabel('psa value')
subplot(3, 2, 2)
    scatter(mri_value, biopt_value);
        xlabel('mri value'); ylabel('biopt value')
subplot(3, 2, 3)
    scatter(mri_value, echo_value);
        xlabel('mri value'); ylabel('echo value')
subplot(3, 2, 4)
    scatter(psa_value, echo_value);
        xlabel('psa value'); ylabel('echo value')
subplot(3, 2, 5)
    scatter(psa_value, biopt_value);
        xlabel('psa value'); ylabel('biopt value')
subplot(3, 2, 6)
    scatter(echo_value, biopt_value);
        xlabel('echo value'); ylabel('biopt value')

