% A seguinte funç?o implementa o P-ICA linear
%
% Entrada:  x é mistura uma matriz(dxn)
%
%           y é os sinais estimados
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function [y,w] = pca_ica(x)
    n = size(x,1);
    [E, D] = eig(cov(x'));
    v = E*D^(-0.5)*E' * x;
    z = repmat(sqrt(sum(v.^2)),n,1).*v;
    [EE, DD] = eig(cov(z'));
    y = EE'*v;
    w = EE';
end