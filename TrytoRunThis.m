clc ; clear all;    %addpath('fcm')
%import datasets Initializition
disp('******************TDT2_all.mat******************');
%disp('******************English_Corpus_TFIDF  Reuters21578.mat************');
load('Corpus\TDT2_all.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
%load('Corpus\Reuters21578.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
%load('Corpus\20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea);
fea = fea';  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using PCA in the original feature space
tic;
t0 = cputime;
[z_pc varargout] = myPCA(fea,nClass);
time = cputime-t0;
time
label = kmeans1(z_pc,nClass);
label = bestMap(gnd,label);
MIhat(10) = MutualInfo(gnd,label);
AC(10) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the PCA space normalized mutual information:',num2str(MIhat(10))]);
disp(['Kmeans in the PCA space accuracy:',num2str(AC(10))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using Kmeans in the original feature space
%%
tic;
label = kmeans1(fea,nClass);
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the originall space normalized mutual information:',num2str(MIhat(1))]);
disp(['Kmeans in the original space accuracy:',num2str(AC(1))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NMF Lee, Daniel D., and H. Sebastian Seung. "Algorithms for non-negative matrix factorization." 
%data clustering in the paper NMF mult update algorithm  reduced feature space
tic;
[U,V] = NMF(fea,nClass,200);
%data clustering using V Matrix from NMF (i.e using reduced feature space)
label = kmeans1(V,nClass); 
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(3) = MutualInfo(gnd,label);
AC(3) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Lee, Daniel NMF space normalized mutual information:',num2str(MIhat(3))]);
disp(['Kmeans in the Lee, Daniel NMF space accuracy:',num2str(AC(3))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matlab nnmf Algotihm MU
%%%%%%%%%%%%%%%%%%%%%      Matlab NMF Als Algorithm   %%%%%%%%%%%%%%%%%%%%%
tic;
opt = statset('Maxiter',200);
t0 = cputime;
[U,V] = nnmf(fea,nClass,'options',opt,'algorithm','als');  %'mult');  mult algorithm gives bad results 0.17
time = cputime-t0;
time
%data clustering using V Matrix from NMF (i.e using reduced feature space)
label = kmeans1(V,nClass); 
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(4) = MutualInfo(gnd,label);
AC(4) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in Matlab nnmf space normalized mutual information:',num2str(MIhat(4))]);
disp(['Kmeans in Matlab nnmf  space accuracy:',num2str(AC(4))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering  using gdcls algorithm
tic;
maxiter=200;lambda=0.5;options='nonneg';
t0 = cputime;
[U V] = gdcls(fea,nClass, maxiter, lambda, options);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(6) = MutualInfo(gnd,label);
AC(6) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the GDLC NMF space normalized mutual information:',num2str(MIhat(6))]);
disp(['Kmeans in the GDLC NMF space accuracy:',num2str(AC(6))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%nmfOrtho Algorithm
tic;
t0 = cputime;
[U,V] =  nmfOrtho(fea,nClass,200);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(7) = MutualInfo(gnd,label);
AC(7) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Orthognal NMF space normalized mutual information:',num2str(MIhat(7))]);
disp(['Kmeans in the Orthognal NMF space accuracy:',num2str(AC(7))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering  using nmf_euc_orth 05
tic;
[U,V,errs] = nmf_euc_orth05(fea,nClass,200);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(8) = MutualInfo(gnd,label);
AC(8) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the nmf_euc_orth05 space normalized mutual information:',num2str(MIhat(8))]);
disp(['Kmeans in the nmf_euc_orth05 space accuracy:',num2str(AC(8))]);
toc;
%%%%%%%%%%%%%%%%%%%%%   Orthognal Algorithm    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[U,V] = ORNMF(fea,nClass,200);
%data clustering using V Matrix from NMF (i.e using reduced feature space)
label = kmeans1(V,nClass); 
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(9) = MutualInfo(gnd,label);
AC(9) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the ORNMF space normalized mutual information:',num2str(MIhat(9))]);
disp(['Kmeans in the ORNMF space accuracy:',num2str(AC(9))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using PCA in the original feature space
tic;
t0 = cputime;
[z_pc varargout] = myPCA(fea,nClass);
time = cputime-t0;
time
label = kmeans1(z_pc,nClass);
label = bestMap(gnd,label);
MIhat(10) = MutualInfo(gnd,label);
AC(10) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the PCA space normalized mutual information:',num2str(MIhat(10))]);
disp(['Kmeans in the PCA space accuracy:',num2str(AC(10))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data clustering using PCA in the original feature space
%tic;
%t0 = cputime;
%[coeff,score,pcvar,mu] = pca(fea,'algorithm','svd','NumComponents',nClass);
%time = cputime-t0;
%time
%label = kmeans1(coeff',nClass);
%label = bestMap(gnd,label);
%MIhat(10) = MutualInfo(gnd,label);
%AC(10) = length(find(gnd == label))/length(gnd);
%disp(['Kmeans in the PCA space normalized mutual information:',num2str(MIhat(10))]);
%disp(['Kmeans in the PCA space accuracy:',num2str(AC(10))]);
%toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ONPMF Algorithm
tic;
t0 = cputime;
[U,V,relError,actualIters] = onpmf(fea,nClass,200);%(M,numClusters,maxOnpmfIters);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(11) = MutualInfo(gnd,label);
AC(11) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Two Orthognal NMF space normalized mutual information:',num2str(MIhat(11))]);
disp(['Kmeans in the Two Orthognal NMF space accuracy:',num2str(AC(11))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code was token from the following paper
%Michael.W,Murrar.B, "Algorithms and Application for Approximate Non-Negative
%Matrix factorization"
%%Constrain a=0.1;B=0.0; Algorithm CNMF
tic;
a=0.01;B=0;
[U,V] = CNMF(fea,nClass,200,a,B);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(12) = MutualInfo(gnd,label);
AC(12) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in CNMF space normalized mutual information:',num2str(MIhat(12))]);
disp(['Kmeans in CNMF space accuracy:',num2str(AC(12))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code was token from the following paper
%Srilakshmi.I,Veerraju.G, "Image compression using Constrained Non-Negative
%Matrix factorization"
%%Constrain x=0.01; Algorithm CNMF02
tic;
x=0.01;
[U,V] = CNMF02(fea,nClass,200,x);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(13) = MutualInfo(gnd,label);
AC(13) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the CNMF02 space normalized mutual information:',num2str(MIhat(13))]);
disp(['Kmeans in the CNMF02 space accuracy:',num2str(AC(13))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%multconv Algorithm
tic;
timelimit=100;maxiter=200;
[W,H,iter] = multconv(fea,nClass,timelimit,maxiter);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(14) = MutualInfo(gnd,label);
AC(14) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the multconv NMF space normalized mutual information:',num2str(MIhat(14))]);
disp(['Kmeans in the multconv NMF space accuracy:',num2str(AC(14))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Data clustering  using nmfHeasun
tic;
t0 = cputime;
[U,V] = nmfHeasun(fea,nClass,'type','sparse');
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(V,nClass); 
label = bestMap(gnd,label);
MIhat(15) = MutualInfo(gnd,label);
AC(15) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Heasun NMF space normalized mutual information:',num2str(MIhat(15))]);
disp(['Kmeans in the Heasun NMF space accuracy:',num2str(AC(15))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%the NMFNNSVD space
tic;
[U,V] = nmf_NNSVD ( fea,nClass,200);
label = kmeans1(V,nClass);
label = bestMap(gnd,label);
MIhat(16) = MutualInfo(gnd,label);
AC(16) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the NMFNNSVD space normalized mutual information:',num2str(MIhat(16))]);
disp(['Kmeans in the NMFNNSVD space accuracy:',num2str(AC(16))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using SVD
tic;
t0 = cputime;
%[U S V] = svd(fea,'econ');%(fea,'econ');
[U S V] = svds(fea,nClass);
% find number of nonzero singular value = rank(A)
%r = length(find(diag(S)))
Uhat = U(:,1:nClass);
Shat = S(1:nClass,1:nClass);
Vhat = V(:,1:nClass);
X=Uhat*Shat*Vhat';
% compute squared error
    errs= sum(sum((X-fea).^2))
%data clustering using S*V' Matrix from SVD (i.e using reduced feature space)
D=(Shat*Vhat');
time = cputime-t0;
time
%%
label = kmeans1(D,nClass); 
label = bestMap(gnd,label);
MIhat(17) = MutualInfo(gnd,label);
AC(17) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in Matlab SVD space normalized mutual information:',num2str(MIhat(17))]);
disp(['Kmeans in Matlab SVD  space accuracy:',num2str(AC(17))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%nmf_kl_mua Algorithm
tic;
maxiter=200;
[W, H, obj, time] = nmf_kl_mua(fea,nClass, maxiter);
%data clustering using H Matrix from nmf_kl_mua (i.e using reduced feature space)
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(5) = MutualInfo(gnd,label);
AC(5) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the nmf_kl_mua NMF space normalized mutual information:',num2str(MIhat(5))]);
disp(['Kmeans in the nmf_kl_mua NMF space accuracy:',num2str(AC(5))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%*************************************************************************
disp('AC1   AC2   AC3    AC4   AC5   AC6   AC7  AC8  AC9  AC10  AC11  AC12  AC13  AC14 AC15');
disp([num2str(AC(1)),num2str(AC(2)),num2str(AC(3)),num2str(AC(4)),num2str(AC(5)),num2str(AC(6)),...
      num2str(AC(7)),num2str(AC(8)),num2str(AC(9)),num2str(AC(10)),num2str(AC(11)),num2str(AC(12)),...
      num2str(AC(13)),num2str(AC(14)),num2str(AC(15)),num2str(AC(16)),num2str(AC(17))]);
disp('MIhat1   MIhat2   MIhat3    MIhat4   MIhat5   MIhat6  MIhat7 MIhat8 MIhat9 MIhat10  MIhat11 MIhat12 MIhat13 MIhat14 MIhat15');
disp([num2str(MIhat(1)),num2str(MIhat(2)),num2str(MIhat(3)),num2str(MIhat(4)),num2str(MIhat(5)),num2str(MIhat(6)),...
      num2str(MIhat(7)) ,num2str(MIhat(8)),num2str(MIhat(9)),num2str(MIhat(10)),num2str(MIhat(11)),num2str(MIhat(12)),...
      num2str(MIhat(13)),num2str(MIhat(14)),num2str(MIhat(15)), num2str(MIhat(16)),num2str(MIhat(17))]);
%%*************************************************************************
%save('Final_Results016.mat','AC','MIhat');
%%*************************************************************************
return
%%*************************************************************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%the NMF_SVD intialized space
%[U,V] = nmf_NewI_SVD ( fea,nClass,200);
%label = kmeans1(V,nClass);
%label = bestMap(gnd,label);
%MIhat(15) = MutualInfo(gnd,label);
%AC(15) = length(find(gnd == label))/length(gnd);
%disp(['Kmeans in the NMFNNSVD space normalized mutual information:',num2str(MIhat(15))]);
%disp(['Kmeans in the NMFNNSVD space accuracy:',num2str(AC(15))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% data clustering in the original feature space
%label = kmeans1(fea,nClass);
%Matlab kmedoids
%[label, C, SUMD, D, MIDX, INFO] = kmedoids(fea',nClass,'distance','cosine','replicates',3);
%Matlab kmeans
%[label,C]=kmeans(fea',nClass,'MaxIter',500);
%Matlab kmeans By using Options
% 'Distance' Distance measure
% 'sqeuclidean' (default) | 'cityblock' | 'cosine' | 'correlation' | 'hamming'
% Distance measure, in p-dimensional space, used for minimization, specified as the comma-separated
% pair consisting of 'Distance' and a string.
% kmeans computes centroid clusters differently for the different, supported distance measures.
%opts = statset('Display','final');
%[label,C] = kmeans(fea',nClass,'MaxIter',100,'Distance','cosine',...
%   'Replicates',1,'Options',opts);
%figure
%[silh10,h] = silhouette(fea',label,'city');
%h = gca;
%h.Children.EdgeColor = [.8 .8 1];
%xlabel 'Silhouette Value'
%ylabel 'Cluster'
%mean(silh10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Matlab kmeans & my evaluating
%[label,C]=kmeans(fea',nClass,'MaxIter',100);
%[Reslabel GM]=similarty(C,fea',gnd);
%AC1 = length(find(gnd == Reslabel))/length(gnd);
%disp(['Kmeans in the original space My kmeans accuracy Measurement:',num2str(AC1)]);
%%%
%M = crosstab(gnd,label); % you can use also use "confusionmat"
%nc = sum(M,1);
%mc = max(M,[],1);
%purity = sum(mc(nc>0))/sum(nc);
%disp(['Kmeans Cluster in the original space Purity:',num2str(purity)]);
%%%%%%%
%[AR,RI,MI,HI]=RandIndex(gnd,label);
%disp(['The adjusted Rand index Kmeans in the original space :',num2str(AR)]);
%disp(['The Rand index Kmeans in the original space :',num2str(RI)]);
%"Mirkin's" index and "Hubert's" index
%==========================================================================
%%
%[label3,C]=kmeans(V',nClass,'MaxIter',100);
%[Reslabel GM]=similarty(C,V',gnd);
%AC2 = length(find(gnd == Reslabel))/length(gnd);
%disp(['Kmeans in the original space My NMF accuracy Measurement:',num2str(AC2)]);
%==========================================================================
%%
%M = crosstab(gnd,label); % you can use also use "confusionmat"
%nc = sum(M,1);
%mc = max(M,[],1);
%purity = sum(mc(nc>0))/sum(nc);
%disp(['Kmeans Cluster in the NMF space Purity:',num2str(purity)]);
%%%%%%%
%[AR,RI,MI,HI]=RandIndex(gnd,label);
%disp(['The adjusted Rand index Kmeans in the NMF space :',num2str(AR)]);
%disp(['The Rand index Kmeans in the NMF space :',num2str(RI)]);
%"Mirkin's" index and "Hubert's" index
%clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%X=[
%       1    2    3   4  ;
%       5    6    7   8  ;
%       9    10   11  12 ;
%       13   14   15  16 ;
%       17   18   19  20
%          ];
%nClass=4;      
%[U,V] = nmf_NewI_SVD ( X,nClass,50);
%A= U*V
%Error=norm(A-X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fea=[
%       1    2    3   4  6 7;
%       5    6    7   8  3  8;
%       9    10   11  12  4 22;
%       13   14   15  16  11  33;
%       17   18   19  20  21 11;
%       11   12   23  45  67 23
%          ];
%nClass=3;      
%gnd=[1 1 1 2 2 3]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%