%Example: Change of an orbit in the naive INCOMPLETE model

%global parameters for ODE
global G M H

%Initial (unperturbed) orbit configuration
%T: orbit time, a: orbit semi-major axis, e: eccentricity
T = 1.0;
a = 0.001;
e = 0.5;

%Hubble paramter (expansion ratio)
H = 0.02;

%time for ODE solver
tspan = [0 : 1E-3 : 10];

%Calculate the (unperturbed) initial conditions for the orbit
[G, M, u0] = getInitialConditions_Polar(T, a, e);

%Solve ODE
opts = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,u]= ode113('diffExpansionNaive_Polar', tspan, u0, opts);

%Calculate coordinates
[x, y, r, theta, orbits] = getSolution_Polar(u);

%calculate some important orbital elements
[period, orbitsize, ecc, prec] = getOrbitalElements(t, r, theta, orbits);

%Plot the X-Y
plot(x,y,'-',[0],[0],'r.');
set(gca,'XTick',[], 'YTick', []);
xlabel('X');
ylabel('Y');
axis equal