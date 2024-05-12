function psixy = psipv(xc,yc,Gamma,x,y)
    %   Returns streamfunction at a point due point vortex
    %   xc: x-position of point vortex
    %   yc: y-position of point vortex
    %   Gamma: Stregnth of point vortex
    %   x: x-positions for which streamfunction should be found
    %   y: y-positions for which streamfunction should be found
    %   psixy: streamfunction at specified positions
    psixy = (-Gamma/(4*pi))*log((x - xc).^2 + (y - yc).^2);
end

