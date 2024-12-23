clear 
close all 

global Re_L ue0 due_dx

ue0 = 1;
Re_L = 10^7;
due_dx = 0; 

x0 = 0.01;
thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

[delx thickhist] = ode45(@thickdash, [0 0.99], thick0);

x = x0 + delx;

theta7_over_L = 0.037 .* x .* (Re_L .* x) .^ (-1/5);
theta9_over_L = 0.023 .* x .* (Re_L .* x) .^ (-1/6);

hold on;

plot(x, thickhist(:,1));
plot(x, theta7_over_L);
plot(x, theta9_over_L);

legend("Exact", "1/7th Est.", "1/9th Est.")
hold off;
grid on;

xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
title('Momentum Thickness Solution and Power Law Estimates')
