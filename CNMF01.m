%######################################################%
%##                                                  ##%
%##                                                  ##%
%##                                                  ##%
%######################################################%
function [W,H] = CNMF01(X,k,maxiter,a,b)
%This algorithm was taken form the following papers
%Algorithms and applications for approximate nonnegative matrix factorization
%MichaelW. Berrya,?, Murray Brownea, Amy N. Langvilleb,1, V. Paul Paucac,2,
%Computational Statistics & Data Analysis 52 (2007) 155 – 173
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
  H = H .* ((W'*X) ./ ((W'*W)*H +b*H+eps));
  W = W .* ((X*H') ./ (W*(H*H') +a*W+eps));
 % W = W./(ones(n,1)*sum(W));
 %if(norm(X-W*H)<tol)
 %               break;
 %end
end
time = cputime-t0;
time 