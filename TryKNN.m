%Program to find the k - nearest neighbors (kNN) within a set of points. 
%Distance metric used: Euclidean distance
%Usage: 
%[neighbors distances] = kNearestNeighbors(dataMatrix, queryMatrix, k); 
%dataMatrix (N x D) - N vectors with dimensionality D (within which we search for the nearest neighbors) 
%queryMatrix (M x D) - M query vectors with dimensionality D 
%k (1 x 1) - Number of nearest neighbors desired
%Example: 
%a = [1 1; 2 2; 3 2; 4 4; 5 6]; 
%b = [1 1; 2 1; 6 2]; 
%[neighbors distances] = kNearestNeighbors(a,b,2)
%Output: 
%neighbors = 
%1 2 
%1 2 
%4 3
%distances = 
%0 1.4142 
%1.0000 1.0000 
%2.8284 3.0000


sample = [1 1; 2 2; 3 2; 4 4; 5 6]; 
training = [1 1; 2 1; 6 2]; 
group = [1;2;3]
class = knnclassify(sample, training, group)
%sample = [.9 .8;.1 .3;.2 .6]
%sample =
%    0.9000    0.8000
%    0.1000    0.3000
%    0.2000    0.6000
%training=[0 0;.5 .5;1 1]
%training =
%         0         0
%    0.5000    0.5000
%    1.0000    1.0000
%group = [1;2;3]
%group =
%     1
%     2
%     3
%class = knnclassify(sample, training, group)
%class =
%     3
%     1
%     2
