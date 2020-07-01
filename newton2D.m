function newton2D()
clc
close all
x=-10:0.1:10;
y=-10:0.1:10;
[xx,yy]=meshgrid(x,y);
zz=f(xx,yy);
mesh(xx,yy,zz);
%%%f=0
ro=[10;10];%initial guess on x is 10 and my initial guess on is 10
alfa=0.2;
while abs(f(ro(1),ro(2)))> 1e-2
    ro =ro-alfa*f(ro(1),ro(2))./fprime(ro(1),ro(2));
end
ro
f(ro(1),ro(2))
hold on
plot3 (ro(1),ro(2),0,'rs','MarkerSize',20);
theta = linspace(0,2*pi,100);
r=5;
xc=r*cos(theta);
yc=r*sin(theta);
plot3 (xc,yc,0*xc,'r-','LineWidth',5);


%Find the minimum
ro=[10;10];%initial guess on x is 10 and my initial guess on is 10
alfa=0.2;
for index=1:100
    ro =ro-alfa*inv(fdblprime(ro(1),ro(2)))*fprime(ro(1),ro(2));
end
ro
f(ro(1),ro(2))
hold on
plot3 (ro(1),ro(2),f(ro(1),ro(2)),'ys','MarkerSize',20);


function z=f(x,y)
z=x.^2+y.^2-5^2;

function zprime=fprime(x,y)
%%Find the Gradient which is a vector
dfdx=2*x;
dfdy=2*y;
zprime=[dfdx;dfdy];

function zdblprime = fdblprime(x,y)
%Find the Jacobian which is a matrix
df2dx2=2;
df2dxdy=0;
df2dy2=2;
df2dydx=0;
zdblprime=[df2dx2 df2dxdy ; df2dydx df2dy2];

