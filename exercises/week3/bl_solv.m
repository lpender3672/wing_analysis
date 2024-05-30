function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
% Solves boundary layer flow over a set of panels
%   INPUTS
%   x: position array over which boundary layer solved
%   cp: array of pressure coefficient over x poisitions
%   OUTPUTS
%   int: Index of turbulent transition
%   ils: Index of laminar seperation
%   itr: Index of turbulent reattachment 
%   its: Index of turbulent seperation
%   delstar: Array of displacment thickness over x
%   theta: Array of momentum thicknss over x

    % Define global variables for parameters used in ode45
    global Re_L ue0 due_dx;
    
    % Setting parameters of model
    ue0 = 1.0;
    n = length(x); % Number of panels is number of points
    
    % Defined here as ue0 must change significance in turbulent solver
    ue0_t = ue0;
    
    % Initalise solution arrays
    theta = zeros(1,n);
    He = zeros(1,n);
    delstar = zeros(1,n); % Array taking displacement thickness
    thick0 = zeros(1,2);
    
    % Initalise index locators
    int = 0; % Index of natural transition
    ils = 0; % Index of laminar seperation
    itr = 0; % Index of turbulent reattachment
    its = 0; % Index of turbulent seperation
    
    % Definie items required for loop
    laminar = true;
    
    % Initialisation 
    ue = sqrt(1-cp(1));
    due_dx = (ue - 0)/(x(1));
    integral = ueintbit(0,ue0,x(1),ue);
    theta(1) = sqrt((0.45/Re_L)*(ue^-6)*integral);
 
    Re_theta = Re_L * ue * theta(1);
    m = -Re_L* theta(1)^2 * due_dx;
    H = thwaites_lookup(m);
    delstar(1) = H*theta(1);
    He(1) = laminar_He(H);
    
    %{
    % If transition or seperation occurs within the first panel
    if log(Re_theta) >= 18.4*He(1) - 21.74
        laminar = false;
        int = 1;
        %disp(append('NATURAL TRANSITION  -->  x: ',string(x(1)), ' Re_theta: ' ,string(Re_theta/1000)))
    end
        
    % Detection of laminar seperation
    if m > 0.09
        laminar = false;
        ils = 1;
        He(1) = 1.5109;
        %disp(append('LAMINAR SEPERATION  -->  x: ',string(x(1)), ' Re_theta: ' ,string(Re_theta/1000)))
    end
    %}
    ue = sqrt(1 - cp);

    i = 2;
    while i <= n && laminar  % Loop runs while bl laminar and end not reached
       
        % Finding all required values using empirical relations
        
        
        % Backwards difference method used to calculate

        due_dx = (ue(i) - ue(i-1))/(x(i) - x(i-1));
      
        integral = integral + ueintbit(x(i-1), ue(i-1), x(i), ue(i));
        theta(i) = sqrt((0.45/Re_L)*(ue(i)^-6)*integral);
        %disp(theta(i))
     
        Re_theta = Re_L * ue(i) * theta(i);
    
        m = -Re_L* theta(i)^2 * due_dx;
    
        H = thwaites_lookup(m);
        delstar(i) = H*theta(i);
        He(i) = laminar_He(H);

        
        % Detection of natrual transition
        if log(Re_theta) >= 18.4*He(i) - 21.74
            laminar = false;
            int = i;
            %disp(append('NATURAL TRANSITION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
        end
        
        % Detection of laminar seperation
        if m > 0.09
            laminar = false;
            ils = i;
            He(i) = 1.5109;
            %disp(append('LAMINAR SEPERATION  -->  x: ',string(x(i)), ' Re_theta: ' ,string(Re_theta/1000)))
        end
       
        i = i +1;
    end
    
    % Calculate del_e at separation for inital conditions to turbulent solver
    del_e = He(i-1) * theta(i-1);
    
    while i <= n && its == 0 % Loop runs while tbl attached and not at end
        
        % ue0 has changed meaning here to be the velocity at start of panel
        ue0 = ue(i);
        due_dx = (ue0-ue(i-1))/(x(i) - x(i-1));
        
        % Inital conditions for ode45 solution

        thick0(1) = theta(i-1);
        thick0(2) = del_e;
        
        [delx, thickhis] = ode45(@thickdash, [0, x(i) - x(i-1)], thick0);
        
        % Update theta and He after solution
        theta(i) = thickhis(end,1);
        del_e = thickhis(end,2);
        He(i) = del_e/theta(i);
        H = (11*He(i) + 15)/(48*He(i) - 59);
        delstar(i) = H*theta(i);
        % Detection of turbulent reattachment
        if He(i) > 1.58 && itr == 0
            itr = i;
        end
    
        % Dection of turbulent seperation
        if He(i) < 1.46
            its = i;
            H = 2.803;
            break
        end
        
        i = i + 1 ;
    end
    
    while i <= n % Loop runs until end if tbl seperated

        theta(i) = theta(i-1) * (ue(i-1)/ue(i))^(H+2);
        delstar(i) = H * theta(i); % H constant but theta varying
        He(i) = He(i-1); % He stays constant (no reattachment)
        i = i + 1;
    end

end