
pts = [0, 0, 1, 0, 0, 1; 0, 0.1, 0, 0, -0.1, 0];

pts = bezier(pts, 20, '1');

hold on
plot(pts(1,:), pts(2,:))
axis equal
hold off
