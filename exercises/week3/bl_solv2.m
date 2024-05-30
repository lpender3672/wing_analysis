function [int, ils, itr, its, delstar, theta] = bl_solv2(x,cp)
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

    global Re_L ue0 due_dx;

    n = length(x);

    theta = zeros(1,n+1);
    He = zeros(1,n+1);
    delstar = zeros(1,n+1); % Array taking displacement thickness
    thick0 = zeros(1,2);

    int = 0; % Index of natural transition
    ils = 0; % Index of laminar seperation
    itr = 0; % Index of turbulent reattachment
    its = 0; % Index of turbulent seperation

    ue = zeros(1,n+1);
    ue(1) = 1;
    disp(length(ue(2:end)))
    disp(length(cp))
    ue(2:end) = sqrt(1 - cp); % Calculating ue everywhere
    due_dx_vec = zeros(1,n);
    due_dx_vec(1) = (ue(2) - ue(1))/x(1);
    due_dx_vec(2:end) = (ue(3:end) - ue(2:end-1))/(x(2:end) - x(1:end-1));
 
    
    i = 1;
    laminar = false;
    integral = 0;
    
    while i < n + 1 && laminar
        i = i + 1;

        integral = integral + ueintbit(x(i-1), ue(i-1), x(i), ue(i));
        theta(i) = sqrt((0.45/Re_L)*(ue(i)^-6)*integral);
    
        Re_theta = Re_L * ue(i) * theta(i);
        m = -Re_L* theta(i)^2 * due_dx_vec(i);

        H = thwaites_lookup(m);
        delstar(i) = H*theta(i);
        He(i) = laminar_He(H);

        if log(Re_theta) >= 18.4*He(i) - 21.74
            laminar = false;
            int = i-1;
        end
        
        % Detection of laminar seperation
        if m > 0.09
            laminar = false;
            ils = i-1;
            He(i) = 1.5109;
        end
    end

    

    while i < n && its == 0
        i = i+1;

        % calculate conditions at start of panel
        ue0 = ue(i-1);
        due_dx = due_dx_vec(i);
        del_e = He(i-1) * theta(i-1);
        thick0(1) = theta(i-1);
        thick0(2) = del_e;
        
        [delx, thickhis] = ode45(@thickdash, [0, x(i) - x(i-1)], thick0);

        theta(i) = thickhis(end,1);
        del_e = thickhis(end,2);
        He(i) = del_e/theta(i);
        
        if He(i) >= 1.46
            H = (11*He(i) +15)/(48*He(i) -59);
        else
            H = 2.803;
        end
        delstar(i) = H*theta(i);
        
        % Detect turbulent reattachment
        if He(i) > 1.58 && itr == 0
            itr = i-1;
        end

        % Detection of turbulent seperation
        if He(i) < 1.46
            its = i-1;
        end
    end
    

    while i < n+1
        i = i + 1;
        theta(i) = theta(i-1) * (ue(i-1)/ue(i))^(H+2);
        delstar(i) = H * theta(i); % H constant but theta varying
        He(i) = He(i-1); % He stays constant (no reattachment)
    end

    delstar = delstar(2:end);
    theta = theta(2:end);

    
end