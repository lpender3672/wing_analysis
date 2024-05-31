% Create a new figure
figure;

% Create the 4x4 grid for the first four plots
subplot(3, 4, 5); % 1st plot in the grid
plot(rand(10, 1));
title('Plot 1');

subplot(3, 4, 6); % 2nd plot in the grid
plot(rand(10, 1));
title('Plot 2');

subplot(3, 4, 9); % 3rd plot in the grid
plot(rand(10, 1));
title('Plot 3');

subplot(3, 4, 10); % 4th plot in the grid
plot(rand(10, 1));
title('Plot 4');

% Create the 5th plot spanning the top two columns
axes('Position', [0.1, 0.7, 0.4, 0.25]); % Adjust the position to span two columns
plot(rand(10, 1));
title('Plot 5');