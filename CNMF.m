%######################################################%
%##                                                  ##%
%##                                                  ##%
%##                                                  ##%
%######################################################%
function [W,H] = CNMF(X,k,maxiter,a,b)
%%this algorithm was taken form the following papers
%Nonnegative Matrix Factorization for Spectral Data Analysis
%V. Paul Pauca¤ J. Pipery Robert J. Plemmonsz
% Perform non-negative matrix factorization, NMF.
%   V: m x n data matrix
%   r: the reduced dimension
%   maxiter: the maximum number of iterations
%   W: m x r basis matrix
%   H: r x n coefficient matrix
t0 = cputime;
if min(min(X)) < 0
    error('Matrix entries can not be negative');
end
[n,m] = size(X);
%initialization from Langville et al. (2006)
W = abs(rand(n,k)); % initialize W as random dense matrix or use another
W = W./(ones(n,1)*sum(W));
H = abs(rand(k,m));% initialize H as random dense matrix or use another
eps = 1e-9;
%tol=0.001;
%a=0.2;B=0;
% CNMF iteratively updates
for iter=1:maxiter
  H = H .* (((W'*X)-b*H) ./ ((W'*W)*H +eps)); %This equation may give negative values  due the subtraction -b*H
  W = W .* (((X*H')-a*W) ./ (W*(H*H') +eps)); %This equation may give negative values due the subtraction -a*W
  W = W./(ones(n,1)*sum(W));
end
time = cputime-t0;
time 