clear all; close all; clc;
 set(0,'defaultfigureposition',[40 320 540 300],'defaultaxeslinewidth',0.9,'defaultaxesfontsize',8,...
 'defaultlinelinewidth',1.1,'defaultpatchlinewidth',1.1,'defaultlinemarkersize',15), format compact, format short
 x=[0:0.01:20]';
 signalA = @(x) sin(x);
 signalB = @(x) 2*mod(x/10,1)-1;
 signalC = @(x) -sign(sin(0.25*pi*x))*0.5;
 Z=[signalA(x) signalB(x) signalC(x)];

 [N M]=size(Z);
 Z=Z+0.02*randn(N,M);
 [N M]=size(Z);
 A=round(10*randn(3,3)*1000)/1000
 X0=A*Z';
 X=X0';
 
 figure
 subplot(2,2,1)
 plot(X,'LineWidth',2)
 xlim([0,2000])
 xlabel('x'),ylabel('y','Rotation',0)
 
 [u,s,v] = svd(X,0);
 
 
 subplot(2,2,2)
 plot(u(:,1),'b','LineWidth',2)
 xlim([0,2000])
 xlabel('x'),ylabel('y','Rotation',0)
 
 subplot(2,2,3)
 plot(u(:,2),'g','LineWidth',2)
 xlim([0,2000])
 xlabel('x'),ylabel('y','Rotation',0)
 
 subplot(2,2,4)
 plot(u(:,3),'r','LineWidth',2)
 xlim([0,2000])
 xlabel('x'),ylabel('y','Rotation',0)