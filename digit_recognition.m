clear all

testFolder = 'audio';
testFiles=dir(fullfile(testFolder,'*.wav'));
numFiles=length(testFiles);

output=cell(numFiles,2);

load('trained_data.mat');

for i=1:numFiles
    [x,fs]=audioread(fullfile(testFolder,testFiles(i).name));
    
    % PSD (Yule-Walker method) for PEAKS:
    
    order=12;
    nfft=512;

    [psd_values,psd_freq]=pyulear(x,order,nfft,fs);
    psd_values=psd_values(:,1);
    
    MAX_PEAKS_PDS=zeros(1,2);
    
    [peakes,positions]=findpeaks(psd_values);
    mat_peakes=[peakes,positions];
    mat_peakes_sorted=sortrows(mat_peakes,'descend');
    MAX_PEAKS_PDS(1,:)=mat_peakes_sorted(1:2,2)';
    
    % SPECTRAL CENTROID

    abs_x=abs(x);
    normalized_spectrum=abs_x/sum(abs_x);
    normalized_frequencies=linspace(0,1,length(abs_x));
    SPECTRAL_CENTROID=sum(normalized_frequencies*normalized_spectrum);

    % ZERO CROSSING

    ZERO_CROSSING=0;
    for k=2:length(x)
        if x(k)*x(k-1)<0
            ZERO_CROSSING=ZERO_CROSSING+1;
        end
    end
    
    FEED=[SPECTRAL_CENTROID,ZERO_CROSSING,MAX_PEAKS_PDS];

    yfit = trainedModel.predictFcn(FEED); 
    class=yfit;    
    
    output(i,1)={testFiles(i).name};
    output(i,2)={class};
end

