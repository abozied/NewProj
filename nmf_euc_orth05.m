function [W,H,errs] = nmf_euc_orth05(V, r, Maxiter)
% function [W,H,errs,vout] = nmf_euc_orth(V, r, varargin)
%
% Implements Orthogonal NMF using squared error cost function (see [1-2] for details):
% 
%      min sum(sum((V-W*H).^2)) s.t. W>=0,H>=0
%
% Inputs: (all except V and r are optional and passed in in name-value pairs)
%   V      [mat]  - Input matrix (n x m)
%   r      [num]  - Rank of the decomposition
%   niter  [num]  - Max number of iterations to use [100]
%   thresh [num]  - Number between 0 and 1 used to determine convergence;
%                   the algorithm has considered to have converged when:
%                   (err(t-1)-err(t))/(err(1)-err(t)) < thresh
%                   ignored if thesh is empty [[]]
%   norm_w [num]  - Type of normalization to use for columns of W [1]
%                   can be 0 (none), 1 (1-norm), or 2 (2-norm)
%   norm_h [num]  - Type of normalization to use for rows of H [0]
%                   can be 0 (none), 1 (1-norm), 2 (2-norm), or 'a' (sum(H(:))=1)
%   verb   [num]  - Verbosity level (0-3, 0 means silent) [1]
%   W0     [mat]  - Initial W values (n x r) [[]]
%                   empty means initialize randomly
%   H0     [mat]  - Initial H values (r x m) [[]]
%                   empty means initialize randomly
%   W      [mat]  - Fixed value of W (n x r) [[]] 
%                   empty means we should update W at each iteration while
%                   passing in a matrix means that W will be fixed
%   H      [mat]  - Fixed value of H (r x m) [[]] 
%                   empty means we should update H at each iteration while
%                   passing in a matrix means that H will be fixed
%   myeps  [num]  - Small value to add to denominator of updates [1e-20]
%   orth_w [bool] - Switch that determines whether we are imposing orthogonality 
%                   constraints on W or not. [true] 
%   orth_h [bool] - Switch that determines whether we are imposing orthogonality 
%                   constraints on H or not. [false] 
%
% Outputs:
%   W      [mat]  - Basis matrix (n x r)
%   H      [mat]  - Weight matrix (r x m)
%   errs   [vec]  - Error of each iteration of the algorithm
%
% [1] S. Choi, "Algorithms for Orthogonal Nonnegative Matrix Factorization",
%     IEEE International Joint Conference on Neural Networks, 2008.
% [2] D. Lee and S. Seung, "Algorithms for Non-negative Matrix Factorization", 
%     NIPS, 2001.
%
% 2010-11-04 Graham Grindlay (grindlay@ee.columbia.edu)
% Copyright (C) 2008-2028 Graham Grindlay (grindlay@ee.columbia.edu)
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
% do some sanity checks
%if min(min(V)) < 0
%    error('Matrix entries can not be negative');
%end
%if min(sum(V,2)) == 0
%    error('Not all entries in a row can be zero');
%end
t0 = cputime;
[n,m] = size(V);
orth_w=0;
norm_w=0;
orth_h=1;
norm_h=0;
niter=Maxiter;
update_W =1;
update_H =1;
myeps = 1e-9;
W = rand(n,r);
H = rand(r,m);

for t = 1:niter
    % update W if requested
    if update_W
        if orth_w
            W = W .* ( (V*H') ./ max(W, myeps) );
        else
            W = W .* ( (V*H') ./ max(W, myeps) );
        end
    end
    % update H if requested
    if update_H
        if orth_h
            H = H .* ( (W'*V) ./(H*V'*W*H+ myeps) );
        else
            H = H .* ( (W'*V) ./((W'*W)*H+ myeps) );
        end
        
    end
    
end
% compute squared error
time = cputime-t0;
time
errs= sum(sum((V-W*H).^2))
end
