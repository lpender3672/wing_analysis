clear
close all 

datafile = "Data\0012_det_4.mat";
datafile_ov = "Data\0012_swp.mat";

alpha = 5; 

data_struct = open(datafile);
data_struct_ov = open(datafile_ov);

psi = data_struct.psi;
xs = data_struct_ov.xs;
ys = data_struct_ov.ys;
xm = data_struct.xm;
ym = data_struct.ym;

xm_r = xm*cosd(alpha) + ym*sind(alpha);
ym_r = -xm*sind(alpha) + ym*cosd(alpha); 

xs_r = xs*cosd(alpha) + ys*sind(alpha);
ys_r = -xs*sind(alpha) + ys*cosd(alpha); 

c = -0.5:0.02:0.4;
hold on
contour(xm_r,ym_r,psi,c)
plot(xs_r,ys_r,'color','r')
hold off
axis image
xlim([-0.3,1.3])
ylim([-0.4,0.4])
