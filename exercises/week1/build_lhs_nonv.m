function lhsmat = build_lhs_nonv(xs,ys)
%   Builds main matrix required for panel methods
%   xs: x-positions of panel edges
%   ys: y-positions of panel edges
%   lhsmat: A matrix containing equations for panel solution
    
    % Number of panels 
    np = length(xs)-1;

    % Initalise matrix psip   
    psip = zeros(np,np+1);

    % Populate matrix psip with required influence coefficients
    for i=1:np
        [inf1,inf2] = panelinf_vec(xs(1),ys(1),xs(2),ys(2),xs(i),ys(i));
        
        psip(i,1) = inf1;
        
        for j=2:np
            psip(i,j) = inf2;
            [inf1,inf2] = panelinf_vec(xs(j),ys(j),xs(j+1),ys(j+1),xs(i),ys(i));
            psip(i,j) = psip(i,j) + inf1;
        end
        
        psip(i,np+1) = inf2;
    end

    % Initalise A matrix
    lhsmat = zeros(np+1,np+1);
    
    % Populate first np-1 rows of A matrix using psip
    for i=1:np-1
        for j=1:np+1
            lhsmat(i,j) = psip(i+1,j) - psip(i,j);
        end
    end
    
    % Auxiliary equations used to populate final rows of A matrix
    lhsmat(np,1) = 1;
    lhsmat(np,np+1) = 1;
    
    lhsmat(np+1,2) = -1;
    lhsmat(np+1,3) = 1/2;
    lhsmat(np+1,np-1) = -1/2;
    lhsmat(np+1, np) = 1;
    lhsmat(np+1, np+1) = -1;
end
