clc
%example
fun='f1'
range=[-pi pi;-pi pi];
%ITER is the total number of Iteration
ITER=10
[value]=psogv(fun,range,ITER)