clear
close all

laminar = true;
due_dx = -0.2;
ue0 = 1;
Re_L = 10^7;
n = 101;

x = linspace(0,1,n);
theta = zeros(1,n);

i = 1;
while i <= n && laminar
    ue = ue0 + due_dx*x(i);
    
    theta(i) = sqrt((0.45/Re_L)*(ue^-6)*ueintbit(x(1),ue0,x(i),ue));
    
    Re_theta = Re_L * ue * theta(i);

    m = -Re_L* theta(i)^2 * due_dx;

    H = thwaites_lookup(m);

    He = laminar_He(H);
    
    if log(Re_theta) >= 18.4*He - 21.74
        laminar = false;
        disp([x(i) Re_theta/1000])
    end

    i = i + 1;
        
end


blas_theta = 0.664/sqrt(Re_L) * sqrt(x);

hold on
plot(x,theta)
plot(x,blas_theta)
legend('Thwaites Solution', 'Blasius Solution')
hold off