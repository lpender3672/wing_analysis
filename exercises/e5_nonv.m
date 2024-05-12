clear
close all;

alpha = pi/24;

x = linspace(-2.5,2.5,1001);
y = linspace(-2,2,801);

[xm, ym] = meshgrid(x, y);

% Number of panels
np = 100;
theta = (0:np)*2*pi/np;

xs = cos(theta);
ys = sin(theta);

A = build_lhs_nonv(xs,ys);
b = build_rhs_nonv(xs,ys,alpha);

gam = A\b;

% Finding phi for flow

psi = zeros(size(xm));

for i=1:np
    [infa,infb] = panelinf_vec(xs(i),ys(i),xs(i+1),ys(i+1),xm,ym);
    psi = psi + gam(i)*infa + gam(i+1)*infb;
end

psi = psi + (ym*cos(alpha) - xm*sin(alpha));


total_circulation = trapz(gam);
disp(append('Total Circulation: ', string(total_circulation)))

c = -1.75:0.25:1.75;

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

figure(2)
plot(theta,gam)
axis([0 2*pi -2.5 2.5])
xlabel('\theta') 
ylabel('\gamma')
title('\gamma At Circle Surface')
