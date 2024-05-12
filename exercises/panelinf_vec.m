function [infa, infb] = panelinf_vec(xa,ya,xb,yb,xm,ym)
% Function to return the influence coefficients of a vortex sheet panel.
%   del: length of the reference panel
%   X: x coordinates of the meshgrid
%   Y: y coordinates of the meshgrid
    
    % Calculate the normal and tangential vectors of the panel
    del = sqrt((xb-xa)^2 + (yb-ya)^2);
    tx = (xb-xa)/del;
    ty = (yb-ya)/del;
    nx = -ty;
    ny = tx;

    % Transform the meshgrid to the panel coordinate system
    rx = xm - xa;
    ry = ym - ya;
    X = rx * tx + ry * ty;
    Y = rx * nx + ry * ny;

    % Replace values under 1e-9 with 1e-9 using boolean indexing
    % to avoid division by zero
    Y(abs(Y) < 1e-9) = 1e-9; 

    Rsq = X.^2 + Y.^2;
    Rmdsq = (X-del).^2 + Y.^2;

    I_0 = - 1/ (4*pi) * ( ...
        X.*log(Rsq) - ...
        (X-del).*log(Rmdsq) - ...
        2*del + 2*Y.*( ...
        atan(X./Y) - ...
        atan((X-del)./Y) ...
            ) ...
        );

    I_1 = 1 / (8 * pi) * ( ...
        Rsq.* log(Rsq) - ...
        Rmdsq.* log(Rmdsq) ...
        - 2*X*del + del^2);

    infa = (1- X/del).* I_0 - 1 / del * I_1;

    infb = (X / del).* I_0 + 1 / del * I_1;

end
