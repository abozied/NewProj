function [ W, H] = nmf_NNSVD ( X, k, maxiter)  %, varargin )

t0 = cputime;
% Matrix sizes
% X: m x n
% Z: m x num_of_components
% H: num_of_components x num_of_components
% Do SVD initialisation of the init components
%if 1
    [W, H] = NNDSVD(abs(X), k, 0);
%else
%    W = rand(size(X, 1), k);
%    H = rand(k, size(X,2));
%end
[n m]= size(X);
%eps = 1e-9;

% NMF iteratively updates
%for iter=1:maxiter
%  H = H.*((W'*X)./((W'*W)*H+eps));
%  W = W./(ones(n,1)*sum(W));
%  W = W.*((X*H')./(W*(H*H')+eps));
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A=[
%       1    2    3   4  ;
%       5    6    7   8  ;
%       9    10   11  12 ;
%       13   14   15  16 ;
%       17   18   19  20
%          ];
%maxiter=100000;
%W =  abs(rand(5,2)) ;  % initialize W  as random matrix
%H  =  abs(rand(2,4 )) ;  % initialize H  as random  matrix
%for  i = 1 :  maxiter
%        H  =  H .*  (W' * X)  ./  (W' *  W * H  +  10^ -10);  %10^-10 avoids division by 0
%        W = W .*  (X *  H')   ./  (W  * H  * H' +  10^ -10); %10^-10 avoids division by 0
%end
%W*H
%NMF iteratively updates
eps=10^ -10;
for i=1:maxiter
  H = H.*((W'*X)./((W'*W)*H+eps));
  W = W./(ones(n,1)*sum(W));
  W = W.*((X*H')./(W*(H*H')+eps));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = cputime-t0;
time
end


