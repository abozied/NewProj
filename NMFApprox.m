function [ A ] = NMFApprox(V,r, maxiter)

if min(min(V)) < 0
    error('Matrix entries can not be negative');
end
[n,m] = size(V);
W = abs(rand(n,r));
W = W./(ones(n,1)*sum(W));
H = abs(rand(r,m));
eps = 1e-9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lee Song
% NMF iteratively updates
%for iter=1:maxiter
%  H = H.*((W'*V)./((W'*W)*H+eps));
%  W = W./(ones(n,1)*sum(W));
%  W = W.*((V*H')./(W*(H*H')+eps));
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Felipe Yanez
% Copyright (c) 2014-2016
%% KL Multiplicative update rule
for iter = 1:maxiter,   
    % Multiplicative update rule
    W = W.*((V./(W*H+eps))*H')./repmat(sum(H,2)'+eps,size(V,1),1);
    H = H.*(W'*(V./(W*H+eps)))./repmat(sum(W,1)'+eps,1,size(V,2));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=W*H;

end

