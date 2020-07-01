function main()
Img=imread('1.bmp');%please download at above link
Img=double(Img(:,:,1));    
%% Initial boundary
c0=2;  %const value
phi = ones(size(Img(:,:,1))).*c0;
phi(26:32,28:34) = -c0;    
%% Heaviside function
epsilon=1
Hu=0.5*(1+(2/pi)*atan(phi./epsilon));

%% Inside and outside image
inImg=Img.*(1-Hu);
outImg=Img.*(Hu);
%% Let caclulate KL distance
h1 =  histogram(inImg, 256, 0, 255); %Histogram of inside
h2 =  histogram(outImg, 256, 0, 255);%Histogram of outside
lamda1=KLdist(h1,h2) % distance from h1 to h2
lamda2=KLdist(h2,h1) % distance from h2 to h1
end

%%%%%%%%%% function for KL distance%%%%%%%%%%%%%%%
function [d1,d2]=KLdist(h1,h2)
d1=sum(h1.*log2(h1+eps)-h1.*log2(h2+eps))
d2=sum(h2.*log2(h2+eps)-h2.*log2(h1+eps))
end
%%%%%%%%%%function for histogram calculation%%%%%%
function [h,bins] = histogram(I, n, min, max)
I = I(:);    
range = max - min;
drdb = range / double(n); % dr/db - change in range per bin    
h = zeros(n,1);
bins = zeros(n,1);
for i=1:n
    % note: while the instructions say "within integer round off" I'm leaving
    %       this as float bin edges, to handle the potential float input
    %       ie - say the input was a probability image.
    low = min + (i-1)*drdb; 
    high = min + i*drdb;
    h(i) = sum( (I>=low) .* (I<high) );
  bins(i) = low;
end    
h(n) = h(n) + sum( (I>=(n*drdb)) .* (I<=max) ); % include anything we may have missed in the last bin.

h = h ./ sum(h); % "relative frequency"  
end