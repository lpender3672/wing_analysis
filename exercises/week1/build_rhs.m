function rhsvec = build_rhs(xs,ys,alpha)
%   Creates vector required for panel method solution
%   xs: x-positions of panel end points
%   ys: y-positions of panel end points
%   alpha: Incidence of incoming uniform flow
%   rhsvec: b vector required for panel method solution
    
    % Number of panels
    np = length(xs) - 1;

    % Initalising b vector
    rhsvec = zeros(np+1, 1);
    
    % Create the uniform flow streamfunction
    psi_fs = ys * cos(alpha) - xs * sin(alpha);

    % Creation of b vector from difference in unifom flow streamfunction
    rhsvec(1:np-1, 1) =  psi_fs(1:np-1) - psi_fs(2:np);

    % Last two entries remain zero (auxiliary equations)
end
