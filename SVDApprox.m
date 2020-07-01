function [A] = SVDApprox(X,r)
% using SVD to approx X Data
t0 = cputime;
[U S V] = svd(X,'econ');
Uhat = U(:,1:r);
Shat = S(1:r,1:r);
Vhat = V(:,1:r);
A=abs(Uhat*Shat*Vhat');
time = cputime-t0;
time
end