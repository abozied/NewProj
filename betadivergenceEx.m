% Example script for Sparse NMF with beta-divergence distortion function
% and L1 penalty on the activations.
% If you use this code, please cite:
% J. Le Roux, J. R. Hershey, F. Weninger, 
% "Sparse NMF –- half-baked or well done?," 
% MERL Technical Report, TR2015-023, March 2015
%   @TechRep{LeRoux2015mar,
%     author = {{Le Roux}, J. and Hershey, J. R. and Weninger, F.},
%     title = {Sparse {NMF} -– half-baked or well done?},
%     institution = {Mitsubishi Electric Research Labs (MERL)},
%     number = {TR2015-023},
%     address = {Cambridge, MA, USA},
%     month = mar,
%     year = 2015
%   }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright (C) 2015 Mitsubishi Electric Research Labs (Jonathan Le Roux,
%                                         Felix Weninger, John R. Hershey)
%   Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You need to provide a non-negative matrix v to be factorized.
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('******************Arabic_Corpus_TFIDF_10 DataSet******************');
%load fea which is the document_term matrix and gnd is classified label for all documents
load('Corpus\Arabic_Corpus_TFIDF_20.mat');
nClass = length(unique(gnd));
fea = NormalizeFea(fea); %Normalize each row of fea matrix
fea2 = fea';  % transpose fea matrix to get term_document matrix 
gnd2=gnd;
nClass2 =nClass ;
fea=fea2(:,1:7232); % get only 7232 documents of all corpus term_document matrix
gnd=gnd2(1:7232,:); % get 7232 labels
nClass = length(unique(gnd)); % get # of classes in these documents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=fea;
%%%%%%%%%%%%%%%%
params = struct;
% Objective function
params.cf = 'is';   %  'is', 'kl', 'ed'; takes precedence over setting the beta value
  % alternately define: params.beta = 1;
params.sparsity = 5;

% Stopping criteria
params.max_iter = 100;
params.conv_eps = 1e-3;
% Display evolution of objective function
params.diplay   = 0;
% Random seed: any value over than 0 sets the seed to that value
params.random_seed = 1;
% Optional initial values for W 
%params.init_w
% Number of components: if init_w is set and r larger than the number of
% basis functions in init_w, the extra columns are randomly generated
params.r = nClass; %500;
% Optional initial values for H: if not set, randomly generated 
%params.init_h
% List of dimensions to update: if not set, update all dimensions.
%params.w_update_ind = true(r,1); % set to false(r,1) for supervised NMF
%params.h_update_ind = true(r,1);
tic;
[w, h, objective] = sparse_nmf(v, params);
idx = kmeans1(h,nClass);
label = bestMap(gnd,idx);
MIhat = MutualInfo(gnd,label);
AC = length(find(gnd == label))/length(gnd);
Acc=AC;Mii=MIhat;
tt=toc;
disp(['Kmeans in the NMF_KLMU H space normalized mutual information:',num2str(Mii)]);
disp(['Kmeans in the NMF_KLMU H space accuracy:',num2str(Acc)]);
disp(['Kmeans in the NMF_KLMU H space Clustering time in second:',num2str(tt)]);
