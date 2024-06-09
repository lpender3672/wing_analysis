

best_y_points = [0.0194376604438124,	0.378408859204882,	0.346750211687485,	0.00838894618314870,	-0.204676051853145,	0.343593108819611];

% save best points
nyp = length(best_y_points);
half_nyp = floor(nyp/2);
x_points = [0, logspace(-1, 0, half_nyp)];

upper_pts = [   0, x_points;
    0, best_y_points(1:half_nyp), 0];

lower_pts = [   0, x_points;
    0, best_y_points(half_nyp+1:end), 0];

pts = bezier(upper_pts, lower_pts, 20, '1');

bezier2d(best_y_points);

hold on
plot(pts(1,:), pts(2,:))
axis equal
hold off
