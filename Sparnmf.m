%######################################################%
%##              Sparsness NMF                       ##%
%######################################################%
function [W,H] = Sparnmf(V,r,maxiter)
% Perform non-negative matrix factorization, NMF.
%   V: m x n data matrix
%   r: the reduced dimension
%   maxiter: the maximum number of iterations
%   W: m x r basis matrix
%   H: r x n coefficient matrix
%
%paper: Weizhong Zhaol, Huifang Ma2, Ning Li3
%A New Non-negative Matrix Factorization Algorithm with Sparseness Constraints
t0 = cputime;
if min(min(V)) < 0
    error('Matrix entries can not be negative');
end
[n,m] = size(V);
W = abs(rand(n,r));
W = W./(ones(n,1)*sum(W));
H = abs(rand(r,m));
% NMF iteratively updates
for iter=1:maxiter
  H = H+(0.1*W')*((V./(W*H))-eye(n,m));
  W = W+0.1*((V./(W*H))-eye(n,m))*H';
end
time = cputime-t0;
time
end