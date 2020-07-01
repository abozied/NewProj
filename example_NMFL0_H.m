%
% simple example application of NMFL0-H
%
% run NMFL0_H described in 
% R. Peharz and F. Pernkopf, "Sparse nonnegative matrix factorization with
% L0-constraints", Neurocomputing, 2012.
%%% dictionary size
%K = 400
%frobX = norm(X,'fro');
%%% select sparse coder
%options.sparseCoder = @rsNNLS___;
%options.sparseCoder = @sNNLS___;
%%% select dictionary update method
%options.updateType = 'ANLS_FC';
% options.updateType = 'MU';
% options.updateType = 'KSVD';
% options.updateType = 'ANLS_PG';
% options.NNLS_PG_tolerance = 1e-3;
% options.NNLS_PG_maxIter = 100;
%%% number of dictionary updates
%options.numUpdateIter = 10;
clc
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('******************Arabic_Corpus_TFIDF_10 DataSet******************');
%('20NewsHome.mat');%('Reuters21578.mat');;%('TDT2_all.mat');%('RCV1_4Class.mat');('PIE_pose27.mat');
%load fea which is the document_term matrix and gnd is classified label for all documents
load('Corpus\Arabic_Corpus_TFIDF_20.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea); %Normalize each row of fea matrix
fea2 = fea';  % transpose fea matrix to get term_document matrix 
gnd2=gnd;
nClass2 =nClass ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fea=fea2(:,1:7232); % get only 7232 documents of all corpus term_document matrix
gnd=gnd2(1:7232,:); % get o7232 labels
nClass = length(unique(gnd)); % get # of classes in these documents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%run NMFL0_H described in 
% R. Peharz and F. Pernkopf, "Sparse nonnegative matrix factorization with
% L0-constraints", Neurocomputing, 2012.
tic;
%%% set NMFL0_H parameters
%K:number of columns in dictionary matrix W
% or # of Cluster
options.K = nClass;
%%% maximal allowed number of nonzeros per column of H
options.L = nClass;
options.numIter = 20;
%%% number of dictionary updates
options.numUpdateIter = 1;
%%% select sparse coder
options.sparseCoder = @rsNNLS___;
%%% select dictionary update method
options.updateType = 'ANLS_FC';
%options.updateType = 'MU';
%options.updateType = 'KSVD';
%options.updateType = 'ANLS_PG';
options.NNLS_PG_tolerance=0.00001;
options.NNLS_PG_maxIter=200;
%%%%%%%%%
[W,H,INFO] = NMFL0_H(fea, options);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data clustering using H Matrix from NMF (i.e using reduced feature space)
%[WiegH]=GRSCORE(H);
%[WiegH]=PetrovScore(W,H);
label = kmeans1(H,nClass);
%label = kmeans1(WiegH,nClass); 
label = bestMap(gnd,label);
MIhat(1) = MutualInfo(gnd,label);
AC(1) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the L0 H Constrain NMF space normalized mutual information:',num2str(MIhat(1))]);
disp(['Kmeans in the L0 H Constrain NMF space accuracy:',num2str(AC(1))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
