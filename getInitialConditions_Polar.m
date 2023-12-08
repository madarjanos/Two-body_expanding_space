function [G, M, y0] = getInitialConditions_Polar(T, a, e)
% Generate initial conditions and parameters
% There are five parameters for elliptical orbit from which one is not independent: 
%   G: Newton Gravitional Constant
%   M: Mass at the center (effective mass at the center-of-mass of the gravitional bound system)
%   T: Orbital period
%   a: Semi-major axis (= radius in case of circle orbit)
%   e: excentricity of the ellipse (=0 in case of circle orbit)
% The inputs are T and a and e, and it calculates the G*M from it.
% The outputs:
%   G: as above
%   M: as above
%   y0: 4 element vector as initial conditions. It can be:
%     [r; v_r; theta; omega] for polar diff.equations
%     [x; v_x; y; v_y] for cartesian diff.equations
% Note that the starting position is always theta=0 (x > 0, y = 0), 
% and the circulation direction is positive.
% In case of ellipse (b < a), the starting condition is the perihelion (r_min from the center)

%dimensionless Newton's gravity constant
G = 1.0;
%Kepler's third law:
M = a^3 / (T/(2*pi))^2 / G;
%perihelion distance:
rmin = a*(1.0-e);
%because we start at the perhelion, the dr/dt=0
v_r = 0.0;
%tangential speed from speed equation of ellipse
v_tan = sqrt(G*M*(2/rmin - 1/a));  
%convert tangetial speed to angular speed
omega = v_tan / rmin;
%the starting angel is zero
theta = 0.0;
%result
y0 = [rmin; v_r; theta; omega];

