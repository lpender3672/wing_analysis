clear
close all;

x = linspace(-2.5, 2.5, 1001);
y = linspace(-2, 2, 901);

[xm, ym] = meshgrid(x, y);

np = 100; % not numpy but number of panels
R = 1;
alpha = pi/24;

theta = (0:np)*2*pi/np; % np + 1 points from 0 to 2pi
xs = R*cos(theta);
ys = R*sin(theta);

A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha);

gam = A\b;

psi = ym*cos(alpha) + xm*sin(alpha);

for i=1:np
    
    theta_i = theta(i);
    theta_ip1 = theta(i+1);

    xi = R*cos(theta_i);
    yi = R*sin(theta_i);
    xip1 = R*cos(theta_ip1);
    yip1 = R*sin(theta_ip1);
    gam_i = gam(i);
    gam_ip1 = gam(i+1);

    [inf_i, inf_ip1] = panelinf_vec(xi,yi,xip1,yip1,xm,ym);

    psi = psi + gam_i * inf_i + gam_ip1 * inf_ip1;
end

c = -1.75:0.25:1.75;

figure(1)
hold on
contour(xm,ym,psi,c);
plot(xs,ys);
hold off

figure(2)
plot(theta,gam)
axis([0 2*pi -2.5 2.5])
xlabel('\theta') 
ylabel('\gamma')
title('\gamma At Circle Surface')