clc
clear all
L1=[3 6 4 6 7 3 7 4 6 3 4 5 6 6 9 3];
%L2=[1 2 3 2 3 1 6 2 8 9 1 8 7 6 7 4];
L2=[1 2 3 2 7 3 7 4 6 3 4 5 6 6 9 3];
%L2=[7 3 1 7 2 1 3 7 1 7];
%[AR,RI,MI,HI]=RandIndex(L1,L2)
ARI=RandIndex(L1,L2)
%return
Label1=L1;
Label2=L2;
%find(L1==7)
%disp(find(L1 == 3 & L2 == 7));
%disp(length(find(L1 == 3 & L2 == 7)));
G = zeros(length(L1));
for i=1:length(L1)
	for j=1:length(L2)
		%find(L1 == Label1(i) & L2 == Label2(j))
        %disp(L1 == Label1(i));
        %if(find(L1 == Label1(i) & L2 == Label2(j))) 
        G(i,j)=length(find(L1 == Label1(i) & L2 == Label2(j)));
        %disp(length(find(L1 == Label1(i) & L2 == Label2(j))));
        %end 
        %disp(length(find(L1 == Label1(i) & L2 == Label2(j))));
	end
end
G
[c,t] = hungarian(-G);
newL2 = zeros(size(L2));
for i=1:length(L1)
    newL2(L2 == Label2(i)) = Label1(c(i));
end
newL2
%[x,y]=meshgrid(0:0.05:2,-2:0.05:2);
%z=y.^2.*(x-1).^2./(y.^2+(x-1).^2);
%mesh(x,y,z),view([-23,30]);
%ezsurf('y^2*(x-1)^2/(y^2+(x-1)^2)');
%ezsurf('y^2/(y^2+(x-1)^2)');
%=======================================================
%t=(0:.1:5/2);
%u=(0:.5:2*pi);
%x=ones(size(u))'*t;
%y=cos(u)'*(12*t-9*t.^2+2*t.^3);
%z=sin(u)'*(12*t-9*t.^2+2*t.^3);
%surf(x,y,z);
%=======================================================
%[X, Y] = meshgrid(-2:.2:2,-2:.2:2);
%Z = X.*exp(-X.^2-Y.^2);
%surfc (X, Y, Z);
%=======================================================
%t = 0:pi/10:2*pi;
%[X,Y,Z] = cylinder(2+cos(t));
%surf(X,Y,Z);
%sphere(100);
%=======================================================
%ezpolar ('1 - cos (t)');
%ezplot3('cos(t)','sin(t)','t',[0,6*pi]);
%t=0:0.05:2*pi;
%r=sin(t).*cos(t); 
%polar(t,r,'*r');
%========================================================
% generate data
	%Data = mvnrnd([5, 5],[1 1.5; 1.5 3], 100);
	%figure(1); plot(Data(:,1), Data(:,2), '+');
%center the data
	%for i = 1:size(Data,1)
	%  Data(i, :) = Data(i, :) - mean(Data);
	%end
%DataCov = cov(Data); %covariance matrix
%[PC, variances, explained] = pcacov(DataCov); %eigen
% plot principal components
%figure(2); clf; hold on;
%plot(Data(:,1), Data(:,2), '+b');
%plot(PC(1,1)*[-5 5], PC(2,1)*[-5 5], '-r')
%plot(PC(1,2)*[-5 5], PC(2,2)*[-5 5], '-b'); hold off
% project down to 1 dimension
%PcaPos = Data * PC(:, 1);