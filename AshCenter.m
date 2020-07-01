function [z_c , mean_z] =  AshCenter(z)

mean_z = mean(z,2);
[ n m ]=size(z);
z_c=zeros(n,m);
    for j=1:m
        z_c(:,j)=z(:,j)-mean_z;
    end
end

