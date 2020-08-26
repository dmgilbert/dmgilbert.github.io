function [tout,yout] = IRK4Solver(f,t,y0)
%Uses the implicit 4th order Runge-Kutta method to solve an ODE f with
%initial conditions y0 and fsolve internally to solve non-linear equations.

% Setting up variables
N = length(t);
h = t(2);
yout = zeros(3,N);
yout(:,1) = y0;
tout = t;

c1 = 1/2 - sqrt(3)/6;
c2 = 1/2 + sqrt(3)/6;
a11 = 1/4;
a12 = 1/4 - sqrt(3)/6;
a21 = 1/4 + sqrt(3)/6;
a22 = 1/4;
options = optimoptions('fsolve','Display','off','TolFun',3.1e-14,'Tolx',1e-16);

% Applying the Implicit Runge-Kutta method using fsolve for xi_1, xi_2.
for n = 1:N-1
   xi = fsolve(@test,[0.5 0.5;0.5 0.5; 0.5 0.5],options);
   yout(:,n+1) = yout(:,n) + h/2*(f(t(n)+h*c1,xi(:,1)) + f(t(n)+h*c2,xi(:,2)));
end
    function F = test(xi)
        F(:,1) = yout(:,n) + h*a11*f(t(n)+h*c1,xi(:,1)) + h*a12*f(t(n)+h*c2,xi(:,2)) - xi(:,1);
        F(:,2) = yout(:,n) + h*a21*f(t(n)+h*c1,xi(:,1)) + h*a22*f(t(n)+h*c2,xi(:,2)) - xi(:,2);
    end

end
