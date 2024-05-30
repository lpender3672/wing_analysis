function out_pts = bezier(pts, np, id)
%BEZIER Summary of this function goes here
%   Detailed explanation goes here
% N order bezier curve
nb = size(pts, 2);
order = floor(nb / 2);

upper_pts = pts(:, 1:order);
lower_pts = pts(:, order+1:end);
c_up = zeros(2, np);
c_lo = zeros(2, np);

t = linspace(0,1,np);
for i=1:np
    c_up(:,i) = decasteljau(t(i), upper_pts, order, order);
    c_lo(:,i) = decasteljau(t(i), lower_pts, order, order);
end

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
