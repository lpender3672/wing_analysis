function [psi] = approx_vortex_sheet(del,nv,gam_1,gam_2,xm,ym)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    dvortx = del / nv;
    gamma_vorticies = dvortx*linspace(gam_1,gam_2, nv);
    vortex_positions = linspace(0, del - dvortx, nv) + dvortx / 2;

    psi = zeros(size(xm));

    for i=1:nv
        psi = psi + psipv(vortex_positions(i),0,gamma_vorticies(i),xm,ym); 
    end

end