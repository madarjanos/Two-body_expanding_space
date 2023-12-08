function [x, y, r, theta, orbits] = getSolution_Polar(u)
% Transform the solution from cartesian ODE
% Input: 
%   u: result matrix of the ODE solver
% Outputs: 
%   x, y: cartesian coordinates
%   r, theta: polar coordinates
%   orbits: orbiting (circulation) counter (start with zero and increase)
% It is assumed that the starting polar coordinate theta(0)=0
% Note: the theta is monotonically increasing

%X and Y
x = u(:,1);
y = u(:,3);
%calculate radius and angel
r = sqrt(x.*x + y.*y);
theta = atan2(y,x);
%convert theta to monotonically increasing
dtheta = theta(2:end)- theta(1:end-1);
ixs = find(dtheta < -0.00001);
n = 1;
for i = 1:length(ixs)
    ix1 = ixs(i) + 1;
    if i == length(ixs)
        ix2 = length(theta);
    else
        ix2 = ixs(i+1);
    end
    theta(ix1:ix2) = theta(ix1:ix2) + 2*pi*n;
    n = n+1;
end
%calculate orbits (with 5 digit rounding at the very end to avoid such 
% cases when e.g. after exactly one orbit the orbit(end)=0.99999999)
orbits = theta / (2*pi);
orbits(end) = round(orbits(end)*1E5)*1E-5;

