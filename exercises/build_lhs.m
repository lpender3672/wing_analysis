function lhsmat = build_lhs(xs,ys)

    np = length(xs) - 1;
    psip = zeros(np,np+1);

    xs_nc = xs(1:np); % non circular
    ys_nc = ys(1:np);

    [infa, infb_jm1] = panelinf_vec(xs(1),ys(1),xs(2),ys(2),xs_nc,ys_nc);
    psip(:,1) = infa;

    for j = 2:np % This loop is tricky to vectorize as panelinf_vec would need to be modified 
        % to take in vector panel coordinates then perform the coordinate transformations in vectorized form, 
        % and return the influence coefficients in the form of (n_panels, shape_of_meshgrid)

        [infa, infb] = panelinf_vec(xs(j),ys(j),xs(j+1),ys(j+1),xs_nc,ys_nc);
        psip(:,j) = infa + infb_jm1;

        infb_jm1 = infb;
    end

    psip(:,np+1) = infb_jm1;

    lhsmat = zeros(np+1,np+1);
    lhsmat(1:np-1, :) =  psip(2:np,:) - psip(1:np-1,:);

    lhsmat(np,1) = 1; 
    lhsmat(np+1,np+1) = 1;
