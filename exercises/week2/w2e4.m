clear 
close all 

global Re_L ue0 due_dx

% Definition of global variables to be accessed in thickdash
ue0 = 1;
Re_L = 10^7;
due_dx = 0; 

% Calculation of initial variables for ODE solver
x0 = 0.01;
thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

% Solving ODE for x/L in range 0 to 0.99
[delx thickhist] = ode45(@thickdash, [0 0.99], thick0);

% Adding initial x0 offset so range is 0.01 to 1.0
x = x0 + delx;

% Calculating power law estimates of profiles in vector form
theta7_over_L = 0.037 .* x .* (Re_L .* x) .^ (-1/5);
theta9_over_L = 0.023 .* x .* (Re_L .* x) .^ (-1/6);

% Plotting momentum thickness profiles
hold on;
plot(x, thickhist(:,1));
plot(x, theta7_over_L);
plot(x, theta9_over_L);

legend("Exact", "1/7th Est.", "1/9th Est.", 'location', 'northwest')
hold off;
grid on;

xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
%title('Momentum Thickness Solution and Power Law Estimates')

print -deps2c exercises\week2\figures\w2e4.eps

