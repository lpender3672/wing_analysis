clear
close all;

np = 100; % not numpy but number of panels
R = 1; % Radius of circle
alpha = pi/24; % Incidence of uniform flow

% Defining x-y values of domain
x = linspace(-2.5,2.5,401);
y = linspace(-2,2,321);

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

% Defining np + 1 points around circle
theta = (0:np)*2*pi/np; % np + 1 points from 0 to 2pi
xs = R*cos(theta);
ys = R*sin(theta);

% Building arrays required for panel method solution
A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha);

% Solution of panel strengths
gam = A\b;

% Free stream solution to phi
psi = ym*cos(alpha) - xm*sin(alpha);

% Effect of each panel on phi
for i=1:np
    [infa,infb] = panelinf_vec(xs(i),ys(i),xs(i+1),ys(i+1),xm,ym);
    psi = psi + gam(i)*infa + gam(i+1)*infb;
end

% Mask phi in circle, patch is prefered
% mask = xm.^2 + ym .^2 > R^2;
% psi = psi .* mask;

% Comparison of toal circulation from panel method and analytical method
total_circulation = trapz( R * theta,gam);
disp(append('Total Circulation Panel Method: ', string(total_circulation)))
analytical_circulation = 4*pi*sin(-alpha); % Analytical solution for circualtion
disp(append('Total Circulation Around Circle Analytically: ',string(analytical_circulation)))
circulation_error = (total_circulation/analytical_circulation - 1)*100;
disp(append('Error in Circulation: ', string(circulation_error), '%'))

%% Plotting
c = -1.75:0.25:1.75;

% Streamline plot 
figure(1)
hold on
contour(xm,ym,psi,c);
plot(xs,ys,'color','r');
axis image;
legend('Streamlines', 'Circle')
xlabel('x') 
ylabel('y')
title(append('Streamlines Around Circle in Uniform Flow, Incidence: \alpha = ', string(alpha)))
hold off

print -deps2c exercises/week1/figures/e5_streamlines.eps

% Phi plot around circle
figure(2)
plot(theta,gam)
axis([0 2*pi -2.5 2.5])
xlabel('\theta') 
ylabel('\gamma')
title(append('\gamma or v At Circle Surface, Incidence: \alpha = ',string(alpha)))

print -deps2c exercises/week1/figures/e5_surface_profile.eps
