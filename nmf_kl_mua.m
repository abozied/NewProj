function [W, H, obj, time] = nmf_kl_mua(V,r, maxiter)
% Author: Felipe Yanez
% Copyright (c) 2014-2016
if min(min(V)) < 0
    error('Matrix entries can not be negative');
end
% Initialization
t0   = cputime;
obj  = zeros(1,maxiter);
time = zeros(1,maxiter);
[n,m] = size(V);
W = abs(rand(n,r));
W = W./(ones(n,1)*sum(W));
H = abs(rand(r,m));
eps = 1e-9;
for iter = 1:maxiter   
    % Multiplicative update rule
    hh=sum(H,2)';
    W = W.*((V./(W*H+eps))*H')./repmat(hh+eps,n,1);%n=size(V,1)
    ww=sum(W,1)';
    H = H.*(W'*(V./(W*H+eps)))./repmat(ww+eps,1,m);%m=size(V,2)
    % Compute objective function
    %  obj(iter)  = sum(sum(-V.*(log((W*H+eps)./(V+eps))+1)+W*H));
    %  time(iter) = cputime-t0;  
end
  % obj  = sum(sum(-V.*(log((W*H+eps)./(V+eps))+1)+W*H));
  % time = cputime-t0;
  % obj
  % time
  

end