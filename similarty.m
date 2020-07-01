function [newL2 G] = similarty(C,dat,gnd1)

%dat = randn(50, 50);
%sim = zeros(size(dat));
%As suggested here, you could use cosine similarity, which finds the angle between two vectors. 
%Similar vectors have a value close to 1 and dissimilar vectors have a value close to 0.
% d = dot(u,v)/(norm(u)*norm(v));
ncent=size(C,1);
nRow = size(dat,1);
for j = 1:nRow
    x = dat(j, :);
    for i = 1:ncent
        y = dat(i, :);
        c = dot(x, y);
        sim(j, i) = c/(norm(x,2)*norm(y,2));
       % d = dot(u,v)/(norm(u)*norm(v));
    end
end
algnlabel = zeros(nRow,1);
for j = 1:nRow
    maxval=sim(j,1);algnlabel(j,1)=1;
    for i = 2:ncent
    if (sim(j,i)>maxval)
        maxval=sim(j,i);
        algnlabel(j,1)=i;
    end
    end
end
%Label1 = unique(gnd1);
%Label2 = unique(algnlabel);
%L1 = Label1(:);
%L2 = algnlabel(:);
G = zeros(ncent);
for i=1:ncent
	for j=1:ncent
		G(j,i) = getit(j,i,algnlabel);
	end
end

%%
[c,t] = hungarian(-G);
newL2 = zeros(nRow,1);
for i=1:nRow
  %newL2(i)=c(algnlabel(i));
  %newL2(i) = getcorindex(algnlabel(i),c);
  for t=1:ncent
    if (c(t) == algnlabel(i,1))
         newL2(i,1) =t;
    end
  end
end
%yy
%newL2'
%algnlabel'
%c
function [newval]  = getcorindex(val,c)
for t=1:size(c)
    if (c(t) == val)
        val2 = t ;
        %c(t)
        %val
        %break;
    end
end
newval = val2; 
%%
function [myval] =getit(j,i,algnlabel)
myval = 0;
%n = input('Enter a number: ');
switch i
    case 1
        %disp('negative one')
        startindex=1;endindex=150;
    case 2
        startindex=151;endindex=300;
    case 3
        startindex=301;endindex=450;
    case 4
        startindex=451;endindex=600;
    case 5
        startindex=601;endindex=750;
    case 6
        startindex=751;endindex=900;
    case 7
        startindex=901;endindex=1050;
    case 8
        startindex=1051;endindex=1200;
    case 9
        startindex=1201;endindex=1350;
    case 10
        startindex=1351;endindex=1500;    
    %otherwise
    %    startindex=451;endindex=600;
end
   
for h=startindex:endindex
    if (algnlabel(h,1)==j)
      myval=myval+1;    
    end
end
return
