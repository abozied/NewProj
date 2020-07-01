function [newVectors, whiteningMatrix, dewhiteningMatrix] = ...
                            whitenv (vectors, E, D, s_verbose);

% [newVectors, whiteningMatrix, dewhiteningMatrix] = ...
%                               whitenv(vectors, E, D, verbose);
%
% Whitens the data (row vectors) and reduces dimension. Returns
% the whitened vectors (row vectors), whitening and dewhitening matrices.
%
% ARGUMENTS
%
% vectors       Data in row vectors.
% E             Eigenvector matrix from function 'pcamat'
% D             Diagonal eigenvalue matrix from function 'pcamat'
% verbose       Optional. Default is 'on'
%
% EXAMPLE
%       [E, D] = pcamat(vectors);
%       [nv, wm, dwm] = whitenv(vectors, E, D);
%
%
% This function is needed by FASTICA
%
%   See also PCAMAT

% 15.3.1998


% ========================================================
% Default value for 'verbose'
if nargin < 4, s_verbose = 'on'; end

% Check the optional parameter verbose;
if strcmp(lower(s_verbose), 'on'),
    b_verbose = 1;
  elseif strcmp(lower(s_verbose), 'off'),
    b_verbose = 0;
  else
    error(sprintf('Illegal value [ %s ] for parameter: ''verbose''\n', s_verbose));
end

% ========================================================
% Calculate the whitening and dewhitening matrices (these handle
% dimensionality simultaneously).
whiteningMatrix = inv (sqrt (D)) * E';
dewhiteningMatrix = E * sqrt (D);

% Project to the eigenvectors of the covariance matrix.
% Whiten the samples and reduce dimension simultaneously.
if b_verbose, fprintf ('Whitening...\n'); end
newVectors =  whiteningMatrix * vectors;

% ========================================================
% Just some security...
if max (max (imag (newVectors))) ~= 0,
  error ('Whitened vectors have imaginary values.');
end

% Print some information to user
if b_verbose
  fprintf ('Check: covariance differs from identity by [ %g ].\n', ...
    max (max (abs (cov (newVectors') - eye (size (newVectors, 1))))));
end
