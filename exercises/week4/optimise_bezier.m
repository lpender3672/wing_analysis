
clear all
global alpha Re_L np id


% define global variables to optimise at
alpha = 5;
Re_L = 0.5e6;
np = 800;
id = 'opt';

% define multiple initial aerofoil conditions in a 2D matrix
%{
initial_conditions = [
    0.2, 0.15, 0.15, 0.15, 0.1, 0.1;
    0.18, 0.16, 0.14, 0.12, 0.1, 0.08;
    0.22, 0.18, 0.16, 0.14, 0.12, 0.1;
    % add more initial conditions as needed
];
%}

% define the number of random initial conditions to generate
num_initial_conditions = 1;

% define the bounds for random sampling
order = 3;

lower_bound = -0.2;
upper_bound = 0.2;
% generate random initial conditions within the bounds
initial_conditions(:,order+1:2*order) = lower_bound + (upper_bound - lower_bound) * rand(num_initial_conditions, order);
lower_bound = 0.1;
upper_bound = 0.4;
initial_conditions(:,1:order) = initial_conditions(:,1:order) + (upper_bound - lower_bound) * rand(num_initial_conditions, order);

% define optimization options
options = optimset('Display', 'iter', 'MaxFunEvals', 500, 'TolFun', 1e-6);

% initialize variables to store the results from each iteration
y_points_array = zeros(size(initial_conditions, 1), size(initial_conditions, 2));
fval_array = zeros(size(initial_conditions, 1), 1);

% use parfor loop to optimize at multiple initial conditions
for i = 1:size(initial_conditions, 1)
    initial_y_points = initial_conditions(i, :);
    
    % Check initial points are valid
    nyp = length(initial_y_points);
    half_nyp = floor(nyp/2);
    x_points = linspace(0.1, 1, half_nyp + 1);

    upper_pts = [   0, 0, x_points;
        0, 0.1, initial_y_points(1:half_nyp), 0];
    
    lower_pts = [   0, 0, x_points;
        0, -0.1, initial_y_points(half_nyp+1:end), 0];

        
    pts = bezier(upper_pts, lower_pts, np, id);
    if isempty(pts)
        continue;
    end

    [y_points, fval] = fminsearch(@bezierNd, initial_y_points, options);
    
    % store the results from each iteration
    y_points_array(i, :) = y_points;
    fval_array(i) = real(fval);
end

% find the index of the minimum fval
[best_fval, best_index] = min(fval_array);

% retrieve the corresponding best y_points
best_y_points = y_points_array(best_index, :);

% display the best geometry parameters and function value
best_y_points

% compute lift to drag ratio at best geometry parameters
minusclcd = bezierNd(best_y_points);
clcd = -minusclcd


% save best points
nyp = length(best_y_points);
half_nyp = floor(nyp/2);
x_points = linspace(0.1, 1, half_nyp + 1);

upper_pts = [   0, 0, x_points;
    0, 0.1, best_y_points(1:half_nyp), 0];

lower_pts = [   0, 0, x_points;
    0, -0.1, best_y_points(half_nyp+1:end), 0];


pts = bezier(upper_pts, lower_pts, np, id);

% plot optimal foil shape
hold on
plot(pts(1,:), pts(2,:))
% plot bezier control points
plot(upper_pts(1,:), upper_pts(2,:))
plot(lower_pts(1,:), lower_pts(2,:))
axis equal
hold off