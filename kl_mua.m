function [W, H] = kl_mua(V,r, maxiter)
% Author: Felipe Yanez
% Copyright (c) 2014-2016
if min(min(V)) < 0
    error('Matrix entries can not be negative');
end
% Initialization
[n,m] = size(V);
E=ones(n,m);
W = abs(rand(n,r));
W = W./(ones(n,1)*sum(W));
H = abs(rand(r,m));
eps = 1e-9;
%message = ['computing NMF. iteration : 0/200 completed'];
%mes = waitbar(0,message);
for iter = 1:maxiter   
    % Multiplicative update rule
    W = W.*((V./(W*H+eps))*H')./(E*H');
    H = H.*(W'*(V./(W*H+eps)))./(W'*E);
    % Waitbar
 %    message = ['computing NMF. iteration : ' int2str(iter) '/' int2str(maxiter)];
 %    waitbar(iter/maxiter,mes,message);
    
end
    %obj = sum(sum(-V.*(log((W*H+eps)./(V+eps))+1)+W*H))
end