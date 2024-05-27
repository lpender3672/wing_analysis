
clear
close all

global Re_L ue0 due_dx

ue0 = 1;

Re_L_array = [10^8 ; 10^7 ; 10^6];
due_dx_array = [-0.25; -0.5; -0.95];

x0 = 0.01;
seperation_points = zeros(length(Re_L_array),length(due_dx_array));

% Looping through required Reynolds Numbers
for i=1:length(Re_L_array)
    for j=1:length(due_dx_array)
        
        % Turbulent Solver
    
        % Setting flow Reynolds number
        Re_L = Re_L_array(i);
        due_dx = due_dx_array(j);

        % Calculation of initial variables for ODE solver
        thick0(1) = 0.023*x0*(Re_L*x0)^(-1/6);
        thick0(2) = 1.83*thick0(1);

        % Solving ODE for x/L in range 0 to 0.99
        [delx thickhist] = ode45(@thickdash, [0 0.99], thick0);
        
        x = x0 + delx;
 
        % Calculation of energy shape factor profile from solution
        He = thickhist(:,2) ./ thickhist(:,1);
        % Offset to ignore unstabilities caused by boundary condition
        offset = 10;
        % Boolean indicies where He < 1.46 indicating seperation
        idt = find(He(offset+1:end) < 1.46);

        if isempty(idt)
            % Seperation does not occur in finite distance
            seperation_points(i,j) = inf;
        else
            % first point of seperation
            seperation_points(i,j) = x(offset + idt(1));
         end
     end
 end


% Create cell array to hold table data
table_data = cell(length(Re_L_array) + 1, length(due_dx_array) + 1);

% Set the column headers (due_dx values)
table_data(1, 2:end) = arrayfun(@(x) sprintf('due_dx = %.1f', x), due_dx_array, 'UniformOutput', false);

% Set the row headers (Re_L values)
table_data(2:end, 1) = arrayfun(@(x) sprintf('Re_L = %.0e', x), Re_L_array, 'UniformOutput', false);

% Populate the table data with separation points
for i = 1:length(Re_L_array)
    for j = 1:length(due_dx_array)
        if seperation_points(i, j) == inf
            table_data{i + 1, j + 1} = 'No Seperation';
        else
            table_data{i + 1, j + 1} = sprintf('%.2f', seperation_points(i, j));
        end
    end
end

% Convert cell array to table
T = cell2table(table_data(2:end, 2:end), 'VariableNames', table_data(1, 2:end), 'RowNames', table_data(2:end, 1));

% Display the table
disp(T)

%% Plot
% for this case Seperation occurs at x/L = 0.99

Re_L = 10^7;
due_dx = -0.50;

[delx thickhist] = ode45(@thickdash, [0 0.99], thick0);

x = x0 + delx;

He = thickhist(:,2) ./ thickhist(:,1);
idt = find(He < 1.46);

hold on;
plot(x, thickhist(:,1));
plot(x, thickhist(:,2));

legend("\theta /L", "\delta_E/L")
hold off;
grid on;

xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{y}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
title('Momentum Thickness Solution and Power Law Estimates')


