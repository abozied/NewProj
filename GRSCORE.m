function [WiegH]=GRSCORE(H)
echo off ;
%===================================================================%
fprintf('S.Park GRS   \n');
%====================== S.Park Algorithm ===========================%
%====================== GRS Sentence Score =========================%
[R1 C1]= size(H);
Hi =zeros(R1);
WiegH=zeros(R1,C1);
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
    %S(j)=0;
    for i=1:R1
        %calculate the Score of each Column S(j)
         % S(j)=S(j)+H(i,j)*(Hi(i)/Sum_matrix);
          WiegH(i,j)=H(i,j)*(Hi(i)/Sum_matrix);
    end
end
%for j=1:C1
%    S(j)=round(100000*S(j));
%    fprintf('%d     \n',S(j));
%end
%==========================================================================
%--------------------------------END---------------------------------------
%==========================================================================
end


