
disp("Hello World!")
x = linspace(-2.5, 2.5, 1000);
y = linspace(-2, 2, 1000);

MGRID = meshgrid(x,y);

xc = 0.5;
yc = 0.25;
Gamma = 3.0;

function psi = psimat(x, y)
psi = 0
end
