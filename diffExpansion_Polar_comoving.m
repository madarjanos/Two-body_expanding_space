function dudt = diffExpansion_Polar_comoving(t, u)
%Newtonian two-body ODE with expansion - polar coordinate system
%Here the r and vr are comoving coordinates!
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
    vr;
    -G*M/(r*r)*exp(-3*H*t) + r*omega*omega - 2*H*vr;
    omega;
    -2*vr*omega/r - 2*H*omega;
    ];
