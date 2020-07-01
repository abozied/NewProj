clc ; clear all;    %addpath('fcm')
%import datasets Initializition
disp('******************Arabic_Corpus_TFIDF_10 DataSet******************');
%disp('******************English_Corpus_TFIDF  Reuters21578.mat************');
load('Corpus\Arabic_Corpus_TFIDF_20.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
%load('Corpus\Reuters21578.mat');%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
%load('Corpus\20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');%('TDT2.mat');%('PIE_pose27.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea);
fea2 = fea';  
gnd2=gnd;
nClass2 =nClass ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fea=fea2(:,1:7232);
gnd=gnd2(1:7232,:);
nClass = length(unique(gnd));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
return
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
tic;
X=fea';
%%%%%%%%
%C=X'*X;
%[W,Lemda]=eig(C);
%W=W(:,7232:-1:1);
%Lemda=Lemda(:,7232:-1:1);
%W_r=W(:,1:nClass);
%A=X*W_r;
%%%%%%%%%%%%%%%%%%%%%%%
[u,sig,v]=svd(X);
v=-v;
v_r=v(:,1:nClass); % Get  the n Principle Components
A=X*v_r;   %Get the Projection of X on v_r
%%%%%%%%%%%%%%%%%%%%%%%
label = kmeans1(A',nClass);
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the originall space normalized mutual information:',num2str(MIhat(1))]);
disp(['Kmeans in the original space accuracy:',num2str(AC(1))]);
%figure(1);plot(A(:,1),A(:,2), '.');
toc;
return
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
