clear
close all;

% Defining x-y values of domain
x = linspace(-2.5, 2.5, 1001);
y = linspace(-2, 2, 901);

% Creation of domain meshgrid
[xm, ym] = meshgrid(x, y);

np = 100; % Number of panels of circle
R = 1; % Radius of circle

% Defining np + 1 points around circle
theta = (0:np)*2*pi/np; 
xs = R*cos(theta);
ys = R*sin(theta);

% Streamfunction for freestream
psi = ym;

% Calculating streamfunction for flow around circle

for i=1:np % Loop through panels
    
    % Set theta coordinate for start and end of panels
    theta_i = theta(i); 
    theta_ip1 = theta(i+1);
    
    % Set Cartesian coordinate for start and end of panels
    xi = R*cos(theta_i);
    yi = R*sin(theta_i);
    xip1 = R*cos(theta_ip1);
    yip1 = R*sin(theta_ip1);
    
    % Calculate start and end panel strengths from analytical formula
    gam_i = -2*sin(theta_i);
    gam_ip1 = -2*sin(theta_ip1); 

    % Find influcence coefficients over domain due to each panel
    [inf_i, inf_ip1] = panelinf_vec(xi,yi,xip1,yip1,xm,ym);
    
    % Combine influcence coefficients and strengths to give streamfunction
    psi = psi + gam_i * inf_i + gam_ip1 * inf_ip1;
end

%% Creating Contour Plot 

c = -1.75:0.25:1.75;

hold on
contour(xm,ym,psi,c);
plot(xs,ys,'color','r');
axis image;
legend('Streamlines', 'Circle')
xlabel('x') 
ylabel('y')
title('Streamlines Around Circle in Uniform Flow')

hold off

% Uncomment to save figure
% print -deps2c figure_name.eps