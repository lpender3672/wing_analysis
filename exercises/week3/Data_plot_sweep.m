clear
close all

%data_file = input('Data file name: ','s');

data_file = '4412_det.mat';
data_struc = load(data_file);

if isfield(data_struc, 'alpha')
    alpha = data_struc.alpha;
else
    error('The variable "alpha" is not found in the input file.');
end

if isfield(data_struc, 'clswp')
    clswp = data_struc.clswp;
else
    error('The variable "clwp" is not found in the input file.');
end

if isfield(data_struc, 'cdswp')
    cdswp = data_struc.cdswp;
else
    error('The variable "cdwp" is not found in the input file.');
end

if isfield(data_struc, 'lovdswp')
    lovdswp = data_struc.lovdswp;
else
    error('The variable "lovdswp" is not found in the input file.');
end

%img = imread("exercises\week3\NACA0012_background.png");
%img = flipdim(img,1);

x = -24:8:32;
y = -1.8:0.4:2.8;

%imshow(img)

for i=1:length(alpha)
    disp(append('alpha: ', string(alpha(i)), ' Drag: ', string(cdswp(i)) ))
end


figure(1)
plot(alpha,clswp,'r')
%xticks(x)
%xlim([-24,32])
%yticks(y)
%ylim([-1.8,2.8])
%imshow(img)
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{L}$','Interpreter','latex')
title('$c_{L}$ Variation','Interpreter','latex')


figure(2)
plot(clswp,cdswp)
xlabel('$c_{l}$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')
title('Lift Drag Polar','Interpreter','latex')

figure(3)
plot(alpha,cdswp)
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')

figure(4)
plot(alpha,lovdswp)
xlabel('$\alpha$','Interpreter','latex')
ylabel('$\frac{c_{l}}{c_{d}}$','Interpreter','latex')


