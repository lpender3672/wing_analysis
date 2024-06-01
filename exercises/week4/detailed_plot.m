clear
close all 
%{
datafiles = ["0018_det_0.mat",...
    "0018_det_4.mat",...
    "0018_det_8.mat",...
    "0018_det_12.mat",...
            ];
%}

datafiles = ["0006_det_8.mat",...
    "0012_det_8.mat",...
    "0018_det_8.mat"];


angle_file = char(datafiles(1));
end_pos = find(angle_file == '_', 1, 'last');
airfoil_file = [angle_file(1:end_pos-1) '.mat'];

disp(airfoil_file)
airfoil_struct = open(airfoil_file);
xs = airfoil_struct.xs;
ys = airfoil_struct.ys;

% set to true to see boundary layer transitions
% (not recommended for multiple plots)

plot_transitions =false;

su_array = {};
cpu_array = {};
thetau_array = {};
iunt_array = {};
iuls_array = {};
iuts_array = {};

sl_array = {};
cpl_array = {};
thetal_array = {};
ilnt_array = {};
ills_array = {};
ilts_array = {};

for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    
    su_array{end+1} = data_struct.su;
    cpu_array{end+1} = data_struct.cpu;
    thetau_array{end+1} = data_struct.thetau;
    iunt_array{end+1} = data_struct.iunt;
    iuls_array{end+1} = data_struct.iuls;
    iuts_array{end+1} = data_struct.iuts;

    sl_array{end+1} = data_struct.sl;
    cpl_array{end+1} = data_struct.cpl;
    thetal_array{end+1} = data_struct.thetal;
    ilnt_array{end+1} = data_struct.ilnt;
    ills_array{end+1} = data_struct.ills;
    ilts_array{end+1} = data_struct.ilts;
end


figure(1)
subplot(2,1,1);
hold on
for i=1:length(datafiles)
    plot(su_array{i},cpu_array{i})
    if plot_transitions 
        if iunt_array{i} ~= 0
            xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
        end
        if iuls_array{i} ~= 0
            xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
        end
        if iuts_array{i} ~= 0
            xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
        end
    end

end
hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('Upper $c_{p}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none')
title('$c_{p}$ Upper Surface','Interpreter','latex')



subplot(2,1,2);
hold on
for i=1:length(datafiles)
    plot(su_array{i},thetau_array{i})
    if plot_transitions 
        if iunt_array{i} ~= 0
            xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
        end
        if iuls_array{i} ~= 0
            xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
        end
        if iuts_array{i} ~= 0
            xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
        end
    end
end
hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
title('$\theta$ Upper Surface','Interpreter','latex')



figure(2)
subplot(2,1,1);
hold on
for i=1:length(datafiles)
    plot(sl_array{i},cpl_array{i})
    if plot_transitions 
        if ilnt_array{i} ~= 0
            xline(sl_array{i}(ilnt_array{i}),'-',{'Natural Transition'})
        end
        if ills_array{i} ~= 0
            xline(sl_array{i}(ills_array{i}),'-',{'Laminar Seperation'})
        end
        if ilts_array{i} ~= 0
            xline(sl_array{i}(ilts_array{i}),'-',{'Turbulent Seperation'})
        end
    end

end
hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('Lower $c_{p}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none')
title('$c_{p}$ Upper Surface','Interpreter','latex')



subplot(2,1,2);
hold on
for i=1:length(datafiles)
    plot(sl_array{i},thetal_array{i})
    if plot_transitions 
        if ilnt_array{i} ~= 0
            xline(sl_array{i}(ilnt_array{i}),'-',{'Natural Transition'})
        end
        if ills_array{i} ~= 0
            xline(sl_array{i}(ills_array{i}),'-',{'Laminar Seperation'})
        end
        if ilts_array{i} ~= 0
            xline(sl_array{i}(ilts_array{i}),'-',{'Turbulent Seperation'})
        end
    end
end
hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
title('$\theta$ Lower Surface','Interpreter','latex')

figure(3)
hold on
for i=1:length(datafiles)
    plot(xs,ys)
end
hold off
xlabel('x/c')
ylabel('y/c')
axis image
xlim([-0.1,1.1])
ylim([-0.3,0.3])
  

    