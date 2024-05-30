function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)

   cl = -2 * circ;
   

   ue = sqrt(1-cp(end));
   
   delstartot = delstarl(end) + delstaru(end);
   thetatot = thetal(end) + thetau(end);
   
   H = delstartot/thetatot;
   theta_ifty = thetatot * (ue^((H+5)/2));

   cd = 2*theta_ifty;
   
end