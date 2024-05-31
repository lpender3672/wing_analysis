clear
close all

datafiles = ["0012_swp.mat",...
    "4412_swp.mat"];

alpha = {};
cdswp = {};
clswp = {};
lovdswp = {};
xs = {};
ys = {};

for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    alpha{end+1} = data_struct.alpha;
    cdswp{end+1} = data_struct.cdswp;
    clswp{end+1} = data_struct.clswp;
    lovdswp{end+1} = data_struct.lovdswp;
    xs{end+1} = data_struct.xs;
    ys{end+1} = data_struct.ys;

end

% cl alpha
% cd alpha
% cd cl
% lovd alpha
% airfoil plot

figure(1)
subplot(1,2,1);
hold on
for i=1:length(datafiles)
    plot(alpha{i},clswp{i})
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{l}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none') 

subplot(1,2,2);
hold on
for i=1:length(datafiles)
    plot(alpha{i},cdswp{i})
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none') 

figure(2)
subplot(1,2,1)
hold on
for i=1:length(datafiles)
    plot(clswp{i},cdswp{i})
end
hold off
xlabel('$c_{l}$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none') 

subplot(1,2,2)
hold on
for i=1:length(datafiles)
    plot(alpha{i},lovdswp{i})
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$\frac{c_{l}}{c_{d}}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none') 

figure(3)
hold on
for i=1:length(datafiles)
    plot(xs{i},ys{i})
end
hold off
axis image
xlabel('x/c')
ylabel('y/c')
legend(datafiles, 'Interpreter', 'none')


