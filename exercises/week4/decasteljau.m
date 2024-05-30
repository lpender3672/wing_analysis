function point = decasteljau(t, pts, i, j)
    if i == 1
        point = pts(:, j);
    else
        point = t * decasteljau(t, pts, i - 1, j) + (1 - t) * decasteljau(t, pts, i - 1, j - 1);
    end
end

