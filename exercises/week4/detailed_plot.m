clear
close all 

datafiles = ["4412_det_0.mat",...
    "4412_det_4.mat",...
    "4412_det_8.mat",...
    "4412_det_12.mat"];


%datafiles = ["4412_det_0.mat"];
%datafiles = ["4412_det_12.mat"]

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
legend(datafiles, 'Interpreter', 'none') 
title('$\theta$ Upper Surface','Interpreter','latex')

    