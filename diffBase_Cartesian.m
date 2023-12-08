function dudt = diff_base_polar(t, u)
%Basic newtonian two-body ODE with polar coordinate system
%The body orbits around the center of mass at (0, 0)
%The effective mass at the center of mass is M

%global parameters
global G M

%the variables of ODE
x = u(1);
vx = u(2);
y = u(3);
vy = u(4);

%diff.eq.
inv_r3 = (x*x + y*y)^(-1.5);
dudt = [
  vx; 
  -G*M*inv_r3 * x; 
  vy; 
  -G*M*inv_r3 * y
  ];
