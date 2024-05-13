
clear
close all;

% Defining domain
x = linspace(-2.5, 2.5, 101);
y = linspace(-2, 2, 51);

% Setting position of point vortex
xc = 0.5;
yc = 0.25;
Gamma = 3.0;

% creating meshgrid of domain and streamfunction
[xm, ym, PSI] = psi_meshgrid(x, y, xc, yc, Gamma);

% contour plot
c = -0.4:0.2:1.2;
set(gcf,'PaperPositionMode','auto')
contour(xm,ym,PSI,c);
xlabel('x') 
ylabel('y')
title(append('Contour Plot of \psi Due to Point Vortex at ',"(",string(xc),",",string(yc),")"))
axis image;


function [xm, ym, psi] = psi_meshgrid(xarr, yarr, xc, yc, Gamma)
%   Returns meshgrid and streamfunction of domain due to point vortex
%   xarr: array of x-positions in domain
%   yarr: array of y-positions in domain
%   xc: x-position of point vortex
%   yc: y-position of point vortex
%   Gamma: Strength of point vortex
    nx = length(xarr);
    ny = length(yarr);
    psi = zeros(nx, ny);
    xm = zeros(nx, ny);
    ym = zeros(nx, ny);

    xmin = xarr(1);
    xmax = xarr(end);
    ymin = yarr(1);
    ymax = yarr(end);

    for i=1:nx
        for j=1:ny
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            psi(i, j) = psipv(xc, yc, Gamma, xarr(i), yarr(j));
        end
    end
end
