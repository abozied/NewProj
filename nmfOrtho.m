function [W,H] = nmfOrtho(X,k,maxiter)
%From the paper
%Orthogonal Nonnegative Matrix Factorization for Blind Image Separation
%By Andri Mirzal
%
%
t0   = cputime;
[n,m] = size(X); alpha1 = 0.1; 
W = rand(n,k);
H = rand(k,m);
sigma = 1.0e-9; delta = sigma;

for iteration = 1 : maxiter
CCt = H*H';
gradB = W*CCt - X*H';
Bm = max(W,(gradB<0)*sigma);
W = W - Bm./(Bm*CCt+delta).*gradB;
BtB = W'*W;
gradC = BtB*H + alpha1*CCt*H - alpha1*H - W'*X;
Cm = max(H,(gradC<0)*sigma);
CmCmt = Cm*Cm';
H = H - Cm./(BtB*Cm + alpha1*CmCmt*Cm + delta).*gradC;
end
time = cputime-t0;
time