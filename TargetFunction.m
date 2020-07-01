function z= TargetFunction(x)
z = (4 - 2.1*x(1)^2 + x(1)^4/3)*x(1)^2 + x(1)*x(2) +(-4 + 4*x(2)^2)*x(2)^2;
%The above function is known as 'cam' as described in L.C.W. Dixon and G.P. Szego (eds.), Towards Global Optimisation 2, North-Holland, Amsterdam, 1978.

%z=sum(x.^2);
%z=x(1)^2+x(2)^2+x(3)^2+x(4)^2+x(5)^2;
%z= abs(x(1)+1/x(2)) ;

end
