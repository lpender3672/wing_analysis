function [psi] = approx_vortex_sheet_free(xa,ya,xb,yb,nv,gam_1,gam_2,xm,ym)
% Function to return the stream function of sheet like vortex array
%   xa: x coordinate of vortex sheet start
%   ya: y coordinate of vortex sheet start
%   xb: x coordinate of vortex sheet end
%   yb: y coordinate of vortex sheet end
%   nv: number of vortices
%   gam_1: circulation per unit length of the first vortex
%   gam_2: circulation per unit length of the last vortex
%   xm: x coordinates of the meshgrid
%   ym: y coordinates of the meshgrid


    dvortx = (xb - xa)/nv;
    dvorty = (yb - ya)/nv;
    
    vortex_strengths = sqrt((dvortx)^2+(dvorty)^2)*linspace(gam_1,gam_2,nv);

    vortex_positions_x = linspace(xa,xb - dvortx,nv) + dvortx/2;
    vortex_positions_y = linspace(ya,yb - dvorty, nv) + dvorty/2;

    psi = zeros(size(xm));
    
    for i=1:nv
        psi = psi + psipv(vortex_positions_x(i),vortex_positions_y(i),vortex_strengths(i),xm,ym);
    end
   
end