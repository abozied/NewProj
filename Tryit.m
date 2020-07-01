clc;clear;
% import datasets
disp('Ash900_TFIDF DataSet');
load('Corpus\Ash900_TFIDF.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea);
%fea = fea';
X=fea;
%% 
% Group data into two clusters using |kmedoids|. Use the |cityblock|
% distance measure.
opts = statset('Display','iter');
[idx,C,sumd,d,midx,info] = kmedoids(X,nClass,'Distance','cityblock','Options',opts);

%%
% |info| is a struct that contains information about how the algorithm was
% executed. For example, |bestReplicate| field indicates the replicate that
% was used to produce the final solution. In this example, the replicate
% number 1 was used since the default number of replicates is 1 for the
% default algorithm, which is |pam| in this case.
info 
%%
% Plot the clusters and the cluster medoids.
figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',7)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',7)
plot(C(:,1),C(:,2),'co',...
     'MarkerSize',7,'LineWidth',1.5)
legend('Cluster 1','Cluster 2','Medoids',...
       'Location','NW');
title('Cluster Assignments and Medoids');
hold off