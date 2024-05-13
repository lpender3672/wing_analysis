function rhsvec = build_rhs_nonv(xs,ys,alpha)
%   Creates vector required for panel method solution
%   xs: x-positions of panel end points
%   ys: y-positions of panel end points
%   alpha: Incidence of incoming uniform flow
%   rhsvec: b vector required for panel method solution
    
    % Number of panels
    np = length(xs) - 1;
    
    % Initalising b vector
    rhsvec = zeros(np+1,1);
    
    % Find difference in free stream phi between panel ends
    for i=1:np-1
        rhsvec(i) = (ys(i)*cos(alpha) - xs(i)*sin(alpha)) - (ys(i+1)*cos(alpha) - xs(i+1)*sin(alpha));
    end
    
    % Last two entries remain zero (auxiliary equations)
end
