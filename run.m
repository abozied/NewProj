clc ; clear all;    %addpath('fcm')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('********English_Corpus_TFIDF Reuters21578.mat 10 Classes ********');
%('20NewsHome.mat');%('Reuters21578.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
load('Corpus\Reuters21578.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea);
fea2 = fea';  
gnd2=gnd;
nClass2 =nClass ;
fea=fea2(:,1:7293); %(:,1:7284);
gnd=gnd2(1:7293,:); %(1:7284,:);
nClass = length(unique(gnd));
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('******************Arabic_Corpus_TFIDF_10 DataSet******************');
%load fea which is the document_term matrix and gnd is classified label for all documents
%load('Corpus\Arabic_Corpus_TFIDF_20.mat');
%nClass = length(unique(gnd));
%fea = NormalizeFea(fea); %Normalize each row of fea matrix
%fea2 = fea';  % transpose fea matrix to get term_document matrix 
%gnd2=gnd;
%nClass2 =nClass ;
%fea=fea2(:,1:7232); % get only 7232 documents of all corpus term_document matrix
%gnd=gnd2(1:7232,:); % get 7232 labels
%nClass = length(unique(gnd)); % get # of classes in these documents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Acc=0;Mii=0;tt=0;
for i = 1:10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    000000  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['Loop # :  ',num2str(i)]);
%%%
% data clustering using K-means in the original feature space
%tic;
%label = kmeans1(fea,nClass);
%%%
%maxiter=200;
%[W,H] = NMF(fea,nClass,maxiter);
%tic
%label = kmeans1(H,nClass);
%%
%maxiter=200;
%[W, H] = kl_mua(fea,nClass, maxiter);
%tic
%label = kmeans1(H,nClass);
%%
%The code was token from the following paper
%Srilakshmi.I,Veerraju.G, "Image compression using Constrained Non-Negative Matrix factorization"
%%Constrain x=0.01; Algorithm CNMF02
%maxiter=200;
%xConstrain=0.01;
%[W,H] = CNMF02(fea,nClass,maxiter,xConstrain);
%tic;
%label = kmeans1(H,nClass); 
%%
%Document clustering using nonnegative matrix factorization by Farial Shahnaz
%This hybrid algorithm is denoted by GD-CLS(gradient descent with constrained least squares) in (Pauca et al., 2004).
maxiter=200;lambda=0.5;options='nonneg';
[W H] = gdcls(fea,nClass, maxiter, lambda, options);
tic;
label = kmeans1(H,nClass); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%timelimit=200;maxiter=200;
%[W,H,iter] = multconv(fea,nClass,timelimit,maxiter);
%maxiter=200;
%[W, H, obj, time] = nmf_kl_mua(fea,nClass, maxiter);
%%%
%[z_c  , mean_z ]=AshCenter(fea);
%[Ux Sx Vx] = svds(z_c' , nClass);
% the Projection of Vx on the matrix data set fea
%z_pc=(Vx'*fea);
%Normalize variances to 1
%[z_pc T] = myWhiten(z_pc);
%H=z_pc;
%tic;
%label = kmeans1(H,nClass);
%%%{
%[U S V] = svds(fea,nClass);
%Uhat = U(:,1:nClass);
%Shat = S(1:nClass,1:nClass);
%Vhat = V(:,1:nClass);
%H=(Shat*Vhat');
%tic;
%label = kmeans1(H,nClass);
%%%
%opts = statset('Display','final');
%tic;
%[idx,C] = kmeans(H',nClass,'Distance','cosine','Replicates',5,'Options',opts);
%idx = kmeans1(H,nClass);
%%
% Version 2.0, by Yi Cao at Cranfield University on 27 March 2008.
%[idx, ctrs] = k_means(H',nClass);
%%
%tic;
% run k-Means on Text data
%  ITER=300; TOL=0.0001;
    %[C, idx, iter] = my_Kmeans(H',nClass, ITER, TOL);
    %[C, idx, iter] = Ash_Kmeans(H',nClass, ITER, TOL);
%%
%[idx,C] = kmeans(H',nClass,'Distance','correlation','Replicates',5,'Options',opts);
%[idx,C] = kmeans(H',nClass,'Distance','sqeuclidean','Replicates',5,'Options',opts);
%[idx,C] = kmeans(H',nClass,'Distance','cityblock','Replicates',5,'Options',opts);
%%
%%%
%Center the input data
%tic;
%t0=cputime;
%[z_c  , mean_z ] = myCenter(fea);
%%
%%Using the matlab Eigen decomposition method to derive PCA
%[z_c  , mean_z ]=AshCenter(fea);
%[V1,D1] = eig(z_c'*z_c);
%[d,ind] = sort(diag(D1),'descend');
%Ds = D1(ind,ind);
%Vs = V1(:,ind);
%Vs1 = Vs(:,1:nClass)';
%tic;
%label = kmeans1(Vs1,nClass);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Using the matlab SVD decomposition method to derive PCA  from Data
%%%%Analysis for Biologist Lecture
%SVD --> partial SVD rank-k to the input matrix fea. 
%[z_c  , mean_z ]=AshCenter(fea);
%[Ux Sx Vx] = svds(z_c' , nClass);
% the Projection of Vx on the matrix data set fea
%z_pc=(Vx'*fea);
%Normalize variances to 1
%[z_pc T] = myWhiten(z_pc);
%%[z_pc] = AshWhiten(z_pc);
%tic;
%label = kmeans1(z_pc,nClass);
%%%%%SVD Clustering
%[U S V] = svds(fea,nClass);
%Uhat = U(:,1:nClass);
%Shat = S(1:nClass,1:nClass);
%Vhat = V(:,1:nClass);
%D=(Shat*Vhat');
%tic;
%label = kmeans1(D,nClass); 
%%NMF Clustering
%[W,H] = NMF(fea,nClass,200);
%tic;
%label = kmeans1(H,nClass);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Using the matlab SVD decomposition method to derive PCA
%SVD --> partial SVD rank-k to the input matrix fea. 
%[z_c  , mean_z ]=AshCenter(fea);
%[Ux Sx Vx] = svds(z_c , nClass);
% the Projection of Ux on the matrix data set fea
%z_pc=(Ux'*fea);
% Normalize variances to 1
%[z_pc T] = myWhiten(z_pc);
%t0 = cputime;
%tic;
%label = kmeans1(z_pc,nClass);
%time = cputime-t0;
%time
%%
%label = kmeans1(fea,nClass);
%%
%%%%%%%%% Using the two methods of derivation of PCA i.e.. SVD  & Eigen decomposition
%tic
%[signals,PC,V] = pca2svd(fea,nClass);
%[signals,PC,V] = pca1eig(fea,nClass);
%[signals] = myWhiten(signals);
%label = kmeans1(signals,nClass);
%%%}
label = bestMap(gnd,label);
%label = MybestMap(gnd,label);
%MIhat = MutualInfo(gnd,label);
MIhat = MutualInforn(gnd,label);
AC = length(find(gnd == label))/length(gnd);
Acc=Acc+AC;Mii=Mii+MIhat;
tt=tt+toc;
%time = time + cputime-t0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
disp(['Kmeans in the CNMF reduced subspace normalized mutual information:',num2str(Mii/10)]);
disp(['Kmeans in the CNMF reduced subspace accuracy:',num2str(Acc/10)]);
disp(['Kmeans in the CNMF reduced subspace space Clustering time in second:',num2str(tt/10)]);
%disp(['Kmeans in the PCA space Reduction  time in second:',num2str(time/100)]);
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  00001 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using K-means in the original feature space
tic;
label = kmeans1(fea,nClass);
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['K-means in the originall space normalized mutual information:',num2str(MIhat(1))]);
disp(['K-means in the original space accuracy:',num2str(AC(1))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   00002 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%Lee, Daniel D. Standar NMF  %%%%%%%%%%%%%%%%%%%%%%%%%
% NMF Lee, Daniel D., and H. Sebastian Seung. "Algorithms for non-negative matrix factorization." 
%data clustering in the paper NMF mult update algorithm  reduced feature space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[W,H] = NMF(fea,nClass,200);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass);
label = bestMap(gnd,label);
MIhat(2) = MutualInfo(gnd,label);
AC(2) = length(find(gnd == label))/length(gnd);
disp(['K-means on the Standard NMF space normalized mutual information:',num2str(MIhat(2))]);
disp(['K-means on the Standard NMF space ACcuracy:',num2str(AC(2))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    000003  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   Orthognal on W Algorithm    %%%%%%%%%%%%%%%%%%%%%%%
tic;
lambda=0.8;MxIter=200;
[W,H] = ONMFW(fea,nClass,MxIter,lambda);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass);
label = bestMap(gnd,label);
MIhat(3) = MutualInfo(gnd,label);
AC(3) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the ONMFW space normalized mutual information:',num2str(MIhat(3))]);
disp(['Kmeans in the ONMFW space accuracy:',num2str(AC(3))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 000004  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data clustering using S*V' Matrix from SVD (i.e using reduced feature space)
tic;
[U S V] = svds(fea,nClass);
Uhat = U(:,1:nClass);
Shat = S(1:nClass,1:nClass);
Vhat = V(:,1:nClass);
X=Uhat*Shat*Vhat';
D=(Shat*Vhat');
label = kmeans1(D,nClass); 
label = bestMap(gnd,label);
MIhat(4) = MutualInfo(gnd,label);
AC(4) = length(find(gnd == label))/length(gnd);
disp(['K-means in Matlab SVD space normalized mutual information:',num2str(MIhat(4))]);
disp(['K-means in Matlab SVD  space accuracy:',num2str(AC(4))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  000005  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% My understanding of the  PCA from MYPCA Code via Using SVD %%%%%%%
tic;
%Center the input data
[z_c  , mean_z ] = myCenter(fea);
%SVD --> partial SVD rank-k to the input matrix fea. 
[U S V] = svds(z_c , nClass);
Ux = U(:,1:nClass);
Sx = S(1:nClass,1:nClass);
Vx = V(:,1:nClass);
%%%%%%%%%%%%%%  Data clustering using Reduced U matrix Ux   %%%%%%%%%%%%%%%
% d columns of  Ux  are exactly the leading d eigenvectors of  XX' , 
% which give the d sample principal components  PCA.
z_pc=(Ux'*fea);
% Normalize variances to 1
[z_pc T] = myWhiten(z_pc);
label = kmeans1(z_pc,nClass);
label = bestMap(gnd,label);
MIhat(5) = MutualInfo(gnd,label);
AC(5) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in Matlab PCA_SVD space normalized mutual information:',num2str(MIhat(5))]);
disp(['Kmeans in Matlab PCA_SVD  space accuracy:',num2str(AC(5))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%###########################################################################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   Orthognal on W Algorithm    %%%%%%%%%%%%%%%%%%%%%%%
tic;
lambda=0.8;MxIter=200;
[W,H] = ONMFW(fea,nClass,MxIter,lambda);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass);
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the ONMFW space normalized mutual information:',num2str(MIhat(1))]);
disp(['Kmeans in the ONMFW space accuracy:',num2str(AC(1))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   Orthognal on H Algorithm    %%%%%%%%%%%%%%%%%%%%%%%
tic;
lambda=0.8;MxIter=200;
[W,H] = ONMFH(fea,nClass,MxIter,lambda);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass);
%label = kmeans1(WiegH,nClass);
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(2) = MutualInfo(gnd,label);
AC(2) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the ONMFH space normalized mutual information:',num2str(MIhat(2))]);
disp(['Kmeans in the ONMFH space accuracy:',num2str(AC(2))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NMF by alternative non-negative least squares using projected gradients
% Author: Chih-Jen Lin, National Taiwan University
tic;
timelimit=500;MxIter=300;tol=0.00000001;
[W,H] = ANLSnmf(fea,nClass,tol,timelimit,MxIter);
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass);
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the ANLSnmf space normalized mutual information:',num2str(MIhat(1))]);
disp(['Kmeans in the ANLSnmf space accuracy:',num2str(AC(1))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering  using gdcls algorithm
tic;
maxiter=200;lambda=0.1;options='nonneg';
t0 = cputime;
[W H] = gdcls(fea,nClass, maxiter, lambda, options);
time = cputime-t0;
time
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(8) = MutualInfo(gnd,label);
AC(8) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the GDLCS NMF space normalized mutual information:',num2str(MIhat(8))]);
disp(['Kmeans in the GDLCS NMF space accuracy:',num2str(AC(8))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code was token from the following paper
%Michael.W,Murrar.B, "Algorithms and Application for Approximate Non-Negative Matrix factorization"
%%Constrain a=0.1;B=0.0; Algorithm CNMF
tic;
a=0.1;B=0.0;
[W,H] = CNMF01(fea,nClass,200,a,B);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(3) = MutualInfo(gnd,label);
AC(3) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in CNMF space normalized mutual information:',num2str(MIhat(3))]);
disp(['Kmeans in CNMF space accuracy:',num2str(AC(3))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%multconv Algorithm
tic;
timelimit=200;maxiter=200;
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
%The code was token from the following paper
%Michael.W,Murrar.B, "Algorithms and Application for Approximate Non-Negative Matrix factorization"
%%Constrain a=0.1;B=0.0; Algorithm CNMF
tic;
a=0.1;B=0.0;
[W,H] = CNMF(fea,nClass,200,a,B);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(3) = MutualInfo(gnd,label);
AC(3) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in CNMF space normalized mutual information:',num2str(MIhat(3))]);
disp(['Kmeans in CNMF space accuracy:',num2str(AC(3))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Q=1:10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% My understanding of the  PCA from MYPCA Code %%%%%%%%%%%%%%%%%
% via Using SVD
tic;
%t0 = cputime;
%Center the input data
[z_c mean_z] = myCenter(fea);
%SVD --> partial SVD rank-k to the input matrix fea. 
[U S V] = svds(z_c,nClass);
Ux = U(:,1:nClass);
Sx = S(1:nClass,1:nClass);
Vx = V(:,1:nClass);
%X=Ux*Sx*Vx';
% compute squared error
%errs = sum(sum((X-fea).^2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data clustering using reduced Data Matrix  X
%label = kmeans1(X,nClass); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering using S*V' Matrix from SVD
%z_pc=(Sx*Vx');
% Data clustering using Ux Matrix
% d columns of  Ux  are exactly the leading d eigenvectors of  XX' , 
% which give the d sample principal components  PCA.
z_pc=(Ux'*fea);
% Normalize variances to 1
[z_pc T] = myWhiten(z_pc);
label = kmeans1(z_pc,nClass);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label = bestMap(gnd,label);
MIhat(2) = MutualInfo(gnd,label);
AC(2) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in Matlab PCA_SVD space normalized mutual information:',num2str(MIhat(2))]);
disp(['Kmeans in Matlab PCA_SVD  space accuracy:',num2str(AC(2))]);
%time = cputime-t0;
%time
toc;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data clustering using PCA in the original feature space
tic;
t0 = cputime;
[z_pc varargout] = myPCA(fea,nClass);
%compute squared error
%z_LD = U / T * z_pc;
%XX=U/T*z_pc;
%errs= sum(sum((XX-fea).^2))
time = cputime-t0;
time
label = kmeans1(z_pc,nClass);
label = bestMap(gnd,label);
MIhat(5) = MutualInfo(gnd,label);
AC(5) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the PCA space normalized mutual information:',num2str(MIhat(5))]);
disp(['Kmeans in the PCA space accuracy:',num2str(AC(5))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%nmfOrtho Algorithm
tic;
t0 = cputime;
[W,H] =  nmfOrtho(fea,nClass,200);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(6) = MutualInfo(gnd,label);
AC(6) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Orthognal NMF space normalized mutual information:',num2str(MIhat(6))]);
disp(['Kmeans in the Orthognal NMF space accuracy:',num2str(AC(6))]);
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
MIhat(7) = MutualInfo(gnd,label);
AC(7) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the nmf_kl_mua NMF space normalized mutual information:',num2str(MIhat(7))]);
disp(['Kmeans in the nmf_kl_mua NMF space accuracy:',num2str(AC(7))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering  using gdcls algorithm
tic;
maxiter=200;lambda=0.5;options='nonneg';
t0 = cputime;
[W H] = gdcls(fea,nClass, maxiter, lambda, options);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(8) = MutualInfo(gnd,label);
AC(8) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the GDLC NMF space normalized mutual information:',num2str(MIhat(8))]);
disp(['Kmeans in the GDLC NMF space accuracy:',num2str(AC(8))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code was token from the following paper
%Michael.W,Murrar.B, "Algorithms and Application for Approximate Non-Negative
%Matrix factorization"
%%Constrain a=0.1;B=0.0; Algorithm CNMF
tic;
a=0.01;B=0;
[W,H] = CNMF(fea,nClass,200,a,B);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(9) = MutualInfo(gnd,label);
AC(9) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in CNMF space normalized mutual information:',num2str(MIhat(9))]);
disp(['Kmeans in CNMF space accuracy:',num2str(AC(9))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data clustering  using nmf_euc_orth 05
tic;
[W,H,errs] = nmf_euc_orth05(fea,nClass,200);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(10) = MutualInfo(gnd,label);
AC(10) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the nmf_euc_orth05 space normalized mutual information:',num2str(MIhat(10))]);
disp(['Kmeans in the nmf_euc_orth05 space accuracy:',num2str(AC(10))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Data clustering  using nmfHeasun
tic;
t0 = cputime;
[W,H] = nmfHeasun(fea,nClass,'type','sparse');
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(11) = MutualInfo(gnd,label);
AC(11) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Heasun NMF space normalized mutual information:',num2str(MIhat(11))]);
disp(['Kmeans in the Heasun NMF space accuracy:',num2str(AC(11))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ONPMF Algorithm
tic;
t0 = cputime;
[W,H,relError,actualIters] = onpmf(fea,nClass,200);%(M,numClusters,maxOnpmfIters);
time = cputime-t0;
time
%[label,C]=kmeans(V',nClass,'MaxIter',200);
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(12) = MutualInfo(gnd,label);
AC(12) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the Two Orthognal NMF space normalized mutual information:',num2str(MIhat(12))]);
disp(['Kmeans in the Two Orthognal NMF space accuracy:',num2str(AC(12))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code was token from the following paper
%Srilakshmi.I,Veerraju.G, "Image compression using Constrained Non-Negative
%Matrix factorization"
%%Constrain x=0.01; Algorithm CNMF02
tic;
x=0.01;
[W,H] = CNMF02(fea,nClass,200,x);
label = kmeans1(H,nClass); 
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

%% Matlab nnmf Algotihm MU
%%%%%%%%%%%%%%%%%%%%%      Matlab NMF Als Algorithm   %%%%%%%%%%%%%%%%%%%%%
tic;
opt = statset('Maxiter',200);
t0 = cputime;
[W,H] = nnmf(fea,nClass,'options',opt,'algorithm','als');  %'mult');  mult algorithm gives bad results 0.17
time = cputime-t0;
time
%data clustering using V Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass); 
%[label,C]=kmeans(V',nClass,'MaxIter',500);
label = bestMap(gnd,label);
MIhat(15) = MutualInfo(gnd,label);
AC(15) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in Matlab nnmf space normalized mutual information:',num2str(MIhat(15))]);
disp(['Kmeans in Matlab nnmf  space accuracy:',num2str(AC(15))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%the NMFNNSVD space
tic;
[W,H] = nmf_NNSVD ( fea,nClass,200);
label = kmeans1(H,nClass);
label = bestMap(gnd,label);
MIhat(16) = MutualInfo(gnd,label);
AC(16) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the NMFNNSVD space normalized mutual information:',num2str(MIhat(16))]);
disp(['Kmeans in the NMFNNSVD space accuracy:',num2str(AC(16))]);
toc;
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
save('Final_Results016.mat','AC','MIhat');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MIhat(2) =0;
%AC(2) =0;
% Ward linkage.
% 'euclidean' 'cosine' 'minkowski' 'hamming' 'jaccard' 'mahalanobis'
% 'chebychev' 'cityblock'
%linkage is 'centroid', 'median', or 'ward'
%Create a hierarchical cluster tree using Ward's linkage.
%tic;  
%Z = linkage( fea','ward','euclidean'); 
%%Create a dendrogram plot of Z .
%%dendrogram(Z);
%%firstfivten = Z(1:15,:)
%%Cluster data into nClass groups.
%c = cluster(Z,'maxclust',nClass);
%label = bestMap(gnd,c);
%MIhat(2) = MutualInfo(gnd,c);
%AC(2) = length(find(gnd == label))/length(gnd);
%disp(['aggmolative clustering  normalized mutual information:',num2str(MIhat(2))]);
%disp(['aggmolative clustering  accuracy:',num2str(AC(2))]);
%toc;