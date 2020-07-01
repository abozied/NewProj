%From the paper 
%On the Convergence of Multiplicative Update Algorithms for Non-negative Matrix Factorization"
% By Chih-Jen Lin, Senior Member, IEEE
function [W,H,iter] = multconv(V,k,timelimit,maxiter)
t0 = cputime;
sigma = 1.0e-8; delta=sigma;
[m,n] = size(V);
W0=rand(m,k);
H0=rand(k,n);
W = W0; H = H0;
initt=cputime; t=initt;
for iter=1:maxiter
if (iter == maxiter || cputime-initt > timelimit)
fprintf('iter %d\n', iter);
break
end
WtW = W'*W;
gradH = WtW*H - W'*V;
Hb = max(H, (gradH<0)*sigma);
H = H - Hb./(WtW*Hb+delta).*gradH;
HHt = H*H';
gradW = W*(HHt) - V*H';
Wb = max(W, (gradW<0)*sigma);
W = W - Wb./(Wb*HHt+delta).*gradW;
S = sum(W,1);
W = W./repmat(S,m,1); H = H.*repmat(S',1,n);
end
time = cputime-t0;
time 