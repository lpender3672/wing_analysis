function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)

   cl = -2 * circ;
   
   H_l = delstarl(end) / thetal(end);
   H_u = delstaru(end) / thetau(end);
   ue = sqrt(1-cp(end));
   
   theta_ifty_l = thetal(end) * (ue ^ ((H_l + 5)/2));
   theta_ifty_u = thetau(end) * (ue ^ ((H_u + 5)/2));

   cd = 2 * (theta_ifty_l + theta_ifty_u);
   
end