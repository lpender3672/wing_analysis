
clear all
global alpha Re_L np id


% define global variables to optimise at
alpha = 0;
Re_L = 3e6;
np = 100;
id = 'opt';

% define initial aerofoil conditions in 1d vector for fminsearch
initial_y_points = [0.2, 0.1, 0.1, 0.05];

% define optimsation options
options = optimset('Display', 'iter', 'MaxFunEvals', 500, 'TolFun', 1e-6);
best_y_points = fminsearch(@bezierNd, initial_y_points, options);

% display best geometry parameters
best_y_points

% compute lift to drag ratio at best geometry parameters
minusclcd = bezierNd(best_y_points);
clcd = -minusclcd


% save best points
nyp = length(best_y_points);
half_nyp = floor(nyp/2);
x_points = linspace(0, 1, half_nyp + 2);

upper_pts = [   0, x_points;
    0, 0.2, best_y_points(1:half_nyp), 0];

lower_pts = [   0, x_points;
    0, -0.2, best_y_points(half_nyp+1:end), 0];

pts = bezier(upper_pts, lower_pts, np, id);

% plot optimal foil shape
hold on
plot(pts(1,:), pts(2,:))
% plot bezier control points
plot(upper_pts(1,:), upper_pts(2,:))
plot(lower_pts(1,:), lower_pts(2,:))
axis equal
hold off