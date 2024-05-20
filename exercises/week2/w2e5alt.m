clear
close all

global Re_L ue0 due_dx;

Re_L = 10^6;
ue0 = 1;
due_dx = -0.5;

x0 = 0.01;
thick0 = zeros(1,2);
thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

[delx , thickhist] = ode45(@thickdash,[0 0.99], thick0);

x = x0 + delx;
exact_theta = thickhist(:,1);
exact_delte = thickhist(:,2);


He = exact_delte./exact_theta;

seperation_point = 0;

for i=length(x):-1:1
    if He(i) > 1.46
        seperation_point = x(i+1);
        break
    end
end

disp(seperation_point)

figure(1)
hold on
plot(x,He);
yline(1.46,'color','r','linestyle','--')
xline(seperation_point,'color','r','linestyle','--')
hold off

figure(2)
hold on 
plot(x,exact_theta);
plot(x,exact_delte);
grid on;
legend('Solved Theta', 'Solved delte');
hold off 
