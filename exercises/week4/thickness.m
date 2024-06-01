function thick = thickness(upper_pts,lower_pts)
%THICKNESS Summary of this function goes here
%   Detailed explanation goes here

% This is greatly simplified to a vertical plane cross section
% needs to be done using the cross section plane normal to mean line
% mean line is taken as x, (y1 + y2) / 2

y1 = upper_pts(2,:);
y2 = lower_pts(2,:);

thick = y1 - y2;
end

