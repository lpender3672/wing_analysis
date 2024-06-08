
clear
close all 
%{
datafiles = ["0018_det_0.mat",...
    "0018_det_4.mat",...
    "0018_det_8.mat",...
    "0018_det_12.mat",...
            ];
%}

datafiles = ["Data/search_m1.mat",...
    "Data/search_m20.mat",...
    "Data/search_m21.mat",...
    "Data/naca6409_swp.mat",...
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
iutr_array = {};

sl_array = {};
cpl_array = {};
thetal_array = {};
ilnt_array = {};
ills_array = {};
ilts_array = {};
iltr_array = {};

alpha = 5; % ALPHA OF CP PLOT 

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
    iutr_array{end+1} = data_struct.iutr_s(idx);

    sl_array{end+1} = data_struct.sl_s{idx};
    cpl_array{end+1} = data_struct.cpl_s{idx};
    thetal_array{end+1} = data_struct.thetal_s{idx};
    ilnt_array{end+1} = data_struct.ilnt_s(idx);
    ills_array{end+1} = data_struct.ills_s(idx);
    ilts_array{end+1} = data_struct.ilts_s(idx);
    iltr_array{end+1} = data_struct.iltr_s(idx);
end


figure(1)
subplot(2,1,1);
hold on
legend_array = {};
label_array = {};
iunt_added = false;
iuel_added = false;
iuts_added = false;
iutr_added = false;

for i=1:length(datafiles)
    legend_array{end+1} = plot(su_array{i},cpu_array{i});
    label_array{end+1} = datafiles(i);
end

for i=1:length(datafiles)
    if plot_transitions
        
        if iunt_array{i} ~= 0
            %xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
            scat = scatter(su_array{i}(iunt_array{i}), cpu_array{i}(iunt_array{i}), 30, 0, 'd', 'filled');
            if ~iunt_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Natural Transition';
                iunt_added = true;
            end
        end
        if iuls_array{i} ~= 0
            %xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
            scat = scatter(su_array{i}(iuls_array{i}), cpu_array{i}(iuls_array{i}), 30, 'red', 'o');
            if ~iuel_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Laminar Seperation';
                iuel_added = true;
            end
        end
        if iuts_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
            scat = scatter(su_array{i}(iuts_array{i}), cpu_array{i}(iuts_array{i}), 30, 'red', 's', 'filled');
            if ~iuts_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Seperation';
                iuts_added = true;
            end
        end
        if iutr_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Reattachment'})
            scat = scatter(su_array{i}(iutr_array{i}), cpu_array{i}(iutr_array{i}), 30, 0, 'o', 'filled');
            if ~iutr_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Reattachment';
                iutr_added = true;
            end
        end
    end
end

hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('Upper $c_{p}$','Interpreter','latex')

title('$c_{p}$ Upper Surface','Interpreter','latex')
grid on


subplot(2,1,2);
hold on
for i=1:length(datafiles)
    plot(su_array{i},thetau_array{i})
    if plot_transitions 
        if iunt_array{i} ~= 0
            %xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
            %scatter(su_array{i}(iunt_array{i}),thetau_array{i}(iunt_array{i}),'x')
        end
        if iuls_array{i} ~= 0
            %xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
        end
        if iuts_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
        end
    end
end
hold off
xlabel('Upper Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
legend_handles = [legend_array{:}];
legend_labels = label_array;
legend(legend_handles, legend_labels, 'Interpreter', 'none', 'location', 'northwest');
title('$\theta$ Upper Surface','Interpreter','latex')
grid on


figure(2)
subplot(2,1,1);
hold on

legend_array = {};
label_array = {};
ilnt_added = false;
ilel_added = false;
ilts_added = false;
iltr_added = false;

for i=1:length(datafiles)
    legend_array{end+1} = plot(sl_array{i},cpl_array{i});
    label_array{end+1} = datafiles(i);
end

for i=1:length(datafiles)
    if plot_transitions
        
        if ilnt_array{i} ~= 0
            %xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
            scat = scatter(sl_array{i}(ilnt_array{i}), cpl_array{i}(ilnt_array{i}), 30, 0, 'd', 'filled');
            if ~ilnt_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Natural Transition';
                ilnt_added = true;
            end
        end
        if ills_array{i} ~= 0
            %xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
            scat = scatter(sl_array{i}(ills_array{i}), cpl_array{i}(ills_array{i}), 30, 'red', 'o');
            if ~ilel_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Laminar Seperation';
                ilel_added = true;
            end
        end
        if ilts_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
            scat = scatter(sl_array{i}(ilts_array{i}), cpl_array{i}(ilts_array{i}), 30, 'red', 's', 'filled');
            if ~ilts_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Seperation';
                ilts_added = true;
            end
        end
        if iltr_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Reattachment'})
            scat = scatter(sl_array{i}(iltr_array{i}), cpl_array{i}(iltr_array{i}), 30, 0, 'o', 'filled');
            if ~iltr_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Reattachment';
                iltr_added = true;
            end
        end
    end
end

hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('Lower $c_{p}$','Interpreter','latex')
legend_handles = [legend_array{:}];
legend_labels = label_array;
legend(legend_handles, legend_labels, 'Interpreter', 'none', 'location', 'southeast');
title('$c_{p}$ Lower Surface','Interpreter','latex')
grid on


subplot(2,1,2);
hold on
for i=1:length(datafiles)
    plot(sl_array{i},thetal_array{i})
    if plot_transitions 
        if ilnt_array{i} ~= 0
            %xline(sl_array{i}(ilnt_array{i}),'-',{'Natural Transition'})
        end
        if ills_array{i} ~= 0
            %xline(sl_array{i}(ills_array{i}),'-',{'Laminar Seperation'})
        end
        if ilts_array{i} ~= 0
            %xline(sl_array{i}(ilts_array{i}),'-',{'Turbulent Seperation'})
        end
    end
end
hold off
xlabel('Lower Surface','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
title('$\theta$ Lower Surface','Interpreter','latex')
grid on

figure(3)
hold on
for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    plot(data_struct.xs,data_struct.ys)
end
legend(datafiles, 'Interpreter', 'none','location','northwest')
hold off
xlabel('x/c')
ylabel('y/c')
axis image
xlim([-0.1,1.1])
ylim([-0.3,0.3])
grid on


figure(4)
subplot(1,2,1)
hold on
for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    plot(data_struct.Cl_s,data_struct.Cd_s)
end
hold off
xlabel('$c_{l}$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
grid on

subplot(1,2,2)
hold on
for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    plot(data_struct.alpha,data_struct.lovdswp)
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$\frac{c_{l}}{c_{d}}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
grid on


figure(5)
subplot(1,2,1);
hold on
for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    plot(data_struct.alpha,data_struct.Cl_s)
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{l}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
grid on

subplot(1,2,2);
hold on
for i=1:length(datafiles)
    data_struct = load(datafiles(i));
    plot(data_struct.alpha,data_struct.Cd_s)
end
hold off
xlabel('$\alpha$','Interpreter','latex')
ylabel('$c_{d}$','Interpreter','latex')
legend(datafiles, 'Interpreter', 'none','location','northwest') 
grid on



    