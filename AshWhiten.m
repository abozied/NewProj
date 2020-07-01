function [v] = AshWhiten(x)
%whitening
[E,D]=eig(x*x');%eig(cov(x));
v = E * D^(-.5) * E' * x;
%Data transformation and ICA by PCA
%z=sqrt(sum(v.^2)).*v; 
%[EE,DD]=eig(z*z');
%y=EE'*v;