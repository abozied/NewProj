clear all
clc
disp('Arabic_Corpus_TFIDF_20 DataSet');
load('Corpus\Arabic_Corpus_TFIDF_20.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea);
fea = fea';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[W,H,Q, Vhat] = betaNTF(fea,nClass,'nIter',10,'beta',1);
% Reconstruct your data using:
%   for j = 1:I,  Vhat(:,:,j) = W * diag(Q(j,:)) * H'; end
%--------------------------------------------------------------------------
%                                 Antoine Liutkus, Inria, 2015

%data clustering using V Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass); 
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(3) = MutualInfo(gnd,label);
AC(3) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the NTF space normalized mutual information:',num2str(MIhat(3))]);
disp(['Kmeans in the NTF space accuracy:',num2str(AC(3))]);
toc;
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
c = nClass;
metric = @euclidean;
m = 1.5;
Max = 1000;
tol = 1e-3;
X=fea';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data Normalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nr nc] = size(X);
size(gnd)
nr
for i = 1:nc
    xstd=std(X(:, i));xmean=mean(X(:, i));
   for j = 1:nr
     data(j, i) = (X(j, i)-xstd)/xmean;
   end
end
% data clustering using Cmean in the original feature space
%***************FCM************************
[prediction,v] = fcm(c, data, m, metric, Max, tol);
%v
label = prediction;
label = bestMap(gnd,label);
MIhat(25) = MutualInfo(gnd,label);
AC(25) = length(find(gnd == label))/length(gnd);
disp(['Cmean in the originall space normalized mutual information:',num2str(MIhat(25))]);
disp(['Cmean in the original space accuracy:',num2str(AC(25))]);
toc;
