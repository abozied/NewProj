function [ W, H] = nmf_NewI_SVD ( X, k, maxiter)  %, varargin )
% By using SVD as initilization algorithm for Orthognal non-negative matrix factorization, NMF.
%  ORNMF algorithm was token from paper: wen, hua, and yun. "Fast text categorization  based on collaboration work in for non-negative matrix factorization."  2011 IEEE.
m=size(X,1);
[u s v p]=ChoosingR(X);
%W=abs(u(:,1:p)); 
%H=abs(s(1:p,:)*v');
W=abs(u(:,1:k)); 
H=abs(s(1:k,:)*v');
%W = W./(ones(n,1)*sum(W));
%%%%%%%%%%   Orthogonal NMF Algorithm using MU Algorithm %%%%%%%%%%%%%%%%%%
eps = 1e-9;
%%%%%%%%%%   Orthogonal NMF Algorithm using MU Algorithm %%%%%%%%%%%%%%%%%%
for  i = 1 :  maxiter
        H = H.*(W'* X)./((W'*W)*H +eps);  %eps to avoids division by 0
        %W = W./(ones(m,1)*sum(W));
        W = W.*(X*H'+0.002*W)./(W*(H*H')+0.002*(W*W')*W +eps); %eps to avoids division by 0
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A=[
%       1    2    3   4  ;
%       5    6    7   8  ;
%       9    10   11  12 ;
%       13   14   15  16 ;
%       17   18   19  20
%          ];
%NMF iteratively Multi-updates
%eps=1e-9;
%[m n]= size(X);
%    W = rand(size(X, 1), k);
%    H = rand(k, size(X,2));
%for i=1:maxiter
%  H = H.*((W'*X)./((W'*W)*H+eps));
%  W = W./(ones(m,1)*sum(W));
%  W = W.*((X*H')./(W*(H*H')+eps));
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
