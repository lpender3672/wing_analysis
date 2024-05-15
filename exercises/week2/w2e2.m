clear
close all

Re_L_array = [5*10^6 ; 10*10^6 ; 20*10^6];
due_de_array = [-0.1 ; 0 ; 0.1];


% x = x/L setting domain
x = linspace(0,1,101);

seperation_points = zeros(length(Re_L_array),length(due_de_array));


for i=1:length(Re_L_array)
    for j=1:length(due_de_array)    
        % Setting flow Reynolds number
        Re_L = Re_L_array(i);
     
        
        % Setting ue = ue/U based on velocity gradient due_dx
        due_dx = due_de_array(j);
        ue = 1 + due_dx*x;
        
        
        % Calculate the integral in Thwaites solution over vector x
        f = ueintbit(x(1),ue(1),x,ue);
        
        % Calculating theta/L using Thwaites solution
        theta = sqrt((0.45/Re_L)*(ue.^-6).*f);
        
        % Creating reynolds number
        Re_theta = Re_L*ue.*theta;
        
        m = -Re_L*(theta.^2)*due_dx;
        
        
        for k=1:length(x)
            H = thwaites_lookup(m(k));
            He = laminar_He(H);
            
            if log(Re_theta(k)) >= 18.4*He - 21.74
                seperation_points(i,j) = x(k);
                break
            end
        end
    end
end


% Create cell array to hold table data
table_data = cell(length(Re_L_array) + 1, length(due_de_array) + 1);

% Set the column headers (due_dx values)
table_data(1, 2:end) = arrayfun(@(x) sprintf('due_dx = %.1f', x), due_de_array, 'UniformOutput', false);

% Set the row headers (Re_L values)
table_data(2:end, 1) = arrayfun(@(x) sprintf('Re_L = %.0e', x), Re_L_array, 'UniformOutput', false);

% Populate the table data with separation points
for i = 1:length(Re_L_array)
    for j = 1:length(due_de_array)
        if seperation_points(i, j) == 0
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



%{
% Calculating theta/L using Blasius solution
blausius_theta = (0.664/sqrt(Re_L))*sqrt(x);

%% Plotting
hold on
plot(x,theta)
plot(x,blausius_theta)
legend('Thwaites’ solution', 'Blasius Solution')
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
title('Comparison of Momentum Thickness Variation')
hold off
%}