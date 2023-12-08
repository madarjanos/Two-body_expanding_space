function dudt = diffExpansion_Cartesian(t, u)
%Newtonian two-body ODE with correct expansion model - certasian coordinate system
%The body orbits around the center of mass at (0, 0)
%The effective mass at the center of mass is M
%Expansion rate of space is H (=sqrt(Lambda/3) if only dark energy)

%global parameters
global G M H

%ODE variables
x = u(1);
vx = u(2);
y = u(3);
vy = u(4);

%diff.eq.
inv_r3 = (x*x + y*y)^(-1.5);
dudt = [
    vx + H*x; 
    -G*M*inv_r3 * x - H*vx;
    vy + H*y; 
    -G*M*inv_r3 * y - H*vy;
    ];
