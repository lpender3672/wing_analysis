function does_intersect = intersects(Apts, Bpts)
%INTERSECTS Summary of this function goes here
%   Detailed explanation goes here

x1 = Apts(1, :);
y1 = Apts(2, :);

x2 = Bpts(1, :);
y2 = Bpts(2, :);


if length(x1) < 2 || length(x2) < 2
    error("Each line must have at least two points.");
end

% assume lines dont intersect until found otherwise
does_intersect = false;

% iterate over segments of line 1
for i = 1:length(x1)-1
    % a current line segment of line 1
    x1_seg = [x1(i), x1(i+1)];
    y1_seg = [y1(i), y1(i+1)];

    % iterate over segments of line 2
    for j = 1:length(x2)-1
        % ends of current line segment for line 2
        x2_seg = [x2(j), x2(j+1)];
        y2_seg = [y2(j), y2(j+1)];

        % slope and intercept of line1 segment
        m1 = (y1_seg(2) - y1_seg(1)) / (x1_seg(2) - x1_seg(1));
        b1 = y1_seg(1) - m1 * x1_seg(1);

        % slope and intercept of line2 segment
        m2 = (y2_seg(2) - y2_seg(1)) / (x2_seg(2) - x2_seg(1));
        b2 = y2_seg(1) - m2 * x2_seg(1);

        % if the lines are not parallel
        % (the difference is more than largest error due to machine
        % precision)
        if abs(m1 - m2) > eps(max(abs(m1), abs(m2)))
            % calculate the intersection point
            x_intersect = (b2 - b1) / (m1 - m2);
            y_intersect = m1 * x_intersect + b1;

            % if the intersection point lies within both line segments
            % and is not at leading edge at (0, 0) or trailing edge at (1, 0)
            if      (min(x1_seg) <= x_intersect && x_intersect <= max(x1_seg)) && ...
                    (min(y1_seg) <= y_intersect && y_intersect <= max(y1_seg)) && ...
                    (min(x2_seg) <= x_intersect && x_intersect <= max(x2_seg)) && ...
                    (min(y2_seg) <= y_intersect && y_intersect <= max(y2_seg)) && ...
                    ~((abs(x_intersect - 0) < eps && abs(y_intersect - 0)  < eps) || ...
                      (abs(x_intersect - 1) < eps && abs(y_intersect - 0) < eps))
                does_intersect = true;
                return;
            end
        end
    end
end
end