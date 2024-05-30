%  Zero pressure gradient b-l; bl_solv and Blasius

clear all
global Re_L

Re_L = 10000000;
due_dx = 0.2;
ue0 = 1;
%Re_L = 10000;

n = 100;
x = linspace(1/n,1,n);
ue = ue0 + due_dx * x;
cp = (1 - ue.^2);


[int ils itr its delstar theta] = bl_solv ( x, cp );
blthet = 0.664 * sqrt(x/Re_L);

if int~=0
  disp(['Natural transition at x = ' num2str(x(int))])
end

hold on
plot(x,blthet)
plot(x,theta)

plot(x, delstar)
hold off

xlabel('x')
ylabel('\theta')
legend('Blasius','blsolv')


