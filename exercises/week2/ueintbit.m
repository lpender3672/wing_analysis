function f = ueintbit(xa,ua,xb,ub)
%   Evaluates integral in Thwaites solution using linear ue
%   xa = lower limit of integration
%   ua = velocity at xa
%   xb = upper limit of integration
%   ub = velocity at xb
%   f = Integral in thwaites method
    
    % Defining quantities for readability
    del_u = ub - ua;
    del_x = xb - xa;
    u_bar = (ua + ub)/2;
    
    % Evaluation of integral using linear variation in ue
    f = (u_bar.^5 + (5/6)*(u_bar.^3).*(del_u.^2) + (1/16)*u_bar.*(del_u.^4)).*del_x;
end
