function [value]=psogv(fun,range,ITER)

%psogv.m
%Particle swarm algorithm for maximizing the function fun with two variables x
%and y.
%Syntax
%[value]=psogv(fun,range,ITER)
%example
%fun='f1'
%create the function fun.m
%function [res]=fun(x,y)
%res=sin(x)+cos(x);
%range=[-pi pi;-pi pi];
%ITER is the total number of Iteration
error=[];
vel1=[];
vel2=[];

%Intialize the swarm position
swarm=[];
x(1)=rand*range(1,2)+range(1,1);
y(1)=rand*range(2,2)+range(2,1);
x(2)=rand*range(1,2)+range(1,1);
y(2)=rand*range(2,2)+range(2,1);

%Intialize weight
w=1;
c1=2;
c2=2;
%Initialize the velocity
v1=0;%velocity for x
v2=0;%velocity for y


for i=1:1:ITER
    [p,q]=min([f1(fun,x(2),y(1)), f1(fun,x(1),y(2))]);

    if (q==1)
    capture=x(2);
    else
    capture=y(2);
    end

    v1=w*v1+c1*rand*(x(2)-x(1))+c2*rand*(capture-x(1));
    v2=w*v2+c1*rand*(y(2)-y(1))+c2*rand*(capture-y(1));
    vel1=[vel1 v1];
    vel2=[vel2 v2];

    %updating x(1) and y(1)
    x(1)=x(1)+v1;
    y(1)=y(1)+v2;

    %updating x(2) and y(2)
    if((f1(fun,x(2),y(1)))<=(f1(fun,x(1),y(1))))
    x(2)=x(2);
    else
    x(2)=x(1);
    end;

    if((f1(fun,x(1),y(2)))<=(f1(fun,x(1),y(1))))
    y(2)=y(2);
    else
    y(2)=y(1);
    end

    error=[error f1(fun,x(2),y(2))];
    w=w-w*i/ITER;
    swarm=[swarm;x(2) y(2)];
    subplot(3,1,3)
    plot(error,'-')
    title('Error(vs) Iteration');
    subplot(3,1,1)
    plot(swarm(:,1),'-')
    title('x (vs) Iteration');
    subplot(3,1,2)
    plot(swarm(:,2),'-')
    title('y (vs) Iteration');
    pause(0.2)
end

value=[x(2);y(2)];
