%% This function was taken from the following  paper
%Document clustering using NMF
%Farial Shahnaz a, Michael W. Berry a,*, V. Paul Pauca b, Robert J. Plemmons b
%Information Processing and Management 42 (2006) 373–386
function [W, H] = gdcls(V, k, maxiter, lambda, options)
    myeps = 10^-9;
    if strcmp(options, 'nonneg');
        neg = 1;
    else
        neg = 0;
    end
    [m,n] = size(V);
    W = rand(m, k);
    H = zeros(k, n);
    for j = 1 : maxiter
        A = W' * W + lambda * eye(k);
        for i = 1 : n
            b = W' * V(:, i);
            H(:,i) = A \ b;
        end
        % Removing any negative elements
        if neg == 1
            H = H .* (H > 0);
        end
        % Updating W
        W = W .* (V * H') ./ (W * (H * H') + myeps);
        %for qq = 1 : size(W, 2)
        %    W(:, qq) = W(:, qq) / sum(W(:,qq));
        %end
    end
    
end