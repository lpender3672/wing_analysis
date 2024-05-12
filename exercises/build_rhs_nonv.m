function rhsvec = build_rhs_nonv(xs,ys,alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

np = length(xs) - 1;

rhsvec = zeros(np+1,1);

for i=1:np-1
    rhsvec(i) = (ys(i)*cos(alpha) - xs(i)*sin(alpha)) - (ys(i+1)*cos(alpha) - xs(i+1)*sin(alpha));
end

