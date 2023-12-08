%global parameters for ODE
global G M

%Initial (unperturbed) orbit configuration
%T: orbit time, a: orbit semi-major axis, e: eccentricity
T = 1.0;
a = 0.001;
e = 0.5;

%time for ODE solver (100 orbits)
tspan = [0 : 1E-3 : 100];

%Calculate the initial conditions for that orbit
[G, M, u0] = getInitialConditions_Polar(T, a, e);

%Solve ODE
tic
opts = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,u]= ode113('diffBase_Polar', tspan, u0, opts);
toc

%Calculate coordinates and orbits
[x, y, r, theta, orbits] = getSolution_Polar(u);

%calculate and write some important orbital elements
[period, orbitsize, ecc, prec] = getOrbitalElements(t, r, theta, orbits);

%Plot the X-Y
plot(x,y,'-',[0],[0],'r.');
xlabel('X');
ylabel('Y');
axis equal