function [WiegH]=Entropy_GRS(A,W,H)
clc; echo off ;
%==========================================================================
fprintf('Entropy GRS  \n');
%=====================     ENTROPY Algorithm  =============================
%=============== Entropy of norm 2 (GRS)  as sentence Score =================
[R G]= size(H);
Hkj =zeros(R);
SX=zeros(1,G);
double Sum_Hkj;
Sum_Hkj=0;
%get the sum of all elements in matrix H
for k=1:R
           QQH=H(k,:);
           Hkj(k)=norm(QQH,2);
           Sum_Hkj=Sum_Hkj+Hkj(k);
end
double P;
for j=1:G
    SX(j)=0;
    P=0;
    for i=1:R1
          P=(Hkj(i)/Sum_Hkj); %get the relative important to the sum of all
          %%%%
          % i will write code here
          %%%% or here
          SX(j)=SX(j)+H(i,j)*(P*(-log2(P)));      
    end
end
for j=1:C1
    %Magnify the Score here
    SX(j)=round(1000000*SX(j));
    %fprintf('%d   %d \n',j,round(100*S(j)));
     fprintf('%d     \n',SX(j));   
end
%==========================================================================
%--------------------------------END---------------------------------------
%==========================================================================
end


