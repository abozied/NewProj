function [res]=f1(fun,x,y)
s=strcat(fun,'(x,y)');
%disp(s);
res=eval(s);
end