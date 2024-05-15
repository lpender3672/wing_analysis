clear 
close all 
% Streamlines around Joukowsky Airfoil

np = 100; % not numpy but number of panels
alpha = pi/24; % Incidence of uniform flow
c = 0.15; % Sets slenderness of airfoil (smaller, more slender)
m = 0.25; % Sets camber of airfoil (larger, more camber)
Rad = sqrt(m^2 + (1+c)^2); % Radius of circle in z domain

% Defining x-y values of domain
x = linspace(-2.5,2.5,401);
y = linspace(-2,2,321);

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

% Defining np + 1 points around circle
theta = (0:np)*2*pi/np; % np + 1 points from 0 to 2pi
theta = theta - atan(m/(1+c)); % Ensuring kutta condition applied at trailing edge

% Defining circle in z domain
xs = -c + Rad*cos(theta);
ys = m + Rad*sin(theta);
z = xs + ys*1i;

% Transforming circle to zeetah domain
zeetah = z + z.^(-1);
xs = real(zeetah);
ys = imag(zeetah);

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

% I think the circulation is perseved in the transform
total_circulation = 0;
for i=1:np
    total_circulation = total_circulation + sqrt((xs(i+1) - xs(i))^2 + (ys(i+1)- ys(i))^2)*(gam(i)+gam(i+1))/2;
end

disp(append('Total Circulation Panel Method: ', string(total_circulation)))


%% Plotting
c = -2:0.15:3;

% Streamline plot 
figure(1)
hold on
contour(xm,ym,psi,c);
plot(xs,ys,'color','r');
axis image;
legend('Streamlines', 'Airfoil')
xlabel('x') 
ylabel('y')
title(append('Joukowski Airfoil Streamlines, Incidence: \alpha = ', string(alpha)))
hold off

print -deps2c exercises/week1/figures/joukowski_airfoil.eps