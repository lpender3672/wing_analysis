clear 
close all 

ue0 = 1;
Re_L = 10^6;
due_dx = 0; 

x0 = 0.01;
thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

[delx thickhist] = ode45(@thickdash, [0 0.99],thick0);

x = x0 + delx;

theta7_over_L = 0.037 .* x .* (Re_L .* x) .^ (-1/5);
theta9_over_L = 0.023 .* x .* (Re_L .* x) .^ (-1/6);
