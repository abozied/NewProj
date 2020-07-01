function L0_Norm
%I am interested to plot the L0-norm penalty function in matlab.
%In fact, I know that the L0-norm of a vector x, ||x||_0, returns a value which designates 
%the total number of nonzero elements in x. In other terms, ||x||_0 = #(i | xi !=0).
%For example, for the L1-norm of x, it returns the sum of the absolute values of the elements in x.
%The matlab code to plot the L_1 norm penalty function is:

clear all;
clc;
x = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
penal = zeros (length(x),1);
lambda = 2; % the tuning parameter
%for ii = 1 : length(x)
%penal(ii) = lambda*abs(x(ii));
%penal(ii) = lambda*(x(ii) ~= 0);
%end
penal = lambda*(x ~= 0);
%penal = lambda*abs(x);
figure
plot(x(:), penal(:), 'r');

%But now what about the L_0 norm??
%Any help will be very appreciated!
%Replace the line inside the for loop with the following:
%penal(ii) = lambda*(x(ii) ~= 0);
%This assigns a penalty of lambda for all non-zero values in the vector x.
%BTW, you could avoid for loop by using penal = lambda*(x ~= 0);, or penal = lambda*abs(x);. 
%This would be much more efficient for high dimensional vectors. – Prakhar Jul 18 '16 at 22:15 	 	
%Thank you so much! – Christina Jul 18 '16 at 22:25

end

