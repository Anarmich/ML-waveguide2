clearvars
Paths = {'2_20','3_20','4_20';'2_30',...
    '3_30','4_30';'2_40','3_40',...
    '4_40';'2_50','3_50','4_50'};
for i = 1:size(Paths,1)
    for j = 1:size(Paths,2)

addpath(Paths{i,j})
load net.mat

R1(i,j) = regression(targets(1,tr.testInd),outputs(1,tr.testInd));
R2(i,j) = regression(targets(2,tr.testInd),outputs(2,tr.testInd));

Pideal_target = find(targets(1,tr.testInd)>0.2 & targets(2,tr.testInd)>1);
% find(targets(2,tr.testInd)>1)
Pideal_output = find(outputs(1,tr.testInd)>0.2 & outputs(2,tr.testInd)>1);
TP_set = intersect(Pideal_target,Pideal_output);
TP(i,j) = size(TP_set,2);
FN(i,j) = size(Pideal_target,2) - size(TP_set,2);
FP(i,j) = size(Pideal_output,2) - size(TP_set,2);
TN(i,j) = size(targets(1,tr.testInd),2) - TP(i,j) - FN(i,j) - FP(i,j);
    end
end
Sensitivity = (TP./(TP+FN))';
Specificity = (TN./(TN+FP))';
Precision = (TP./(TP+FP))';
plotregression(targets(1,tr.testInd),outputs(1,tr.testInd))
view(net)
TP+FN+TN+FP
