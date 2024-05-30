clear all;

%% https://github.com/trailingend/matlab-de-casteljau

% Init control polygon
figure;
hold on
axis([-.1 1.1 -.5 .5]);

x = [0, 1];
y = [0, 0];

% Add additional points interactively
plot(x, y, 'b-o');
hold off

[x_new, y_new] = getpts();
x = [0, x_new', 1];
y = [0, y_new', 0];

canManipulatePts = false;

while (true)
    clf;
    % Plot control polygon
    plot(x, y, 'b-o');
    hold on;

    % Allocate Memory for curve
    stepSize = 0.01; % hundreds pts + 1
    u = 0: stepSize: 1;
    numOfU = length(u);
    c = zeros(2, numOfU);

    % Iterate over curve and apply deCasteljau
    numOfPts = length(x);
    pts = [x; y];
    for i = 1: numOfU
        ui = u(i);
        c(:, i) = decasteljau(ui, pts, numOfPts, numOfPts);
    end

    % Plot curve
    axis([-.1 1.1 -.5 .5]);
    plot(c(1, :), c(2, :), '-r');
    canManipulatePts = true;

    % Manipulate points
    if (canManipulatePts)
        pts = reposition(pts);
        x = pts(1, :);
        y = pts(2, :);
    end
end



function cPoly = reposition(cPoly)
    % Select point
    pointSelected = false;
    edgeSelected = false;
    i = -1;
    idx_prev = -1;
    idx_next = -1;
    while not (pointSelected)
        
        [a, b] = ginput(1);
        diffX = abs(cPoly(1, :) - a);
        diffY = abs(cPoly(2, :) - b);
        [minX, iX] = min(diffX);
        [minY, iY] = min(diffY);
        
        dist = sqrt((cPoly(1, :) - a) .^ 2 + (cPoly(2, :) - b) .^ 2);
        dist_sorted = sort(dist);
        dist1 = dist_sorted(1);
        dist2 = dist_sorted(2);
        idx_1 = find(dist == dist1);
        idx_2 = find(dist == dist2);
        if iX == iY && minX < 0.1 && minY < 0.1
            i = iX;
            pointSelected = true;
            break;
        elseif abs(idx_1 - idx_2) == 1            
            if (idx_1 < idx_2)
                idx_prev = idx_1;
                idx_next = idx_2;
            else
                idx_prev = idx_2;
                idx_next = idx_1;
            end
            edgeSelected = true;
            break;
        end
    end
    
    % Select new pos
    if (pointSelected)
        scatter(cPoly(1, i), cPoly(2, i), 'g');
        [a, b] = ginput(1);
        cPoly(1, i) = a;
        cPoly(2, i) = b;
    end
    
    if (edgeSelected)
        disp(idx_prev)
        disp(idx_next)
        plot(cPoly(1, idx_prev: idx_next), cPoly(2, idx_prev: idx_next), 'g-');
        [a, b] = ginput(1);
        idx_curr = idx_prev;
        cPoly = [cPoly(1, 1: idx_curr) a cPoly(1, idx_curr + 1: end); cPoly(2, 1: idx_curr) b cPoly(2, idx_curr + 1: end)];
    end
end