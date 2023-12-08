function dudt = diffBase_Polar(t, u)
%Basic newtonian two-body ODE with polar coordinate system
%The body orbits around the center of mass at (0, 0)
%The effective mass at the center of mass is M

%global parameters
global G M

%ODE variables
r = u(1);
vr = u(2);
theta = u(3);
omega = u(4);

%diff.eq.
dudt = [
    vr; 
    -G*M/(r*r) + r*omega*omega; 
    omega; 
    -2*vr*omega/r
    ];
