%{
...
Block of COMMENTS HERE
...
...
%}
%CODE GOES HERE
clc
clear all
nClass=3;
L1=[1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3]; %Known Group
L2=[2 2 3 2 2 2 2 1 3 3 3 1 1 3 3 2 1 1 1 1 3 3 1 1]; %Unknown Group
Label1 = unique(L1);
nClass1 = length(Label1);
Label2 = unique(L2);
nClass2 = length(Label2);
%G = crosstab(gnd,L2)
G =confusionmat(L1,L2)
%Calculate new idex of the result label by the hungarian algorithm
[c,t] = hungarian(-G);
newL2 = zeros(size(L2));
for i=1:nClass2
    %adjust the result label by the new index calculated by hungarian algorithm
    newL2(L2 == Label2(i)) = Label1(c(i));
end
M = crosstab(L1,newL2) % you can use also use "confusionmat"
nc = sum(M,1);
mc = max(M,[],1);
purity = sum(mc(nc>0))/sum(nc)

MIhat = MutualInfo(L1,newL2);
%MIhat = MutualInforn(L1,newL2);
AC = length(find(L1 == newL2))/length(L1);
disp(['Kmeans in the originall space normalized mutual information:',num2str(MIhat)]);
disp(['Kmeans in the original space accuracy:',num2str(AC)]);

%http://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-clustering-1.html)
%load fisheriris
%a = grp2idx(species);
%d = pdist(meas);
%z = linkage(d,'average');
%b = cluster(z,3);
%a
%b
%M = crosstab(a,b) % you can use also use "confusionmat"
%nc = sum(M,1);
%mc = max(M,[],1);
%purity = sum(mc(nc>0))/sum(nc)

%% Try This from the paper of  Spectral Clustering of High-dimensional Data
X=[1 1 2 3 4 ;0 1 0 1 2 ; 2 0 4 4 2 ; 3 0 6 6 3];
B= [ 1 1 ; 0 1 ; 2 0; 3 0];
C= [1 0 2 2 1; 0 1 0 1 2];
B*C
