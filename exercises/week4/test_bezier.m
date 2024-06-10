

best_y_points = [0.1118    0.1142    0.3608   -0.0021];

% save best points
nyp = length(best_y_points);
half_nyp = floor(nyp/2);
x_points = linspace(0, 1, half_nyp + 1);

upper_pts = [   0, 0, x_points;
    0, 0.2, best_y_points(1:half_nyp), 0];

lower_pts = [   0, 0, x_points;
    0, -0.1, best_y_points(half_nyp+1:end), 0];

pts = bezier(upper_pts, lower_pts, 20, '1');

bezierNd(best_y_points)

hold on
plot(pts(1,:), pts(2,:))
axis equal
hold off
