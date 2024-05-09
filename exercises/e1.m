
clear
close all;

disp("Hello World!")
x = linspace(-2.5, 2.5, 101);
y = linspace(-2, 2, 51);

xc = 0.5;
yc = 0.25;
Gamma = 3.0;

[xm, ym] = meshgrid(x, y);
PSI = psimat(x, y, xc, yc, Gamma);


c = -0.4:0.2:1.2;
contour(xm,ym,PSI',c);

axis image;

function psi = psimat(xarr, yarr, xc, yc, Gamma)
    psi = zeros(length(xarr), length(yarr));

    for i=1:length(xarr)
        for j=1:length(yarr)
            psi(i, j) = psipv(xc, yc, Gamma, xarr(i), yarr(j));
        end
    end
end
