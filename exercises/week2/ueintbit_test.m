clear
close all 

ua = 0.6;
ub = 0.8;

xa = 0.3;
xb = 1;

f_test = ueintbit(xa,ua,xb,ub);

n = 200;
ue = linspace(ua,ub,100);
x = linspace(xa,xb,100);

integrand = ue.^5;

f_trap = trapz(x,integrand);

disp(f_test)
disp(f_trap)