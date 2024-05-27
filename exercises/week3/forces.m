function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)

   cl = -2 * circ;
   
   He_l = delstarl(end) / thetal(end);
   He_u = delstaru(end) / thetau(end);
   
   theta_ifty_l = thetal(end)
   

end