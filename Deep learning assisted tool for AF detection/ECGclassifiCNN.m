clear all;
Data=xlsread('normalized_labeled.xlsx');
c=cvpartition(1448,'kfold',9);
 for i = 1:c.NumTestSets
     tridx = c.training(i);
    teidx = c.test(i);
 end
trlength=size(find(tridx==1));
telength=size(find(teidx==1));
ind1=find(tridx==1);
ind2=find(teidx==1);
trainlabel=categorical(Data(ind1(1:length(ind1)),[1]));
testlabel=(Data(ind2(1:length(ind2)),[1]));
CAN=length(find(testlabel ==1));
CAF=length(find( testlabel==2));
CAO=length(find( testlabel==3));
testlabel=categorical(Data(ind2(1:length(ind2)),[1]));
trainData=Data(ind1(1:length(ind1)),[2:197]);
testData=Data(ind2(1:length(ind2)),[2:197]);

[m,n]=size(trainData);
[m1,n1]=size(testData);
 
%trainData=[trainData,randi([min(min(trainData)),max(max(trainData))],m,16375)];
%testData=[testData,randi([min(min(testData)),max(max(testData))],m1,16375)];
 
for i=1:m
    
    im_trainData(:,:,1,i)=reshape(trainData(i,:),14,14);
end
 
for i=1:m1
    im_testData(:,:,1,i)=reshape(testData(i,:),14,14);
end
 
XTrain=im_trainData;
YTrain=trainlabel;

 layers = [
        imageInputLayer([14 14 1])
        convolution2dLayer(12,12,'Padding','same')
        reluLayer                %activation
        maxPooling2dLayer(2,'Stride',2)
        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer];

    options = trainingOptions('adam', ...
    'MaxEpochs',150, ...
    'ValidationData',{XTrain,YTrain}, ...
    'ValidationFrequency',25, ...
    'Verbose',false, ...
    'Plots','training-progress');
        net = trainNetwork(XTrain, YTrain, layers, options);
 
XTest=im_testData;
YTest=testlabel;        
 
        YPred = classify(net, XTest);
        accuracy = sum(YTest == YPred)/numel(YTest)
        c=confusionchart(testlabel,YPred)
 c.Title = 'ECG Classification  Using CNN';
 c.RowSummary = 'row-normalized'
 c.ColumnSummary = 'column-normalized'
 C = confusionmat(testlabel,YPred)
 CA_per=[]; 
CA_per(1)=C(1,1)/CAN*100       
CA_per(2)=C(2,2)/CAF*100                 
CA_per(3)=C(3,3)/CAO*100


CA_per(4)=(C(1,1)+C(2,2)+C(3,3))/ length(YPred)*100
