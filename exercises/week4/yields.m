function does_yield = yields(cps, pts)
npts = floor(size(pts, 2) / 2);
upper_pts = flip(pts(:, 1:npts+1), 2);
lower_pts = pts(:, npts+1:end);

% this is broken. I thought Cp would be given at every point but apparently
% not.
end_upper_cps = flip(cps(:, 1:npts+1), 2);
end_lower_cps = cps(:, npts+1:end);

x_bound = 0.5;
x = upper_pts(1, :);

end_x = upper_pts(1, x > x_bound);
end_upper_y = upper_pts(2, x > x_bound);
end_lower_y = lower_pts(2, x > x_bound);

end_upper_cps = end_upper_cps(x > x_bound);
end_lower_cps = end_lower_cps(x > x_bound);

does_yield = false;
%lens_up = sqrt((end_x(2:end)-end_x(1:end-1)).^2 + (end_upper_y(2:end)-end_upper_y(1:end-1)).^2);
%lens_lo = sqrt((end_x(2:end)-end_x(1:end-1)).^2 + (end_lower_y(2:end)-end_lower_y(1:end-1)).^2);
thick = thickness(upper_pts, lower_pts);

dydx_up = (end_upper_y(2:end)-end_upper_y(1:end-1)) ./ (end_x(2:end)-end_x(1:end-1));
dydx_lo = (end_lower_y(2:end)-end_lower_y(1:end-1)) ./ (end_x(2:end)-end_x(1:end-1));

% this is really slow as it checks yield at every point after x_bound.
% probably not necessary to do this and an algorithm that searches using
% the most likely places to fail would be better
for i=1:(length(end_x)-1)
    % compute moment at end_x(i) due to end_cps(i:end)
    
    thetas_up = atan(dydx_up(i+1:end));
    thetas_lo = atan(dydx_lo(i+1:end));
    % calculation needs improvement
    

    % these are lists of forces acting on panaels
    % this may need to compute 
    Fx_up = end_upper_cps(i+1:end) .* (end_x(i+1:end)-end_x(i:end-1)) .* sin(thetas_up);
    Fy_up = end_upper_cps(i+1:end) .* (end_upper_y(i+1:end)-end_upper_y(i:end-1)) .* cos(thetas_up);
    
    Fx_lo = end_lower_cps(i+1:end) .* (end_x(i+1:end)-end_x(i:end-1)) .* sin(thetas_lo);
    Fy_lo = end_lower_cps(i+1:end) .* (end_lower_y(i+1:end)-end_lower_y(i:end-1)) .* sin(thetas_lo);
    
    M = ((  Fx_up + Fx_lo) .* (end_x(i+1:end) - end_x(i)) + ...
            Fy_up .* (end_upper_y(i+1:end) - end_upper_y(i)) + ...
            Fy_lo .* (end_lower_y(i+1:end) - end_upper_y(i)))
    
    % is it sigma = M y / I
    I = 1; % need to calculate this somehow
    sigma = M * thick(i) / I;
    
    yield_sigma = 1e6;
    
    if (sigma > yield_sigma)
        does_yield = true;
        return;
    end
end

end