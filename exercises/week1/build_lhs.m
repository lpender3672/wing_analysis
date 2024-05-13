function lhsmat = build_lhs(xs,ys)

    % Number of panels 
    np = length(xs) - 1;

    % Initalise matrix psip   
    psip = zeros(np,np+1);

    % Slicing the circular array to be non circular outside the loop
    xs_nc = xs(1:np); 
    ys_nc = ys(1:np);
    
    % Populate matrix psip with required influence coefficients
    % Calculate initial coefficients
    [infa, infb_jm1] = panelinf_vec(xs(1),ys(1),xs(2),ys(2),xs_nc,ys_nc);
    % Set the first column to infa
    psip(:,1) = infa;
    % infb isnt used until the next iteration so its called infb_jm1

    for j = 2:np 
        % This loop is tricky to vectorize as panelinf_vec would need to be modified 
        % to take in vector panel coordinates then perform the coordinate transformations in vectorized form, 
        % and return the influence coefficients in the form of (n_panels, shape_of_meshgrid)

        [infa, infb] = panelinf_vec(xs(j),ys(j),xs(j+1),ys(j+1),xs_nc,ys_nc);

        % Populate column with required influence coefficients
        psip(:,j) = infa + infb_jm1;

        % Update infb_jm1
        infb_jm1 = infb;
    end

    % Set the last column to infb_jm1
    psip(:,np+1) = infb_jm1;

    % Initialise lhsmat
    lhsmat = zeros(np+1,np+1);

    % Populate first np-1 rows of A matrix using psip
    lhsmat(1:np-1, :) =  psip(2:np,:) - psip(1:np-1,:);

    % Auxiliary equations used to populate final rows of A matrix
    lhsmat(np,1) = 1;
    lhsmat(np+1,np+1) = 1;
