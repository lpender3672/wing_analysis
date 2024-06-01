

%upper_pts = [0, 0, 0.5, 1; 0, 0.2, 0.1489, 0];
%lower_pts = [0, 0, 0.5, 1; 0, -0.1, 2.5087, 0];

upper_pts = [0, 0, 0.5, 1; 0, 0.2, 0.2, 0];
lower_pts = [0, 0, 0.5, 1; 0, -0.1, 0.1, 0];

pts = bezier(upper_pts, lower_pts, 20, '1');

bezier2d([0.2, 0.1]);

hold on
plot(pts(1,:), pts(2,:))
axis equal
hold off
