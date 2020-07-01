clear all;close all;clc,
[fly,map] = imread('image1.bmp');
fly=double(fly);
whos
image(fly)
colormap(map)
axis off, axis equal
[m n]=size(fly);
mn = mean(fly,2);
X = fly - repmat(mn,1,n);
Z=1/sqrt(n-1)*X';
covZ=Z'*Z;
[U,S,V] = svd(covZ);
variances=diag(S).*diag(S);
bar(variances,'b')
xlim([0 20])
xlabel('eigenvector number')
ylabel('eigenvalue')
tot=sum(variances)
[[1:512]' cumsum(variances)/tot]
PCs=40;
VV=V(:,1:PCs);
Y=VV'*X;
ratio=512/(2*PCs+1)
XX=VV*Y;
XX=XX+repmat(mn,1,n);
image(XX)
colormap(map)
axis off, axis equal
z=1;
for PCs=[2 6 10 14 20 30 40 60 90 120 150 180]
VV=V(:,1:PCs);
Y=VV'*X;
XX=VV*Y;
XX=XX+repmat(mn,1,n);
subplot(4,3,z)
z=z+1;
image(XX)
colormap(map)
axis off, axis equal
title({[num2str(round(10*512/(2*PCs+1))/10) ':1 compression'];...
[int2str(PCs) ' principal components']})
end