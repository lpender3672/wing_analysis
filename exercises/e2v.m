clear
close all;

x = linspace(-2.5, 2.5, 1001);
y = linspace(-2, 2, 901);

del = 1.5;

[xm, ym] = meshgrid(x, y);

% exact influence coefficient from integral formula
[inf1,inf2] = refpaninf_vec(del,xm,ym);

% first coefficient of influence obtained by setting gamma_1 = 1 and gamma_2 = 0
estimated_inf1 = approx_vortex_sheet(1.5,100,1,0,xm,ym);
% second coefficient of influence obtained by setting gamma_1 = 0 and gamma_2 = 1
estimated_inf2 = approx_vortex_sheet(1.5,100,0,1,xm,ym);

%% Plotting

figure;
c = -0.15:0.05:0.15;

subplot(1,2,1);
hold on;
contour(xm,ym,inf1,c);
contour(xm,ym,inf2,c, "--");
axis image;
hold off;

subplot(1,2,2);
hold on;
contour(xm,ym,estimated_inf1,c);
contour(xm,ym,estimated_inf2,c, "--");
axis image;
hold off;



