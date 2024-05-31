
clear all
global alpha Re_L np id


% define global variables to optimise at
alpha = 0;
Re_L = 3e6;
np = 100;
id = 'opt';

% define initial aerofoil conditions
initial_y_points = [0.2, 0.1];

% define optimsation options
options = optimset('Display', 'iter', 'MaxFunEvals', 1000, 'TolFun', 1e-6);
best_y_points = fminsearch(@bezier2d, initial_y_points, options);

% display best geometry parameters
best_y_points

% compute lift to drag ratio at best geometry parameters
clcd = bezier2d(best_y_points);
-clcd

% save optimal geomtry to .surf file
upper_pts = [   0, 0, 0.5, 1;
    0, 0.2, best_y_points(1), 0];

lower_pts = [   0, 0, 0.5, 1;
    0, -0.1, best_y_points(2), 0];

pts = bezier(upper_pts, lower_pts, np, id);

% plot optimal foil shape
hold on
plot(pts(1,:), pts(2,:))
axis equal
hold off