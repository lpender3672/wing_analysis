clear
close all;

x = linspace(0,5,1001);
y = linspace(0,4,801);

[xm,ym] = meshgrid(x,y);

% exact influence coefficient from integral formula
[infa_exact,infb_exact] = panelinf_vec(3.5,2.5,1.6,1.1,xm,ym);

% first coefficient of influence estimated by setting gamma_1 = 1 and gamma_2 = 0
infa_approx = approx_vortex_sheet_free(3.5,2.5,1.6,1.1,100,1,0,xm,ym);
% second coefficient of influence estimated by setting gamma_1 = 0 and gamma_2 = 1
infb_approx = approx_vortex_sheet_free(3.5,2.5,1.6,1.1,100,0,1,xm,ym);

%% Plotting

figure;
c = -0.15:0.05:0.15;


subplot(1,2,1);
hold on;
contour(xm,ym,infa_exact,c);
contour(xm,ym,infb_exact,c, "--");
axis image;
hold off;

subplot(1,2,2);
hold on;
contour(xm,ym,infa_approx,c);
contour(xm,ym,infb_approx,c, "--");
axis image;
hold off;

