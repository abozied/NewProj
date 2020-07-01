%Perform Constrain non-negative matrix factorization, CNMF.
%The code was token from the following paper
%Srilakshmi.I,Veerraju.G, "Image compression using Constrained Non-Negative
%Matrix factorization"
function [w,h] = CNMF02(V,k,maxiter,x)
t0 = cputime;
[n m]=size(V);
%w0=rand(n,k);
%h0=rand(k,m);
w0 = abs(rand(n,k));
w0 = w0./(ones(n,1)*sum(w0));
h0 = abs(rand(k,m));
%%
%tol=0.001;
for j=1:maxiter
         numer = w0'*V;
         h = h0.*(numer) ./ ((w0'*w0)*h0+x*h0 +eps(numer));
         h=h.*(h>0);
         numer = V*h';
         w = w0.*(numer) ./ (w0*(h*h')+x*w0+eps(numer));
         w = w.*(w>0);
         w0 = w; h0 = h;
        % if(norm(V-w*h)<tol)
        %        break;
        % end
end
time = cputime-t0;
time
end