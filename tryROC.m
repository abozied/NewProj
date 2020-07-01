clear all; clc;
%load simplecluster_dataset
%net = patternnet(20);
%net = train(net,simpleclusterInputs,simpleclusterTargets);
%simpleclusterOutputs = sim(net,simpleclusterInputs);
%plotroc(simpleclusterTargets,simpleclusterOutputs);
load iris_dataset
net = patternnet(20);
net = train(net,irisInputs,irisTargets);
irisOutputs = sim(net,irisInputs);
[tpr,fpr,thresholds] = roc(irisTargets,irisOutputs);

figure (1)
plotroc(irisTargets,irisOutputs);
figure(2)
plotconfusion(irisTargets,irisOutputs);

load fisheriris;
pred = meas(51:end,1:2);
resp = (1:100)'>50;  % Versicolor = 0, virginica = 1
mdl = fitglm(pred,resp,'Distribution','binomial','Link','logit');
scores = mdl.Fitted.Probability;
[X,Y,T,AUC] = perfcurve(species(51:end,:),scores,'virginica');
figure(3)
plot(X,Y);
xlabel('False positive rate');
ylabel('True positive rate');
title('ROC for Classification by NN');
AUC