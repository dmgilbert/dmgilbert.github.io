clear
clc

%% Stiffness analysis of FRAMES

% This script allows you to find the global stiffness matrix K for a FRAME,
% given the blah, blah and blah.


%% Enter in member properties and angles

% Note that the first element of the list corresponds to the property of
% the first member and so on. Repeat E, A or I if constant for all members.

theta = [ 0, -pi/2 ];
L = [ 6.2, 6.2 ];
E = [ 200000000, 200000000 ];
A = [ 0.005, 0.005 ];
I = [ 1.5e-4, 1.5e-4 ] ;
P = [-96.1,99.303, 0];
DOF = 3 ;


% Enter in location vectors as a matrix, with the first row corresponding
% to the first location vector and so on.

LVmatrix = [0 0 0 3 1 2; 3 1 2 0 0 0];




%% Calls functions to create global k for each member and find K.

kMatrix = vectorMemberk(theta, L, E, A, I);
K = constructK(kMatrix, LVmatrix, DOF) ;


% optional: finds the global deflection vector (remove % below to run).
U = K \ P' ;
%vpa(U) ;

% optional: finds the global stiffness matrix k for a single member, change
% i to member number you want k for (remove % below to run).
 %kMember = singleMemberk(theta(1), L(1), E(1), A(1), I(1)) 
 %vpa(kMember) ;
 %K




%% Functions that are used


function k = vectorMemberk(theta, L, E, A, I)
k = zeros(6,6*length(theta));
lx = cos(theta);
ly = sin(theta);
for i = 1:length(theta)
    k(1:6, 6*(i-1)+1:6*i) = [E(i)*A(i)*lx(i)^2/L(i)+12*E(i)*I(i)*ly(i)^2/L(i)^3 (E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) -6*E(i)*I(i)*ly(i)/L(i)^2 -E(i)*A(i)*lx(i)^2/L(i)+12*E(i)*I(i)*ly(i)^2/L(i)^3 -(E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) -6*E(i)*I(i)*ly(i)/L(i)^2;
    (E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) E(i)*A(i)*ly(i)^2/L(i)+12*E(i)*I(i)*lx(i)^2/L(i)^3 6*E(i)*I(i)*lx(i)/L(i)^2 -(E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) -E(i)*A(i)*ly(i)^2/L(i)-12*E(i)*I(i)*lx(i)^2/L(i)^3 6*E(i)*I(i)*lx(i)/L(i)^2;
    -6*E(i)*I(i)*ly(i)/L(i)^2 6*E(i)*I(i)*lx(i)/L(i)^2 4*E(i)*I(i)/L(i) 6*E(i)*I(i)*ly(i)/L(i)^2 -6*E(i)*I(i)*lx(i)/L(i)^2 2*E(i)*I(i)/L(i);
    -E(i)*A(i)*lx(i)^2/L(i)-12*E(i)*I(i)*ly(i)^2/L(i)^3 -(E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) 6*E(i)*I(i)*ly(i)/L(i)^2 E(i)*A(i)*lx(i)^2/L(i)+12*E(i)*I(i)*ly(i)^2/L(i)^3 (E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) 6*E(i)*I(i)*ly(i)/L(i)^2;
    -(E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) -E(i)*A(i)*ly(i)^2/L(i)-12*E(i)*I(i)*lx(i)^2/L(i)^3 -6*E(i)*I(i)*lx(i)/L(i)^2 -(E(i)*A(i)/L(i)-12*E(i)*I(i)/L(i)^3)*lx(i)*ly(i) E(i)*A(i)*ly(i)^2/L(i)+12*E(i)*I(i)*lx(i)^2/L(i)^3 -6*E(i)*I(i)*lx(i)/L(i)^2;
    -6*E(i)*I(i)*ly(i)/L(i)^2 6*E(i)*I(i)*lx(i)/L(i)^2 2*E(i)*I(i)/L(i) 6*E(i)*I(i)*ly(i)/L(i)^2 -6*E(i)*I(i)*lx(i)/L(i)^2 4*E(i)*I(i)/L(i)];
end
end


function K = constructK(kMatrixList, LVmatrix, DOF)
K = zeros(DOF);
for m = 1:length(kMatrixList)/6
    k = kMatrixList(1:6,6*(m-1)+1:6*m);
    LV = LVmatrix(m,:);
    v = zeros(1,DOF);
    
    for n = 1:length(LV)
        if LV(n) ~= 0
          v(LV(n)) = n;
        end
    end
    
    for i = 1:DOF
       for j = 1:DOF
          if v(i) && v(j) ~= 0
              K(i,j) = K(i,j) + k(v(i),v(j));
          end
       end
    end
end
end


function k = singleMemberk(theta, L, E, A, I)
lx = cos(theta);
ly = sin(theta);
k = [ E*A/L 0 0 -E*A/L 0 0 ; 0 12*E*I/(L^3) 6*E*I/(L^2) 0 -12*E*I/(L^3) 6*E*I/(L^2) ; 0 6*E*I/(L^2) 4*E*I/L 0 -6*E*I/(L^2) 2*E*I/L ;
    -E*A/L 0 0 E*A/L 0 0 ; 0 -12*E*I/(L^3) -6*E*I/(L^2) 0 12*E*I/(L^3) -6*E*I/(L^2) ; 0 6*E*I/(L^2) 2*E*I/L 0 -6*E*I/(L^2) 4*E*I/L ] ;
end