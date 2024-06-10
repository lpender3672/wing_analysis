function out_pts = bezier(upper_pts, lower_pts, np, id)
%BEZIER Summary of this function goes here
%   Detailed explanation goes here
% N order bezier curve
upper_order = size(upper_pts, 2);
lower_order = size(lower_pts, 2);

c_up = zeros(2, np);
c_lo = zeros(2, np);

t = linspace(0,1,np);
for i=1:np
    c_up(:,i) = decasteljau(t(i), upper_pts, upper_order, upper_order);
    c_lo(:,i) = decasteljau(t(i), lower_pts, lower_order, lower_order);
end

% if the upper surface intersects lower surface
if intersects(c_up, c_lo)
    % Dont return or write anything. This is an invalid design
    out_pts = [];
    return;
else
    out_pts = cat(2, flip(c_up, 2), c_lo(:,2:end));

fname = ['Geometry/bezier' id '.surf'];

fid = fopen(fname,'w');
fprintf ( fid, '%10.6f %10.6f \n', out_pts );
fclose(fid);

%{
hold on
plot(c_up(1,:), c_up(2,:))
plot(c_lo(1,:), c_lo(2,:))
axis equal
hold off
%}

end
