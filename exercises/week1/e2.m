clear
close all;

x = linspace(-2.5,2.5,401);
y = linspace(-2,2,321);

del = 1.5;

[xm, ym] = meshgrid(x, y);

inf1 = zeros(length(x),length(y));
inf2 = zeros(length(x),length(y));

for i=1:length(x)
    for j=1:length(y)
        [inf1(i,j),inf2(i,j)] = refpaninf(del,x(i), y(j));

    end
end

c = -0.15:0.05:0.15;

hold on

contour(xm,ym,inf1',c)
contour(xm,ym,inf2',c,'--')

hold off