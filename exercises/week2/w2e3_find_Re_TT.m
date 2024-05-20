clear
close all

% Trial various reynolds numbers
Re_L_array = logspace(log10(8*10^5), log10(9*10^5), 10000);
due_dx = -0.25;

% x = x/L setting domain
n = 101;
x = linspace(0,1,n);


% Looping through trial Reynolds numbers
for i=1:length(Re_L_array)
    laminar = true;
    int = 0;
    ils = 0;

    % Setting flow Reynolds number
    Re_L = Re_L_array(i);
 
    % Setting ue = ue/U based on velocity gradient due_dx
    ue = 1 + due_dx*x;
    
    % The fastest way of doing this might be to search for the point of
    % seperation, then vectorise the calculation up until that point
    k = 1;
    while laminar && k < n
        % Calculate the integral in Thwaites solution over vector x
        f = ueintbit(x(1),ue(1),x(k),ue(k));
        
        % Calculating theta/L using Thwaites solution
        theta = sqrt((0.45/Re_L)*(ue(k)^-6)*f);
        
        % Creating reynolds number
        Re_theta = Re_L*ue(k)*theta;
        
        % Calculating He
        m = -Re_L*(theta^2)*due_dx;
        H = thwaites_lookup(m);
        He = laminar_He(H);
        
        if log(Re_theta) >= 18.4*He - 21.74
            % Flow has transitioned from laminar to turbulent
            laminar = false;
            % Store int meaning index where natural transition occurs
            int = k;

        elseif m >= 0.09
            % Flow has seperated to become turbulent
            laminar = false;
            % Store int meaning index where seperation transition
            ils = k;
        end

        k = k+1;
    end


    if int ~= 0
        % Natural transition has occured 
        disp(['Natural transition at ' num2str(x(int)) ...
         ' with Rethet ' num2str(Re_theta) ' at Re_L ' num2str(Re_L)])
        break % Break loop so only first Re_L that gives seperation is shown
    end

end

