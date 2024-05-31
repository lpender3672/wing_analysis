
clear all

np = 100;
nx = floor(np/2);
xc = linspace(0, 1, nx);

y_t = 0.01 * xc .* (1 - xc);
flap_start = 0.5; % 60% chord
flap_gradient = -0.005;
flap_start_idx = floor(flap_start * nx);
flap_end_val = (xc(nx) - xc(flap_start_idx)) * flap_gradient;

y_c = zeros(1, nx);

y_c((flap_start_idx + 1):end) = linspace(0, flap_end_val, nx - flap_start_idx);

yup = y_c + y_t;
ylo = y_c - y_t;


ys = cat(2, flip(yup, 2), ylo(2:end));
xs = cat(2, flip(xc, 2), xc(2:end));

plot(xs, ys)
