clear
close all;

% Defining x-y values of domain
x = linspace(0,5,1001);
y = linspace(0,4,801);

% Creation of domain meshgrid
[xm,ym] = meshgrid(x,y);

% Start point of vortex sheet
xa = 3.5;
ya = 2.5;

% End point of vortex sheet
xb = 1.6;
yb = 1.1;

% Exact influence coefficient from integral formula
[infa_exact,infb_exact] = panelinf_vec(xa,ya,xb,yb,xm,ym);

% Number of vorticies making vortex sheet approximation
nv = 100;

% First coefficient of influence estimated by setting gamma_a = 1 and gamma_b = 0
gam_a = 1;
gam_b = 0;
infa_approx = approx_vortex_sheet_free(xa,ya,xb,yb,nv,gam_a,gam_b,xm,ym);
% Second coefficient of influence estimated by setting gamma_a = 0 and gamma_b = 1
gam_a = 0;
gam_b = 1;
infb_approx = approx_vortex_sheet_free(xa,ya,xb,yb,nv,gam_a,gam_b,xm,ym);

% Vortex sheet positions for plotting
x_sheet = linspace(xa,xb,10);
y_sheet = linspace(ya,yb,10);


%% Plotting

c = -0.15:0.05:0.15;

figure(1);

hold on;
contour(xm,ym,infa_exact,c);
contour(xm,ym,infb_exact,c, "--");
plot(x_sheet,y_sheet,'color','r') % Plotting vortex sheet
axis image;
legend('f_{a} Contour', 'f_{b} Contour','Vortex Sheet')
hold off;
xlabel('x') 
ylabel('y')
title('Contours of \psi From Vortex Sheet Integral Formula')

print -deps2c exercises/week1/figures/e3_coeff_exact.eps

figure(2);

hold on;
contour(xm,ym,infa_approx,c);
contour(xm,ym,infb_approx,c, "--");
plot(x_sheet,y_sheet,'color','r') % Plotting vortex sheet
legend('f_{a} Contour', 'f_{b} Contour','Vortex Sheet')
axis image;
hold off;
xlabel('x') 
ylabel('y')
title(append('Contours of \psi From ', string(nv), ' Finite Vorticies'))


print -deps2c exercises/week1/figures/e3_coeff_approx.eps
