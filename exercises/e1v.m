
clear
close all;

x = linspace(-2.5, 2.5, 101);
y = linspace(-2, 2, 51);

xc = 0.5;
yc = 0.25;
Gamma = 3.0;

[xm, ym] = meshgrid(x, y);
psi = psipv(xc, yc, Gamma, xm, ym);

c = -0.4:0.2:1.2;
contour(xm,ym,psi,c);
axis image;