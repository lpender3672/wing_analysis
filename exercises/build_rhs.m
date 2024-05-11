function rhsvec = build_rhs(xs,ys,alpha)

    np = length(xs) - 1;
    rhsvec = zeros(np+1, 1);

    psi_fs = ys * cos(alpha) - xs * sin(alpha);
    rhsvec(1:np, 1) =  psi_fs(1:np) - psi_fs(2:np+1);
