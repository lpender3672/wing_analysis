clear
close all

%data_file = input('Data file name: ','s');

data_file = '0012_swp.mat';
data_struc = load(data_file);

if isfield(data_struc, 'alpha')
    alpha = data_struc.alpha;
else
    error('The variable "alpha" is not found in the input file.');
end

if isfield(data_struc, 'Cl_s')
    clswp = data_struc.Cl_s;
else
    error('The variable "clwp" is not found in the input file.');
end

if isfield(data_struc, 'Cd_s')
    cdswp = data_struc.Cd_s;
else
    error('The variable "cdwp" is not found in the input file.');
end

if isfield(data_struc, 'lovdswp')
    lovdswp = data_struc.lovdswp;
else
    error('The variable "lovdswp" is not found in the input file.');
end


for i=1:length(alpha)
    disp(append('alpha: ', string(alpha(i)), ' Drag: ', string(cdswp(i)) ))
end

figure(1)
% Read the background image
img = imread("exercises\week3\NACA0012_background.png");
xlim([-24, 32]);
ylim([-1.8, 2.8]);  % Correct y-axis limits

% Display the background image
image(xlim, fliplr(ylim), flipud(img));
set(gca, 'YDir', 'normal');

% Set the x-axis and y-axis ticks and labels
x = -24:8:32;
y = -1.8:0.4:2.8;
xticks(x);
yticks(y);
xticklabels(string(x));
yticklabels(string(y));

% Hold the plot to allow plotting on top of the image
hold on;

% Plot your data

plot(alpha,-clswp,'r', 'LineWidth',2)
axis ij;


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