function clcd = bezierNd(y_points)
%BEZIER2D A function which returns the negative lift over drag to be
% minimised by an optimsation algorithm
% 
% y_points, a 2d vector representing bezier point y values for [upper,
% lower] surfaces at x = 0.5
nyp = length(y_points);
half_nyp = floor(nyp/2);
x_points = linspace(0, 1, half_nyp + 2);

global alpha Re_L np id

upper_pts = [   0, x_points;
    0, 0.2, y_points(1:half_nyp), 0];

lower_pts = [   0, x_points;
    0, -0.2, y_points(half_nyp+1:end), 0];

pts = bezier(upper_pts, lower_pts, np, id);

if isempty(pts)
    %disp("Upper and lower surfaces intersect")
    clcd = inf;
    return;
end

xk = pts(1, :);
yk = pts(2, :);

%nphr = 5*np;
%[xshr yshr] = splinefit ( xk, yk, nphr );

%  Resize section so that it lies between (0,0) and (1,0)
%[xsin ysin] = resyze ( xshr, yshr );

%  Interpolate to required number of panels (uniform size)
[xs ys] = make_upanels ( xk, yk, np );

% build vortex sheet variables
A = build_lhs ( xs, ys );
Am1 = inv(A);
b = build_rhs ( xs, ys, alpha );

%    solve for surface vortex sheet strength
gam = Am1 * b;

%    calculate cp distribution and overall circulation
[cp circ] = potential_op ( xs, ys, gam );

%    locate stagnation point and calculate stagnation panel length
[ipstag fracstag] = find_stag(gam);
dsstag = sqrt((xs(ipstag+1)-xs(ipstag))^2 + (ys(ipstag+1)-ys(ipstag))^2);

%    upper surface boundary layer calc

%    first assemble pressure distribution along bl
clear su cpu
su(1) = fracstag*dsstag;
cpu(1) = cp(ipstag);
for is = ipstag-1:-1:1
    iu = ipstag - is + 1;
    su(iu) = su(iu-1) + sqrt((xs(is+1)-xs(is))^2 + (ys(is+1)-ys(is))^2);
    cpu(iu) = cp(is);
end

%    check for stagnation point at end of stagnation panel
if fracstag < 1e-6
    su(1) = 0.01*su(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpu(2));
    cpu(1) = 1 - uejds^2;
end

%    boundary layer solver
[iunt iuls iutr iuts delstaru thetau] = bl_solv ( su, cpu );

%    lower surface boundary layer calc

%    first assemble pressure distribution along bl
clear sl cpl
sl(1) = (1-fracstag) * dsstag;
cpl(1) = cp(ipstag+1);
for is = ipstag+2:np+1
    il = is - ipstag;
    sl(il) = sl(il-1) + sqrt((xs(is-1)-xs(is))^2 + (ys(is-1)-ys(is))^2);
    cpl(il) = cp(is);
end

%    check for stagnation point at end of stagnation panel
if fracstag > 0.999999
    sl(1) = 0.01*sl(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpl(2));
    cpl(1) = 1 - uejds^2;
end

%    boundary layer solver
[ilnt ills iltr ilts delstarl thetal] = bl_solv ( sl, cpl );

%    lift and drag coefficients
[Cl Cd] = forces ( circ, cp, delstarl, thetal, delstaru, thetau );

%    copy Cl and Cd into arrays for alpha sweep plots

%clswp(nalpha) = Cl;
%cdswp(nalpha) = Cd;
clcd = -Cl/Cd;

end

