clear
close all

%data_file = input('Data file name: ','s');

data_file = '0012_det_5.4.mat';
data_struc = load(data_file);

% Load in first data file
cp = data_struc.cp;
thetal = data_struc.thetal;
thetau = data_struc.thetau;
sl = data_struc.sl;
su = data_struc.su;
cpu = data_struc.cpu;
cpl = data_struc.cpl;

% Load in second data file
data_file2 = '0012_det_5.45.mat';
data_struc2 = load(data_file2);
thetal2 = data_struc2.thetal;
thetau2 = data_struc2.thetau;
sl2 = data_struc2.sl;
su2 = data_struc2.su;
cpu2 = data_struc2.cpu;
cpl2 = data_struc2.cpl;


figure(1)
subplot(2,1,1);
hold on
plot(su,cpu)
plot(su2,cpu2)
hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('Upper $c_{p}$','Interpreter','latex')
title('$c_{p}$ Upper Surface','Interpreter','latex')

subplot(2,1,2);
hold on
plot(su,thetau)
plot(su2,thetau2)
hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
title('$\theta$ Upper Surface','Interpreter','latex')

figure(2)
subplot(2,1,1);
hold on
plot(sl,cpl)
plot(sl2,cpl2)
hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('Lower $c_{p}$','Interpreter','latex')
title('$c_{p}$ Lower Surface','Interpreter','latex')

subplot(2,1,2);
hold on
plot(sl,thetal)
plot(sl2,thetal2)
hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
title('$\theta$ Lower Surface','Interpreter','latex')


