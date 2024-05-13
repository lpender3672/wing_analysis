clear
close all;

% Defining x-y values of domain
x = linspace(-2.5, 2.5, 1001);
y = linspace(-2, 2, 901);

% Defining length of vortex sheet
del = 1.5;

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

% Exact influence coefficient from integral formula
[inf1,inf2] = refpaninf_vec(del,xm,ym);

% Number of vorticies making vortex sheet approximation
nv = 100;

% First coefficient of influence estimated by setting gamma_a = 1 and gamma_b = 0
gam_a = 1;
gam_b = 0;
estimated_inf1 = approx_vortex_sheet(del,nv,gam_a,gam_b,xm,ym);
% Second coefficient of influence estimated by setting gamma_a = 0 and gamma_b = 1
gam_a = 0;
gam_b = 1;
estimated_inf2 = approx_vortex_sheet(del,nv,gam_a,gam_b,xm,ym);

% Vortex sheet positions for plotting
x_sheet = linspace(0,del,10);
y_sheet = zeros(length(x_sheet));

%% Creating Contour Plot

figure;
c = -0.15:0.05:0.15;

subplot(1,2,1);
hold on;
contour(xm,ym,inf1,c);
contour(xm,ym,inf2,c, "--");
plot(x_sheet,y_sheet,'color','r') % Plotting vortex sheet
axis image;
legend('f_{a} Contour', 'f_{b} Contour','Vortex Sheet')
hold off;
xlabel('x') 
ylabel('y')
title('Contours of \psi From Vortex Sheet Integral Formula')

subplot(1,2,2);
hold on;
contour(xm,ym,estimated_inf1,c);
contour(xm,ym,estimated_inf2,c, "--");
plot(x_sheet,y_sheet,'color','r') % Plotting vortex sheet
legend('f_{a} Contour', 'f_{b} Contour','Vortex Sheet')
axis image;
hold off;
xlabel('x') 
ylabel('y')
title(append('Contours of \psi From ', string(nv), ' Finite Vorticies'))

% Uncomment to save figure
% print -deps2c figure_name.eps