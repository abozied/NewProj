function [newL2] = bestMap(L1,L2)
%bestmap: permute labels of L2 to match L1 as good as possible
%   [newL2] = bestMap(L1,L2);
%   version 2.0 --May/2007
%   version 1.0 --November/2003
%   Written by Deng Cai (dengcai AT gmail.com)
%==========================================================================    
L1 = L1(:);
L2 = L2(:);
if size(L1) ~= size(L2)
    error('size(L1) must == size(L2)');
end
Label1 = unique(L1);
%Label1'
%L1'
nClass1 = length(Label1);
Label2 = unique(L2);
%Label2'
%L2'
nClass2 = length(Label2);
nClass = max(nClass1,nClass2);
G = zeros(nClass);
for i=1:nClass1
	for j=1:nClass2	
        %Tind the Number(length) of label pairs which are simillar in original labling
        %and result labeling then put this length in the elenment of G(i,j) Matrix
        G(i,j) = length(find(L1 == Label1(i) & L2 == Label2(j)));
        %disp( length(find(L1 == Label1(i) & L2 == Label2(j))));
	end
end
%Calculate new idex of the result label by the hungarian algorithm
[c,t] = hungarian(-G);
newL2 = zeros(size(L2));
for i=1:nClass2
    %adjust the result label by the new index calculated by hungarian algorithm
    newL2(L2 == Label2(i)) = Label1(c(i));
end
%newL2