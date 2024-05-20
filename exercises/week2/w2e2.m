clear
close all

Re_L_array = [10^6 ; 10^7 ; 10^8];
due_de_array = [-0.2 ; 0 ; 0.2];


% x = x/L setting domain
n = 101;
x = linspace(0,1,n);

transition_points = inf * ones(length(Re_L_array),length(due_de_array));

% Looping through required Reynolds Numbers
for i=1:length(Re_L_array)
    % Looping through required gradients
    for j=1:length(due_de_array)    
    
        % LAMINAR BOUNDARY LAYER SOLVER

        laminar = true;

        % Setting flow Reynolds number
        Re_L = Re_L_array(i);
     
        % Setting ue = ue/U based on velocity gradient due_dx
        due_dx = due_de_array(j);
        ue = 1 + due_dx*x;
        
        % The fastest way of doing this might be to search for the point of
        % Transition, then vectorise the calculation up until that point
        k = 1;
        while laminar && k < n
            % Calculate the integral in Thwaites solution over vector x
            f = ueintbit(x(1),ue(1),x(k),ue(k));
            
            % Calculating theta/L using Thwaites solution
            theta = sqrt((0.45/Re_L)*(ue(k)^-6)*f);
            
            % Creating reynolds number
            Re_theta = Re_L*ue(k)*theta;
            
            m = -Re_L*(theta^2)*due_dx;

            H = thwaites_lookup(m);
            He = laminar_He(H);
            
            % Check for natural transition to turbulence
            if log(Re_theta) >= 18.4*He - 21.74
                % Flow has transitioned
                laminar = false;
                transition_points(i,j) = x(k); % Storing transition point for table
                %disp([x(k) Re_theta/1000]) % Show Re_theta at transition
                break
            end
            k = k+1;
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
for i = 1:length(Re_L_array)  % Loop over rows
    for j = 1:length(due_de_array) % Loop over columns

        if transition_points(i, j) == inf
            % If transition does not occur over range
            table_data{i + 1, j + 1} = 'No Transition';
        else
            % If transition does occur at finite position 
            table_data{i + 1, j + 1} = sprintf('%.2f', transition_points(i, j));
        end
    end
end

% Convert cell array to table
T = cell2table(table_data(2:end, 2:end), 'VariableNames', table_data(1, 2:end), 'RowNames', table_data(2:end, 1));

% Display the table
disp(T)
