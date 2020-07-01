% A function for calculation of angel between two vectors x , y
function [theta] = Cossim(x, y)

w= dot(x,y)/(norm(x)*norm(y));
theta = acos(w);

end