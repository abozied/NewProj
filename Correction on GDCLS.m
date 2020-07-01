%The following is the core of the GD-CLS algorithm of Berry et.al., copied from fig. 1 of Shahnaz et.al, 2006, "Document clustering using nonnegative matrix factorization':
     for jj = 1:maxiter
         A = W'*W + lambda*eye(k);
         for ii = 1:n
             b = W'*V(:,ii);
             H(:,ii) = A \ b;
         end
         H = H .* (H>0);
         W = W .* (V*H') ./ (W*(H*H') + 1e-9);
     end
%
     %Replacing the columwise update of H with a matrix update gives:

      for jj = 1:maxiter
          A = W'*W + lambda*eye(k);
          B = W'*V;
          H = A \ B;
          H = H .* (H>0);
          W = W .* (V*H') ./ (W*(H*H') + 1e-9);
      end