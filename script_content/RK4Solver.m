function [tout,yout] = RK4Solver(f,t,y0)
%Uses the classical 4th order Runge-Kutta method to solve an ODE f with
%initial conditions y0
N = length(t);
h = t(2);
yout = zeros(length(y0),N);
yout(:,1) = y0;
tout = t;

for n = 1:N-1
   xi_1 = f(t(n),yout(:,n));
   xi_2 = f(t(n)+0.5*h,yout(:,n)+0.5*h*xi_1);
   xi_3 = f(t(n)+0.5*h,yout(:,n)+0.5*h*xi_2);
   xi_4 = f(t(n)+h,yout(:,n)+h*xi_3);
   
   yout(:,n+1) = yout(:,n)+(h/6)*(xi_1+2*xi_2+2*xi_3+xi_4);
end
end

