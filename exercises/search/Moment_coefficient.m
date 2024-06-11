clear
close all 

plot_transitions = true;
file = "Data/m31_big"; 

data_struct = load(file);


cp_s = data_struct.cp_s;
xs = data_struct.xs;
ys = data_struct.ys;
alphas = data_struct.alpha;

tei = 1;
[~, lei] = min(xs); % Find front of aerofoil
moment_array = zeros(1,length(cp_s(1,:)));



for j=1:length(cp_s(1,:))
    cp_surf = cp_s(:,j);

    moment = 0;
    for i=1:lei
        angle = atan((ys(i+1) - ys(i))/(xs(i) - xs(i+1)));

        area = sqrt((ys(i+1) - ys(i))^2 + (xs(i+1) - xs(i))^2);
        force = area* (cp_surf(i+1) + cp_surf(i))/2;
        
        vert_force = force*cos(angle);
        arm = 0.25 - (xs(i+1) + xs(i)) / 2;
        moment = moment - vert_force * arm;

        horiz_force = force*sin(angle);
        arm = (ys(i+1) + ys(i))/2;
        moment = moment + horiz_force * arm;

    end
    
    for i=lei:length(xs)-1
        angle = atan((ys(i+1) - ys(i))/(xs(i+1) - xs(i)));
        area = sqrt((ys(i+1) - ys(i))^2 + (xs(i+1) - xs(i))^2);
        force = area* (cp_surf(i+1) + cp_surf(i))/2;
        
        vert_force = force*cos(angle);
        arm = 0.25 - (xs(i+1) + xs(i)) / 2;
        moment = moment + vert_force * arm;

        horiz_force = force*sin(angle);
        arm = (ys(i+1) + ys(i))/2;
        moment = moment + horiz_force * arm;
    end
    moment_array(j) = moment;
end


disp(tei)
disp(lei)

figgy = figure(1);
plot(alphas,moment_array)
ylabel('$\mathbf{cm_{0}}$', 'interpreter' , 'latex')
xlabel('$\mathbf{\alpha}$', 'interpreter' , 'latex')
grid on
saveas(figgy,'m31_moment','epsc')

