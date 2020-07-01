function [WiegH]=PetrovScore(W,H)
%==========================================================================
fprintf('Petrovskiy  \n');
%=====================  Mikhail Petrovskiy     ===========================%
%================== Eclidean Norm 2 Sentence Score =======================%
[R1 C1]= size(H);
WiegH=zeros(R1,C1);
[L R]= size(W);
Wik =zeros(R);
double Sum_Wik;
for k=1:R
   QQW=W(:,k);
   Wik(k)=norm(QQW,2);
end
[R G]= size(H);
Hkj =zeros(R);
double Sum_Hkj;
for k=1:R
    QQH=H(k,:);
    Hkj(k)=norm(QQH,2);
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
WiegH= WeightedH*H;

%==========================================================================
%==========================================================================
%--------------------------------END---------------------------------------
%==========================================================================
end


