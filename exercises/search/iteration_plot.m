
clear
close all 
%{
datafiles = ["0018_det_0.mat",...
    "0018_det_4.mat",...
    "0018_det_8.mat",...
    "0018_det_12.mat",...
            ];
%}

datafiles = ["Data/search_v1.mat",...
             "Data/search_v2.mat",...
             "Data/search_v3.mat",...
             "Data/search_v6.mat",...
             ];
%datafiles = ["v2stall_det_5.3.mat"];



% set to true to see boundary layer transitions
% (not recommended for multiple plots)

plot_transitions = true;

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

alpha = 7;

for i=1:length(datafiles)
    data_struct = load(datafiles(i));

    idxs = find(abs(data_struct.alpha - alpha) < eps(alpha));
    idx = idxs(1);
    
    disp(['Design ' datafiles(i) ' has Cl ' num2str(data_struct.Cl_s(idx)) ' and Cd of ' num2str(data_struct.Cd_s(idx))])
    
    su_array{end+1} = data_struct.su_s{idx};
    cpu_array{end+1} = data_struct.cpu_s{idx};
    thetau_array{end+1} = data_struct.thetau_s{idx};
    iunt_array{end+1} = data_struct.iunt_s(idx);
    iuls_array{end+1} = data_struct.iuls_s(idx);
    iuts_array{end+1} = data_struct.iuts_s(idx);

    sl_array{end+1} = data_struct.sl_s{idx};
    cpl_array{end+1} = data_struct.cpl_s{idx};
    thetal_array{end+1} = data_struct.thetal_s{idx};
    ilnt_array{end+1} = data_struct.ilnt_s(idx);
    ills_array{end+1} = data_struct.ills_s(idx);
    ilts_array{end+1} = data_struct.ilts_s(idx);
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
            %scatter(su_array{i}(iunt_array{i}),thetau_array{i}(iunt_array{i}),'x')
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
title('$c_{p}$ Lower Surface','Interpreter','latex')



subplot(2,1,2);
hold on
for i=1:length(datafiles)
    plot(sl_array{i},thetal_array{i})
    if plot_transitions 
        if ilnt_array{i} ~= 0
            %xline(sl_array{i}(ilnt_array{i}),'-',{'Natural Transition'})
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
    data_struct = load(datafiles(i));
    plot(data_struct.xs,data_struct.ys)
end
legend(datafiles)
hold off
xlabel('x/c')
ylabel('y/c')
axis image
xlim([-0.1,1.1])
ylim([-0.3,0.3])
  

    