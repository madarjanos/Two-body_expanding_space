function [x, y, r, theta, orbits] = getSolution_Polar(u)
% Transform the solution from polar ODE
% Input: 
%   u: result matrix of the ODE solver
% Outputs: 
%   x, y: cartesian coordinates
%   r, theta: polar coordinates
%   orbits: orbiting (circulation) counter (start with zero and increase)
% It is assumed that the starting polar coordinate theta(0)=0
% Note: the theta is monotonically increasing

%radius and angel
r = u(:,1);
theta = u(:,3);
%calculate x and y
x = r .* cos(theta);
y = r .* sin(theta);
%calculate orbits (with 5 digit rounding at the very end to avoid such 
% cases when e.g. after exactly one orbit the orbit(end)=0.99999999)
orbits = theta / (2*pi);
orbits(end) = round(orbits(end)*1E5)*1E-5;

