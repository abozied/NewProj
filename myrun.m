clear all;
clc; echo off ;   
cpath = 'C:\Learn_Java\Research\ArabicClustering\TFIDFDoc_Term_Matrix';
fname= cpath; 
sfile = strcat(fname,'.dat');
fea=load (sfile);
%fea=[1 2 3 ; 3 4 5];
[N M]= size(fea);
nClass = 14;
gnd=ones(10688,1);
for i=1 : 10688
    if (i>=1 && i<=837)  
        gnd(i)=1;
    end
    if (i>=838 && i<=1796)  
        gnd(i)=2;
    end    
    if (i>=1797 && i<=2543)  
        gnd(i)=3;
    end 
    if (i>=2544 && i<=3072)  
        gnd(i)=4;
    end
    if (i>=3073 && i<=3811)  
        gnd(i)=5;
    end
    if (i>=3812 && i<=4285)  
        gnd(i)=6;
    end
    if (i>=4286 && i<=5270)  
        gnd(i)=7;
    end
    if (i>=5271 && i<=6192)  
        gnd(i)=8;
    end
    if (i>=6193 && i<=6877)  
        gnd(i)=9;
    end
    if (i>=6878 && i<=7632)  
        gnd(i)=10;
    end
    if (i>=7633 && i<=8189)  
        gnd(i)=11;
    end
    if (i>=8190 && i<=9133)  
        gnd(i)=12;
    end
    if (i>=9134 && i<=9859)  
        gnd(i)=13;
    end
    if (i>=9860 && i<=10688)  
        gnd(i)=14;
    end
end
%save('Arabic_Corpus_TFIDF.mat','fea','gnd')
save Arabic_Corpus_TFIDF_20.mat fea gnd -v7.3

