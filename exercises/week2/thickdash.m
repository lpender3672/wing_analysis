function dthickdx = thickdash(xmx0, thick)
    global Re_L ue0 due_dx

    ue = ue0 + due_dx*xmx0;
    dthickdx = zeros(2,1);
    
    Re_theta = Re_L * ue * thick(1); 

    He = thick(2)/thick(1);
    
    if He >= 1.46
        H = (11*He + 15)/(48*He - 59);
    
    else 
        H = 2.803;
    end

    cf = 0.091416*((H-1)* Re_theta )^-0.232 * exp(-1.26*H);
    
    c_diss = 0.010024*((H-1)*Re_theta)^(-1/6);

    dthickdx(1) = cf/2 - ((H+2)/ue)*due_dx*thick(1);
    dthickdx(2) = c_diss - (3/ue)*due_dx*thick(2);
 
end