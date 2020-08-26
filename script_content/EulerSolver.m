function [tout,yout] = EulerSolver(f,t,y0)
%EulerSolver Uses the Euler method to find solutions to the right hand side
%of an ODE described by f(t,y)
N = length(t);
h = t(2);
yout = zeros(length(y0),N);
yout(:,1) = y0;

for n = 1:N-1
    yout(:,n+1) = yout(:,n) + h*f(t(n), yout(:,n));
end
tout = t';
end

