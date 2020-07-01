% simple example application of NMFL0-W.
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
%%%%%%%%%%%%%%%%%%%%%%Lee, Daniel D. Standar NMF  %%%%%%%%%%%%%%%%%%%%%%%%%
% NMF Lee, Daniel D., and H. Sebastian Seung. "Algorithms for non-negative matrix factorization." 
%data clustering in the paper NMF mult update algorithm  reduced feature space
tic;
%%% set NMFL0_W parameters
%%% select sparse coder
options.sparseCoder = @rsNNLS___;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%K:number of columns in dictionary matrix W
% or # ofCluster
    options.K = nClass;
%L:maximal number of nonzeros in each column of W   
    options.L = 5;
    options.numIter = 10;
    options.updateType = 'ANLS_FC';
    %%% number of dictionary updates
    options.numUpdateIter = 10;    
    [W,H,INFO] = NMFL0_W(fea,options);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data clustering using H Matrix from NMF (i.e using reduced feature space)
label = kmeans1(H,nClass); 
label = bestMap(gnd,label);
MIhat(44) = MutualInfo(gnd,label);
AC(44) = length(find(gnd == label))/length(gnd);
disp(['Kmeans in the L0 W Constrain NMF space normalized mutual information:',num2str(MIhat(44))]);
disp(['Kmeans in the L0 W Constrain NMF NMF space accuracy:',num2str(AC(44))]);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%