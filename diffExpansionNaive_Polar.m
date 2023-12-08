function dudt = diffExpansionNaive_Polar(t, u)
%Newtonian two-body ODE with naive expansion model - polar coordinate system
%The body orbits around the center of mass at (0, 0)
%The effective mass at the center of mass is M
%Expansion rate of space is H (=sqrt(Lambda/3) if only dark energy)

%global parameters
global G M H

%ODE variables
r = u(1);
vr = u(2);
theta = u(3);
omega = u(4);

%diff.eq.
dudt = [
    vr + H*r; 
    -G*M/(r*r) + r*omega*omega; 
    omega; 
    -2*vr*omega/r - H*omega
    ];
