function [psi] = approx_vortex_sheet(del,nv,gam_a,gam_b,xm,ym)
% Function to return the stream function of sheet like vortex array
%   del: length of the vortex sheet
%   nv: number of vortices
%   gam_1: circulation per unit length of the first vortex
%   gam_2: circulation per unit length of the last vortex
%   xm: x coordinates of the meshgrid
%   ym: y coordinates of the meshgrid

    dvortx = del / nv; % distance between vortices
    gamma_vorticies = dvortx*linspace(gam_a,gam_b, nv);

    % vorticies are placed in the middle of a sheet element
    vortex_positions = linspace(0, del - dvortx, nv) + dvortx / 2;

    psi = zeros(size(xm)); % initialize psi

    for i=1:nv
        psi = psi + psipv(vortex_positions(i),0,gamma_vorticies(i),xm,ym); 
    end

end