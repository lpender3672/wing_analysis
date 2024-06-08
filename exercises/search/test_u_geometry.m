
global Re_L np

np = 800;

Re_L = 3e6;
u_naca0012 = geometric_uncertainty('naca0012', 5)
Re_L = 20e6;
u_v23 = geometric_uncertainty('0012search_v23', 5)
Re_L = 0.5e6;
u_m21 = geometric_uncertainty('0012search_m21', 5)