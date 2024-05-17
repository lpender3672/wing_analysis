clear
close all

global Re_L ue0 due_dx;

Re_L = 10^7;
ue0 = 1;
due_dx = 0;

x0 = 0.01;
thick0 = zeros(1,2);
thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

[delx , thickhist] = ode45(@thickdashalt,[0 0.99], thick0);

x = x0 + delx;
exact_theta = thickhist(:,1);


theta_7 = 0.037 * x .* (Re_L*delx).^(-1/5);
theta_9 = 0.023 * x .* (Re_L*delx).^(-1/6);

hold on
plot(x,exact_theta);
plot(x,theta_7);
plot(x,theta_9);
legend('Solved Theta', '1/7 Power', '1/9 Power');
hold off


