function [infa, infb] = refpaninf(del,X,Yin)
    %REFPANINF Summary of this function goes here
    %   Detailed explanation goes here
    
    if abs(Yin) < 1e-9
        Y = 1e-9;
    else
        Y = Yin;
    end


    Rsq = X.^2 + Y.^2;
    Rmdsq = (X-del).^2 + Y.^2;

    I_0 = - 1/ (4*pi) * ( ...
        X*log(Rsq) - ...
        (X-del)*log(Rmdsq) - ...
        2*del + 2*Y*( ...
        atan(X / Y) - ...
        atan((X-del) / Y) ...
            ) ...
        );

    I_1 = 1 / (8 * pi) * ( ...
        Rsq * log(Rsq) - ...
        Rmdsq * log(Rmdsq) ...
        - 2*X*del + del.^2);

    infa = (1- X/del) * I_0 - 1 / del * I_1;

    infb = X / del * I_0 + 1 / del * I_1;

end

