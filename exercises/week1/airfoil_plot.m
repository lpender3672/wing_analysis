clear
close all
% Program will plot you a Joukowsky airfoil

c = 0.20;
m = 0.25;
Rad = sqrt(m^2 + (1+c)^2);
np = 100;

% Defining np + 1 points around circle
theta = (0:np)*2*pi/np; % np + 1 points from 0 to 2pi
theta = theta - atan(m/(1+c)); % Ensuring kutta condition applied at trailing edge

% Defining circle in z domain
xs = -c + Rad*cos(theta);
ys = m + Rad*sin(theta);
z = xs + ys*1i;

% Transforming circle to zeetah domain
zeetah = z + z.^(-1);
x_a = real(zeetah);
y_a = imag(zeetah);



plot(x_a,y_a)
axis image