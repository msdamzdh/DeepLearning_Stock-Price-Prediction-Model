a = exist("Data","var");
if a==0
    LoadData
end
clearvars -except Data
clc
data=table2array(Data);
%%
malen = 0;
delay = 200;
Pr = data(:,4);
High = data(:,2);
Low = data(:,3);
start = malen+1;
Len = 200;
feature = 1:4;
%%
horizon = 100;
nfeature = numel(feature);
InputsInd = [start:start+delay-1]'+[1:Len];
OutputsInd = InputsInd(end,:)+[1:horizon]';
InputData = zeros(nfeature,delay,size(InputsInd,2));
OutputPic = zeros(nfeature,horizon,size(OutputsInd,2));
counter = 1;
for i=feature
    a = data(:,i);
    InputData(counter,:,:) = a(InputsInd);
    OutputPic(counter,:,:) = a(OutputsInd);
    counter=counter+1;
end
nout = 2;
OutputData=zeros(Len,nout);
for j=1:Len
    [~,edges] = histcounts(OutputPic(:,:,j),10);
%     edges
    OutputData(j,1) = (edges(1)+edges(2))/2;
    OutputData(j,2) = (edges(end-1)+edges(end))/2;
end
szi = size(InputData);
InputData = reshape(InputData,szi(1),szi(2),1,szi(3));
%% Split Train and Validation data
TrInd = 1:floor(0.9*Len);
ValInd = max(TrInd)+1:Len;
TrInData = InputData(:,:,:,TrInd); TrOutData = OutputData(TrInd,:);
ValInData = InputData(:,:,:,ValInd); ValOutData = OutputData(ValInd,:);
%%
LG8
%%
options = trainingOptions("adam",...
    'MaxEpochs',100,...
    'InitialLearnRate',0.01,...
    "Shuffle","every-epoch","GradientDecayFactor",0.8,...
    Verbose=true,...
    Plots='training-progress',...
    MiniBatchSize=30,...
    VerboseFrequency=10,...
    Shuffle='every-epoch',...
    ValidationData={ValInData,ValOutData},...
    OutputNetwork='best-validation-loss');
%%
net = trainNetwork(TrInData,TrOutData,lgraph,options);
%%
predict_val = predict(net,ValInData);
%%
plotSeries(predict_val(index,:),ValOutData(index,:))