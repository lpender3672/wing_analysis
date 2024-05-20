clear
close all

% Define global variables for the ode45 for parameters used in ode45
global Re_L ue0 due_dx;

% Setting parameters of model
due_dx = -0.95;
ue0 = 1;
Re_L = 10^6;
n = 101;

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
        its = 1;
        H = 2.803;
        disp(append('TURBULENT SEPERATION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
    end
        
    i = i + 1 ;

end


while i <= n % Loop runs until end if tbl seperated

    theta(i) = theta(i-1) * ((ue0_t + due_dx*x(i-1))/(ue0_t + due_dx*x(i)))^(H +2);
    He(i) = He(i-1); %  NOT SURE ABOUT THIS STEP !!!!!
    
    i = i + 1;
end

% Displays the index markers as requested
%disp(append('Natural Transition Index: ', string(int)))
%disp(append('Laminar Seperation Index: ', string(ils)))
%disp(append('Turbulent Reattachment Index: ', string(itr)))
%disp(append('Turbulent Seperation Index: ', string(its)))

% Displays zero pressure gradient Blausius solution
blas_theta = 0.664/sqrt(Re_L) * sqrt(x);

%% Plotting
figure(1)
plot(x,He)
yline(1.58,'color','g','linestyle','--') % Turbulent reattachment
yline(1.46,'color','r','linestyle','--') % Turbulent seperation
title('$H_{e}$ Variation', 'Interpreter', 'latex')
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$H_{e}$', 'Interpreter', 'latex', 'FontSize', 20)
legend('$H_{e}$','Turbulent Reattachment','Turbulent Seperation','Interpreter','latex')

figure(2)
hold on
plot(x,theta)
plot(x,blas_theta)
title('$\theta$ Variation', 'Interpreter', 'latex')
xlabel('$\frac{x}{L}$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel('$\frac{\theta}{L}$', 'Interpreter', 'latex', 'FontSize', 20)
legend('Solver Solution', 'Blasius Solution (dp/dx=0)')
hold off
