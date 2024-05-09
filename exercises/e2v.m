clear
close all;

x = linspace(-2.5, 2.5, 101);
y = linspace(-2, 2, 51);

del = 1.5;

[xm, ym] = meshgrid(x, y);


[inf1,inf2] = refpaninf_vec(del,xm,ym);


c = -0.15:0.05:0.15;

hold on

contour(xm,ym,inf1,c)
contour(xm,ym,inf2,c,'--')

hold off