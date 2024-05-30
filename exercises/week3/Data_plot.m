clear
close all

%data_file = input('Data file name: ','s');

data_file = '0012.mat';
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

plot(alpha,clswp)
xlabel('$\alpha$','Interpreter','latex')
ylabel('$C_{L}$','Interpreter','latex')
title('$C_{L}$ Variation','Interpreter','latex')