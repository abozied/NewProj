function [WiegH]=SentScore(A,W,H)
clc; echo off ;
%===================================================================%
fprintf('S.Park GRS   \n');
%====================== S.Park Algorithm ===========================%
%====================== GRS Sentence Score =========================%
[R1 C1]= size(H);
Hi =zeros(R1);
clear S;
double Sum_Hi;
double Sum_matrix;
Sum_matrix=0;
%get the sum of all elements  of matrix H in (Sum_matrix)
%and sum of Row Hi* and put it in Hi array 
for i=1:R1
  Sum_Hi=0;
      for j=1:C1
           Sum_Hi=Sum_Hi+H(i,j);
      end
    Hi(i)=Sum_Hi;
    Sum_matrix = Sum_matrix + Hi(i);
end
for j=1:C1
    S(j)=0;
    for i=1:R1
        %calculate the Score of each Column S(j)
          S(j)=S(j)+H(i,j)*(Hi(i)/Sum_matrix);
    end
end
for j=1:C1
    S(j)=round(100000*S(j));
    fprintf('%d     \n',S(j));
end
%==========================================================================
fprintf('Petrovskiy  \n');
%=====================  Mikhail Petrovskiy     ===========================%
%================== Eclidean Norm 2 Sentence Score =======================%
[L R]= size(W);
Wik =zeros(R);
double Sum_Wik;
for k=1:R
   QQW=W(:,k);
   Wik(k)=norm(QQW,2);
     %Sum_Wik=0; 
     % for i=1:L
     %      Sum_Wik=Sum_Wik+(W(i,k))^2;
     % end
     %if (Wik(k)-sqrt(Sum_Wik)<=.1)
     %    fprintf('Gooooooooood  Boooooooy  \n');
     %end
end
[R G]= size(H);
Hkj =zeros(R);
double Sum_Hkj;
for k=1:R
    QQH=H(k,:);
    Hkj(k)=norm(QQH,2);
  %Sum_Hkj=0;
     % for j=1:G
     %      Sum_Hkj=Sum_Hkj+(H(k,j))^2;
     % end
      %Hkj(k)=sqrt(Sum_Hkj);
     %if (Hkj(k)-sqrt(Sum_Hkj)<=.1)
     %  fprintf('Gooooooooood  Boooooooy  \n');
     %end
end
[R1 C1]= size(H);
WeightedH =eye(R1);
double stscore;
for i=1:R1
      for j=1:R1
           if(i==j) 
               WeightedH(i,j)=((Wik(i))^2)*Hkj(i);
           end
      end
end
NewH=zeros(R1,C1);
NewH= WeightedH*H;
clear SS;
for j=1:C1
    SS(j)=0;
    for i=1:R1
          SS(j)=SS(j)+NewH(i,j);
    end
end
for j=1:C1
    SS(j)=round(100*SS(j));
    fprintf('%d     \n',SS(j));
end
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


