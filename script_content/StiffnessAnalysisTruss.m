%% Stiffness analysis of Trusses
% This script allows you to find the global stiffness matrix K for a truss,
% given the location vectors, degrees of freedom and member properties.

%% Enter in member properties and angles.
% Note that the first element of the list corresponds to the first member

theta = [pi/3,0,2*pi/3,0,pi/3,0,2*pi/3,0,pi/3,0,2*pi/3]; % angle in rads
L = [0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3]*1000; % length in m
E = [2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5]; % E in GPa  
A = [250,250,250,250,250,250,250,250,250,250,250]; % A in mm^2
P = [0,0,0,0,0,0,0,-0.3,0,0,0]; % P in kN
DOF = 11; % integer number of degrees of freedom

% Enter in location vectors as a matrix, each row for each member.
LVmatrix = [0 0 1 2;0 0 3 4;3 4 1 2;1 2 5 6;3 4 5 6;3 4 7 8;7 8 5 6;
            5 6 9 10;7 8 9 10;7 8 11 0;11 0 9 10];

%% Calls functions to create global k for each member and find K.
kMatrix = kMemberMatrix(theta, L, E, A);
K = constructK(kMatrix, LVmatrix, DOF)
U = K \ P';
axialForces = findAxial(kMatrix,LVmatrix,U)

%% Function library
function k = kMemberMatrix(theta, L, E, A)
% Creates global k matricies for n members in a single 4*4n matrix, done to
% increase efficiency and reduce uneccessary looping in later functions.

k = zeros(4,4*length(theta));
lx = cos(theta);
ly = sin(theta);
for i = 1:length(theta)
    coeff = E(i)*A(i)/L(i);
    k(1:4,4*i-3:4*i) = coeff*[lx(i)^2 lx(i)*ly(i) -lx(i)^2 -lx(i)*ly(i);
                              lx(i)*ly(i) ly(i)^2 -lx(i)*ly(i) -ly(i)^2; 
                              -lx(i)^2 -lx(i)*ly(i) lx(i)^2 lx(i)*ly(i); 
                              -lx(i)*ly(i) -ly(i)^2 lx(i)*ly(i) ly(i)^2];
end
end

function K = constructK(kMatrix, LVmatrix, DOF)
% Uses the matrix of location vectors for each members and the matrix of
% each member's k matrix appended together, along with the DOF. The
% function then goes through each k matrix, uses the location vector to
% find which entries in k are required, and adds them to their
% corresponding entries in K.

K = zeros(DOF);
for m = 1:length(kMatrix)/4
    k = kMatrix(1:4,4*(m-1)+1:4*m);
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

function pMemberVector = findAxial(kMatrix,LVmatrix,U)
% Uses previously calculated k for each member, LV and U to find the axial
% forces in each member.

pMemberVector = zeros(1,length(U));
for m = 1:length(kMatrix)/4
    k = kMatrix(1:4,4*(m-1)+1:4*m);
    LV = LVmatrix(m,:);
    uMember = zeros(1,4); 
    for n = 1:length(LV)
        if LV(n) ~= 0
          uMember(n) = U(LV(n));
        end
    end
    p = k*uMember';
    if sign(p(4)) ~= 0
        pMemberVector(m) = sign(p(4))*1000*sqrt(p(1)^2 + p(2)^2);
    else
        pMemberVector(m) = sign(p(3))*1000*sqrt(p(1)^2 + p(2)^2);
    end
end    
end