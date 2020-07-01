X = [105 103 103 66; 245 227 242 267;685 803 750 586;147 160 122 93; 
     193 235 184 209;156 175 147 139;720 874 566 1033; 253 265 171 143; 
     488 570 418 355; 198 203 220 187;360 365 337 334; 1102 1137 957 674;
     1472 1582 1462 1494;57 73 53 47;1374 1256 1572 1506;375 475 458 135; 54 64 62 41];
%%
 covmatrix=X*X'; 
 data = X; 
 [M,N] = size(data); 
 mn = mean(data,2);
 data = data - repmat(mn,1,N);
 Y = data' / sqrt(N-1); 
 [u,S,PC] = svd(Y);
 S = diag(S); 
 V = S .* S; 
 signals = PC' * data;
 %%
 plot(signals(1,1),0,'b.',signals(1,2),0,'b.', signals(1,3),0,'b.',signals(1,4),0,'r.','markersize',15)
 xlabel('PC1')
 text(signals(1,1)-25,-0.2,'Eng'),text(signals(1,2)-25,-0.2,'Wal'),
 text(signals(1,3)-20,-0.2,'Scot'),text(signals(1,4)-30,-0.2,'N Ire')
 plot(signals(1,1),signals(2,1),'b.',signals(1,2),signals(2,2),'b.',...
 signals(1,3),signals(2,3),'b.',signals(1,4),signals(2,4),'r.',...
 'markersize',15)
 xlabel('PC1'),ylabel('PC2')
 text(signals(1,1)+20,signals(2,1),'Eng')
 text(signals(1,2)+20,signals(2,2),'Wal')
 text(signals(1,3)+20,signals(2,3),'Scot')
 text(signals(1,4)-60,signals(2,4),'N Ire')
 plot(PC(1,1),PC(1,2),'m.',PC(2,1),PC(2,2),'m.',...
 PC(3,1),PC(3,2),'m.',PC(4,1),PC(4,2),'m.',...
 PC(5,1),PC(5,2),'m.',PC(6,1),PC(6,2),'m.',...
 PC(7,1),PC(7,2),'m.',PC(8,1),PC(8,2),'m.',...
 PC(9,1),PC(9,2),'m.',PC(10,1),PC(10,2),'m.',...
 PC(11,1),PC(11,2),'m.',PC(12,1),PC(12,2),'m.',...
 PC(13,1),PC(13,2),'m.',PC(14,1),PC(14,2),'m.',...
 PC(15,1),PC(15,2),'m.',PC(16,1),PC(16,2),'m.',...
 PC(17,1),PC(17,2),'m.','markersize',15)
 xlabel('effect(PC1)'),ylabel('effect(PC2)')
 text(PC(1,1),PC(1,2)-0.1,'Cheese'),text(PC(2,1),PC(2,2)-0.1,'Carcass meat')
 text(PC(3,1),PC(3,2)-0.1,'Other meat'),text(PC(4,1),PC(4,2)-0.1,'Fish')
 text(PC(5,1),PC(5,2)-0.1,'Fats and oils'),text(PC(6,1),PC(6,2)-0.1,'Sugars')
 text(PC(7,1),PC(7,2)-0.1,'Fresh potatoes')
 text(PC(8,1),PC(8,2)-0.1,'Fresh Veg')
 text(PC(9,1),PC(9,2)-0.1,'Other Veg')
 text(PC(10,1),PC(10,2)-0.1,'Processed potatoes')
 text(PC(11,1),PC(11,2)-0.1,'Processed Veg')
 text(PC(12,1),PC(12,2)-0.1,'Fresh fruit'),
 text(PC(13,1),PC(13,2)-0.1,'Cereals'),text(PC(14,1),PC(14,2)-0.1,'Beverages')
 text(PC(15,1),PC(15,2)-0.1,'Soft drinks'),
 text(PC(16,1),PC(16,2)-0.1,'Alcoholic drinks')
 text(PC(17,1),PC(17,2)-0.1,'Confectionery')
 %%
 bar(V)
 xlabel('eigenvector number'), ylabel('eigenvalue')
 %%
 t=sum(V);cumsum(V/t)