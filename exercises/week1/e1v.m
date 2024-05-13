
clear
close all;

% Defining x-y values of domain
x = linspace(-2.5, 2.5, 51);
y = linspace(-2, 2, 41);

% Setting position and strength of point vortex
xc = 0.5;
yc = 0.25;
Gamma = 3.0;

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

% Using vectorial function to generate streamfunction over domain
psi = psipv(xc, yc, Gamma, xm, ym);

%% Creating contour plot
c = -0.4:0.2:1.2; % Contour levels

set(gcf,'PaperPositionMode','auto')

hold on
contour(xm,ym,psi,c); 
plot(xc,yc,'.','color','r','MarkerSize',10) % Point of vortex
legend('\psi contour','Vortex Position')
hold off

xlabel('x') 
ylabel('y')
title(append('Contour Plot of \psi Due to Point Vortex at ',"(",string(xc),",",string(yc),")"))
axis image;

print -deps2c exercises/week1/figures/e1_vortex_streamlines.eps
