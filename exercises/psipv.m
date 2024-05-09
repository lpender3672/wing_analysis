function [streamfunc_xy] = psipv(xc,yc,Gamma,x,y)
%psipv returns streamfunction at a point due point vortex
%   Returns the value of the streamfunction at a point (x,y) due to a point
%   vortex strength Gamma placed at (xc,yc)
streamfunc_xy = (-Gamma/(4*pi))*log((x - xc).^2 + (y - yc).^2);
end

