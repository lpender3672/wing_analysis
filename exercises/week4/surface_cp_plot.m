
clear all
% plot surface cp as a colour
% y is panel index or path length or x coordinate
% x is alpha or Re_L or whatever

np = 300;

data_file = 'bezier.mat';
data_struc = load(data_file);

if isfield(data_struc, 'alpha')
    alpha = data_struc.alpha;
else
    error('The variable "alpha" is not found in the input file.');
end

if isfield(data_struc, 'clswp')
    clswp = data_struc.clswp;
else
    error('The variable "clwp" is not found in the input file.');
end

if isfield(data_struc, 'cdswp')
    cdswp = data_struc.cdswp;
else
    error('The variable "cdwp" is not found in the input file.');
end

if isfield(data_struc, 'lovdswp')
    lovdswp = data_struc.lovdswp;
else
    error('The variable "lovdswp" is not found in the input file.');
end

if isfield(data_struc, 'cpdists')
    cpdists = data_struc.cpdists;
else
    error('The variable "lovdswp" is not found in the input file.');
end

% load fixed geometry
section = 'bezier';
secfile = ['Geometry/' section '.surf'];
[xk, yk] = textread ( secfile, '%f%f' );
np = length(cpdists) - 1;
nphr = 5*np;
[xshr, yshr] = splinefit ( xk, yk, nphr );
%  Resize section so that it lies between (0,0) and (1,0)
[xsin, ysin] = resyze ( xshr, yshr );
%  Interpolate to required number of panels (uniform size)
[xs, ys] = make_upanels ( xsin, ysin, np );

[cpdists_u, cpdists_l] = seperate(cpdists);
[xs_u, xs_l] = seperate(xs);
[ys_u, ys_l] = seperate(ys);

lens_u = sqrt((xs_u(2:end)-xs_u(1:end-1)).^2 + (ys_u(2:end)-ys_u(1:end-1)).^2);
lens_l = sqrt((xs_l(2:end)-xs_l(1:end-1)).^2 + (ys_l(2:end)-ys_l(1:end-1)).^2);
surface_u = [0, cumsum(lens_u)];
surface_l = [0, cumsum(lens_l)];

subplot(1,2, 1);

hold on

scatter_points = surface_u(1:3:end);
[scatter_x, scatter_y] = meshgrid(scatter_points, alpha);
color_values = cpdists_u(:,1:3:end);

%scatter(scatter_x, scatter_y, 5*ones(size(scatter_x)), color_values, 'filled', 'o');
% do we need to flatten the meshgrid to do a scatterplot?
scatter(scatter_x(:), scatter_y(:), 5*ones(size(scatter_x(:))), color_values(:), 'filled', 'o');

legend()

npts = size(surface_u, 2);
ints = data_struc.iunts; % indicies of natural transition
ilss = data_struc.iulss; % indicies of laminar seperation
itrs = data_struc.iutrs; % indicies of turbulent reattachment
itss = data_struc.iutss; % indicies of turbulent seperation
xnts = surface_u(ints(ints ~= 0 & ints <= npts));
xlss = surface_u(ilss(ilss ~= 0 & ilss <= npts));
xtrs = surface_u(itrs(itrs ~= 0 & itrs <= npts));
xtss = surface_u(itss(itss ~= 0 & itss <= npts));
scatter(xnts, alpha(ints ~= 0 & ints <= npts))
scatter(xlss, alpha(ilss ~= 0 & ilss <= npts))
scatter(xtrs, alpha(itrs ~= 0 & itrs <= npts))
scatter(xtss, alpha(itss ~= 0 & itss <= npts))


legend('Cp Colour Bar', 'Natural Transition', 'Laminar Separation', 'Turbulent Reattachment', 'Turbulent Separation')


hold off

subplot(1,2, 2);
hold on
for i=1:length(alpha)
    alp = alpha(i);
    
    scatter_points = surface_l(1:3:end);
    color_values = cpdists_l(i,1:3:end);
    
    scatter(scatter_points, alp*ones(size(scatter_points)), 5*ones(size(scatter_points)), color_values, 'filled', 'o');

end
hold off


function [up_var, low_var] = seperate(var)
    npts = floor(size(var, 2) / 2);
    up_var = flip(var(:, 1:npts+1), 2);
    low_var = var(:, npts+1:end);
end

