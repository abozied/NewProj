function [W,H] = ONMFW(X,r,maxiter,lambda)
%the Algorithm was taken from the following papers
%Nonnegative Matrix Factorization on Orthogonal Subspace
%Zhao Li a,b,*, Xindong Wub,c, Hong Peng a
%Pattern Recognition Letters 31 (2010) 905–911
% This algorithm enforces ortognality on W matix
%   V: m x n data matrix
%   r: the reduced dimension
%   maxiter: the maximum number of iterations
%   W: m x r basis matrix
%   H: r x n coefficient matrix
%  NMF algorithm paper: wen, hua, and yun. "Fast text categorization  based on collaboration work in for non-negative matrix factorization."  2011 IEEE.
t0 = cputime;
if min(min(X)) < 0
    error('Matrix entries can not be negative');
end
[n,m] = size(X);
W = abs(rand(n,r));
W = W./(ones(n,1)*sum(W));
H = abs(rand(r,m));
eps = 1e-9;
%lamda=0.8;
%%%%%%%%%%   Orthogonal NMF Algorithm using MU Algorithm %%%%%%%%%%%%%%%%%%
for  i = 1 :  maxiter
        Q=(W'*W);
        H = H.*(W'* X)./(Q*H +eps);  %eps to avoids division by 0
        W = W.*(X*H'+lambda*W)./(W*(H*H')+lambda*W*Q +eps); %eps to avoids division by 0
        %%%%%%%%%%% for ALSCO algorithm
        %W = W.*(X*H'+0.002*W)./(W*(H*H')+0.002*(W*W')*W +eps+W); 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%for Normalize in W
        %W = W./(ones(n,1)*sum(W));
end
time = cputime-t0;
time