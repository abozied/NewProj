function U = svdInit(M,r)

n = size(M,2);
if n < r
    [U,Sigma,Vt] = svd(M); U = U(:,1:r);           
else
    [U,Sigma,Vt] = svds(M,r);
end
% sign flip ambiguity check
for j=1:r
    negidx = U(:,j)<0;
    isNegNormGreater = norm(U(negidx,j),'fro') > norm(U(~negidx,j),'fro');
    if isNegNormGreater
        U(:,j) = -U(:,j);
    end  
end