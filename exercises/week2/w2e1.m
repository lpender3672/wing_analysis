clear
close all

% Setting flow Reynolds number
Re_L = 1000;

% x = x/L setting domain
x = linspace(0,1,101);

% Setting ue = ue/U , with zero pressure gradient ue = 1
ue = ones(1,length(x));

% Calculate the integral in Thwaites solution over vector x
f = ueintbit(x(1),ue(1),x,ue);

% Calculating theta/L using Thwaites solution
theta = sqrt((0.45/Re_L)*(ue.^-6).*f);

% Calculating theta/L using Blasius solution
blausius_theta = (0.664/sqrt(Re_L))*sqrt(x);

%% Plotting
hold on
plot(x,theta)
plot(x,blausius_theta)
legend('Thwaites’ solution', 'Blasius Solution')
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
title('Comparison of Momentum Thickness Variation')
hold off

print -deps2c exercises\week2\figures\w2e1.eps
