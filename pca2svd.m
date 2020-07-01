function [signals,PC,V] = pca2svd(data,nClass) 
% PCA2: Perform PCA using SVD. 
% data - MxN matrix of input data (M dimensions, N trials)
% signals - MxN matrix of projected data 
% PC - each column is a PC 
% V - Mx1 matrix of variances 
[M,N] = size(data); 
% subtract off the mean for each dimension
%mn = mean(data,2); 
%data = data - repmat(mn,1,N);
[data  , mn ]=AshCenter(data);
% construct the matrix Y which is the transpose of the Data matrix
Y = data' / sqrt(N-1);
% SVD does it all 
[u,S,PC] = svds(Y , nClass);
%[u,S,PC] = svd(Y);
% calculate the variances 
S = diag(S); 
V = S .* S; 
% project the original data 
signals = PC' * data;
%%
%signals=signals(1:nClass,:);