clear
close all

% Define global variables for parameters used in ode45
global Re_L ue0 due_dx;

% Setting parameters of model
due_dx = -0.41;
ue0 = 1;
Re_L = 10^5;
n = 301;

% Defined here as ue0 must change significance in turbulent solver
ue0_t = ue0;

% Initalise solution arrays
x = linspace(0,1,n);
theta = zeros(1,n);
He = zeros(1,n);
thick0 = zeros(1,2);

% Initalise index locators
int = 0; % Index of natural transition
ils = 0; % Index of laminar seperation
itr = 0; % Index of turbulent reattachment
its = 0; % Index of turbulent seperation

% Definie items required for loop
laminar = true;
i = 1;

while i <= n && laminar  % Loop runs while bl laminar and end not reached
    
    % Finding all required values using empirical relations
    ue = ue0 + due_dx*x(i);
    
    theta(i) = sqrt((0.45/Re_L)*(ue^-6)*ueintbit(x(1),ue0,x(i),ue));
    
    Re_theta = Re_L * ue * theta(i);

    m = -Re_L* theta(i)^2 * due_dx;

    H = thwaites_lookup(m);

    He(i) = laminar_He(H);
    
    % Detection of natrual transition
    if log(Re_theta) >= 18.4*He(i) - 21.74
        laminar = false;
        int = i;
        disp(append('NATURAL TRANSITION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
    end
    
    % Detection of laminar seperation
    if m > 0.09
        laminar = false;
        ils = i;
        He(i) = 1.5109;
        disp(append('LAMINAR SEPERATION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
    end

    i = i + 1;        
end

% Calculate del_e at separation for inital conditions to turbulent solver
del_e = He(i-1) * theta(i-1);

while i <=n && its == 0 % Loop runs while tbl attached and not at end
    
    % ue0 has changed meaning here to be the velocity at start of panel
    ue0 = ue0_t + due_dx*x(i-1);
    
    % Inital conditions for ode45 solution
    thick0(1) = theta(i-1);
    thick0(2) = del_e;
    
    [delx, thickhis] = ode45(@thickdash, [0, x(i) - x(i-1)], thick0);
    
    % Update theta and He after solution
    theta(i) = thickhis(end,1);
    del_e = thickhis(end,2);
    He(i) = del_e/theta(i);
    
    % Detection of turbulent reattachment
    if He(i) > 1.58 && itr == 0
        itr = i;
        disp(append('TURBULENT REATTACHMENT  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))   
    end

    % Dection of turbulent seperation
    if He(i) < 1.46
        its = i;
        H = 2.803;
        disp(append('TURBULENT SEPERATION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
    end
        
    i = i + 1 ;

end


while i <= n % Loop runs until end if tbl seperated

    theta(i) = theta(i-1) * ((ue0_t + due_dx*x(i-1))/(ue0_t + due_dx*x(i)))^(H +2);
    He(i) = He(i-1); % He stays constant (no reattachment)
    
    i = i + 1;
end

% Displays the index markers as requested
disp(append('Natural Transition Index: ', string(int)))
disp(append('Laminar Seperation Index: ', string(ils)))
disp(append('Turbulent Reattachment Index: ', string(itr)))
disp(append('Turbulent Seperation Index: ', string(its)))

% Displays zero pressure gradient Blausius solution
blas_theta = 0.664/sqrt(Re_L) * sqrt(x);

%% Plotting

% Initialize arrays to store plot handles and labels
plotHandles = [];
plotLabels = {};

figure(1)
hold on

plotHandles(end+1) = plot(x, He, 'DisplayName', '$H_{e}$');
plotLabels{end+1} = '$H_{e}$';

if ils ~= 0
    plotHandles(end+1) = xline(x(ils), '--', 'color', [.5 0 .5], 'DisplayName', 'Laminar separation');  
    plotLabels{end+1} = 'Laminar Separation';     
end

if int ~= 0
    plotHandles(end+1) = xline(x(int), '--', 'color', 'magenta', 'DisplayName', 'Natural Transition');
    plotLabels{end+1} = 'Turbulent transition';
end

if itr ~= 0 && int == 0
    plotHandles(end+1) = xline(x(itr), '--', 'color', 'green', 'DisplayName', 'Turbulent reattachment');
    plotLabels{end+1} = 'Turbulent Reattachment';
end

if its ~= 0
    plotHandles(end+1) = xline(x(its), '--', 'color', 'red', 'DisplayName', 'Turbulent seperation');
    plotLabels{end+1} = 'Turbulent seperation';
end

ylim([1.3 1.9])
grid on
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$H_{e}$', 'Interpreter', 'latex', 'FontSize', 20)

% Create the legend using plot handles and labels
legend([plotHandles], plotLabels, 'Interpreter', 'latex','Location','northwest')

print -deps2c exercises\week2\figures\w2e6_he_re5_41pg
% Initialize arrays to store plot handles and labels
plotHandles = [];
plotLabels = {};

figure(2)
hold on
% Correct the typo in plotHandles and use the correct variable
plotHandles(end+1) = plot(x, theta, 'DisplayName', 'Solver solution');
plotLabels{end+1} = 'Solver solution';

plotHandles(end+1) = plot(x, blas_theta, 'DisplayName', 'Blasius Solution $\left(\frac{dp}{dx}=0\right)$');
plotLabels{end+1} = 'Blasius Solution $\left(\frac{dp}{dx}=0\right)$';

if ils ~= 0
    plotHandles(end+1) = xline(x(ils), '--', 'color', [.5 0 .5], 'DisplayName', 'Laminar separation');  
    plotLabels{end+1} = 'Laminar Separation';     
end

if int ~= 0
    plotHandles(end+1) = xline(x(int), '--', 'color', 'magenta', 'DisplayName', 'Natural Transition');
    plotLabels{end+1} = 'Turbulent transition';
end

if itr ~= 0 && int == 0
    plotHandles(end+1) = xline(x(itr), '--', 'color', 'green', 'DisplayName', 'Turbulent reattachment');
    plotLabels{end+1} = 'Turbulent Reattachment';
end

if its ~= 0
    plotHandles(end+1) = xline(x(its), '--', 'color', 'red', 'DisplayName', 'Turbulent separation');
    plotLabels{end+1} = 'Turbulent separation';
end

grid on
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)

% Create the legend using plot handles and labels
legend(plotHandles, plotLabels, 'Interpreter', 'latex', 'Location', 'northwest')
hold off
print -deps2c exercises\week2\figures\w2e6_theta_re5_41pg