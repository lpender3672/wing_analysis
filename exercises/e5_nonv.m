clear
close all;

% Setting angle of incidence of flow
alpha = pi/24;

% Defining x-y values of domain
x = linspace(-2.5,2.5,401);
y = linspace(-2,2,321);

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

% Number of panels
np = 100;

% Defining np + 1 points around circle
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);

% Building required vectors for solving for panel strengths
A = build_lhs_nonv(xs,ys);
b = build_rhs_nonv(xs,ys,alpha);

% Solving for panel strengths
gam = A\b;

% Finding phi for flow over full domain
psi = zeros(size(xm));

% Effect of panels on phi
for i=1:np
    [infa,infb] = panelinf_vec(xs(i),ys(i),xs(i+1),ys(i+1),xm,ym);
    psi = psi + gam(i)*infa + gam(i+1)*infb;
end

% Effect of uniform flow on phi
psi = psi + (ym*cos(alpha) - xm*sin(alpha));

mask = xm.^2 + ym .^2 > R^2;
psi = psi .* mask;

% Comparison of toal circulation from panel method and analytical method
total_circulation = trapz(theta,gam);
disp(append('Total Circulation Panel Method: ', string(total_circulation)))
analytical_circulation = 4*pi*sin(-alpha);
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
title('Streamlines Around Circle in Uniform Flow')
hold off

% Phi plot around circle
figure(2)
plot(theta,gam)
axis([0 2*pi -2.5 2.5])
xlabel('\theta') 
ylabel('\gamma')
title('\gamma At Circle Surface')
