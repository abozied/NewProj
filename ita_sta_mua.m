function [W, H] = ita_sta_mua(V,r, maxiter)
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
for iter = 1:maxiter   
    % Multiplicative update rule
    X=W*H;
    X2=X.^2;
    NX=V./X2;
    RX=E./X;
    W = W.*((NX*H')./(RX*H'));
    H = H.*((W'*NX)./(W'*RX));  
end
    %obj = sum(sum(-V.*(log((W*H+eps)./(V+eps))+1)+W*H))
end