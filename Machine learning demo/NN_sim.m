clear all
load('Measure.mat')
inputs = input_para1;
targets = Output_para;
 
% Create a Fitting Network
hiddenLayerSize = [20 20];
net = fitnet(hiddenLayerSize);
% net.layers{size(hiddenLayerSize,2)}.transferFcn = 'poslin';
net.performParam
net.performParam.Normalization = 'standard';
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 50/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 35/100;

net.layers{1:size(hiddenLayerSize,2)}.transferFcn = 'poslin';
% net.layers{2}.transferFcn = 'poslin';
% net.layers{3}.transferFcn = 'poslin';
% net.layers{4}.transferFcn = 'poslin';
% net.layers{5}.transferFcn = 'poslin';
% net.layers{6}.transferFcn = 'poslin';

% Train the Network
[net,tr] = train(net,inputs,targets);
 
% Test the Network
outputs = net(inputs);
max = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)

% View the Network
view(net)
save net
% Generate Function
genFunction(net)
%%
figure(1)

R = regression(targets(1,tr.testInd),outputs(1,tr.testInd));
plotregression(targets(1,tr.testInd),outputs(1,tr.testInd))
title(['Transmissibility',newline,'R = ',num2str(R)])
%%
figure(2)
R = regression(targets(2,tr.testInd),outputs(2,tr.testInd));
plotregression(targets(2,tr.testInd),outputs(2,tr.testInd))
title(['Log nonreciprocity',newline,'R = ',num2str(R)])
