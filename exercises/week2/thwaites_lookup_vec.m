function H = thwaites_lookup_vec(m)
%
%  function H = thwaites_lookup(m)
%
%  Returns interpolated value of shape factor 
%  for the specified value of Thwaites' 'm' parameter.  Based on tabulated
%  values in Young, p90.
%

H = zeros(length(m), 1);

H(m <= -0.25) = 2;

H(m >= 0.09) = 3.55;

mtab = [-.25 -.2 -.14 -.12 -.1 -.08 -.064 -.048 -.032 -.016 .0 .016 .032 ...
             .04 .048 .056 .06 .064 .068 .072 .076 .080 .084 .086 .088 .09];

Htab = [2 2.07 2.18 2.23 2.28 2.34 2.39 2.44 2.49 2.55 2.61 2.67 2.75 ...
       2.81 2.87 2.94 2.99 3.04 3.09 3.15 3.22 3.3 3.39 3.44 3.49 3.55];

central_mask = (m >= -0.25) & (m <= 0.09);
H(central_mask) = interp1(mtab,Htab,m(central_mask));

end

