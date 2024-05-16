

m = linspace(-0.5, 0.5, 100);

H = zeros(length(m), 1);

H_vec = thwaites_lookup_vec(m);

for i = 1:length(m)
    H(i) = thwaites_lookup(m(i));
end

check = H == H_vec