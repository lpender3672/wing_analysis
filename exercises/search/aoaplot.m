clear
close all 
plot_transitions = true;
file = "Data/m31_swp"; 
file2 = "Data/4412_streamlines_4";
file3 = "Data/streamlines_0012_8";

alpha_list = ["$\alpha = 4$","$\alpha = 8$","$\alpha = 12$","$\alpha = 12$"];

data_struct = load(file);

alphas = data_struct.alpha; 

su = data_struct.su_s;
cpu_s = data_struct.cpu_s;

sl = data_struct.sl_s;
cpl_s = data_struct.cpl_s;

iunt_array = num2cell(data_struct.iunt_s);
iuls_array = num2cell(data_struct.iuls_s);
iuts_array = num2cell(data_struct.iuts_s);
iutr_array = num2cell(data_struct.iutr_s);


ilnt_array = num2cell(data_struct.ilnt_s);
ills_array = num2cell(data_struct.ills_s);
ilts_array = num2cell(data_struct.ilts_s);
iltr_array = num2cell(data_struct.iltr_s);

fig = figure(1);

subplot(2,1,1)
legend_array = {};
label_array = {};
iunt_added = false;
iuel_added = false;
iuts_added = false;
iutr_added = false;

hold on
for i=1:length(alphas)
    legend_array{end+1} = plot(su{i},cpu_s{i});
    label_array{end+1} = alpha_list(i);
end
for i=1:length(alphas)
    if plot_transitions
        
        if iunt_array{i} ~= 0
            %xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
            scat = scatter(su{i}(iunt_array{i}), cpu_s{i}(iunt_array{i}), 30, 0, 'd', 'filled');
            if ~iunt_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Natural Transition';
                iunt_added = true;
            end
        end
        if iuls_array{i} ~= 0
            %xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
            scat = scatter(su{i}(iuls_array{i}), cpu_s{i}(iuls_array{i}), 30, 'red', 'o');
            if ~iuel_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Laminar Seperation';
                iuel_added = true;
            end
        end
        if iuts_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
            scat = scatter(su{i}(iuts_array{i}), cpu_s{i}(iuts_array{i}), 30, 'red', 's', 'filled');
            if ~iuts_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Seperation';
                iuts_added = true;
            end
        end
        if iutr_array{i} ~= 0 && iuls_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Reattachment'})
            scat = scatter(su{i}(iutr_array{i}), cpu_s{i}(iutr_array{i}), 30, 0, 'o', 'filled');
            if ~iutr_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Reattachment';
                iutr_added = true;
            end
        end
    end
end

hold off
legend_handles = [legend_array{:}];
legend_labels = label_array;
legend(legend_handles, legend_labels, 'Interpreter', 'latex', 'location', 'southeast');
xlabel('Upper Surface','Interpreter','latex')
ylabel('$\mathbf{c_{p}}$','Interpreter','latex')

subplot(2,1,2)
legend_array = {};
label_array = {};
ilnt_added = false;
ilel_added = false;
ilts_added = false;
iltr_added = false;

hold on
for i=1:length(alphas)
    legend_array{end+1} = plot(sl{i},cpl_s{i});
    label_array{end+1} = alpha_list(i);
end

for i=1:length(alphas)
    if plot_transitions
        
        if ilnt_array{i} ~= 0
            %xline(su_array{i}(iunt_array{i}),'-',{'Natural Transition'})
            scat = scatter(sl{i}(ilnt_array{i}), cpl_s{i}(ilnt_array{i}), 30, 0, 'd', 'filled');
            if ~ilnt_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Natural Transition';
                ilnt_added = true;
            end
        end
        if ills_array{i} ~= 0
            %xline(su_array{i}(iuls_array{i}),'-',{'Laminar Seperation'})
            scat = scatter(sl{i}(ills_array{i}), cpl_s{i}(ills_array{i}), 30, 'red', 'o');
            if ~ilel_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Laminar Seperation';
                ilel_added = true;
            end
        end
        if ilts_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Seperation'})
            scat = scatter(sl{i}(ilts_array{i}), cpl_s{i}(ilts_array{i}), 30, 'red', 's', 'filled');
            if ~ilts_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Seperation';
                ilts_added = true;
            end
        end
        if iltr_array{i} ~= 0 && ills_array{i} ~= 0
            %xline(su_array{i}(iuts_array{i}),'-',{'Turbulent Reattachment'})
            scat = scatter(sl{i}(iltr_array{i}), cpl_s{i}(iltr_array{i}), 30, 0, 'o', 'filled');
            if ~iltr_added
                legend_array{end+1} = scat;
                label_array{end+1} = 'Turbulent Reattachment';
                iltr_added = true;
            end
        end
    end
end
hold off 
legend_handles = [legend_array{:}];
legend_labels = label_array;
legend(legend_handles, legend_labels, 'Interpreter', 'latex', 'location', 'southeast');
xlabel('Lower Surface','Interpreter','latex')
ylabel('$\mathbf{c_{p}}$','Interpreter','latex')

%saveas(fig,'m31_movements','epsc')


%xs = data_struct.xs;
%ys = data_struct.ys;
%cp_s = data_struct.cp_s;

%{
fig2 = figure(2);
hold on
for i=1:length(alphas)
    plot(xs,cp_s(:,i))
end
legend("$\alpha = 0$","$\alpha = 4$","$\alpha = 8$","$\alpha = 12$",'interpreter','latex','location','southeast')
xlabel('x/c')
ylabel('$\mathbf{c_{p}}$','interpreter','latex')
grid on
hold off
saveas(gcf,'4412_swpcp','epsc')
%}

data_struct = load(file2);


alpha = 4;
psi = data_struct.psi;
xm = data_struct.xm;
ym = data_struct.ym;

xm_r = xm*cosd(alpha) + ym*sind(alpha);
ym_r = -xm*sind(alpha) + ym*cosd(alpha); 

xs_r = xs*cosd(alpha) + ys*sind(alpha);
ys_r = -xs*sind(alpha) + ys*cosd(alpha); 

c = -0.5:0.04:0.4;

fig3 = figure(3);
hold on
contour(xm_r,ym_r,psi,c)
plot(xs_r,ys_r,'color','r')
hold off
axis image
xlim([-0.3,1.3])
ylim([-0.3,0.3])
saveas(gcf,'4412_swpstreamline','epsc')









