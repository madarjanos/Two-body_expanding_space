%Example: Change of an orbit in the naive INCOMPLETE model
%Long time experiment, the mass break away

%global parameters for ODE
global G M H

%Demonstration the effect of naive expansion modell

%Initial (unperturbed) orbit configuration
%T: orbit time, a: orbit semi-major axis, e: eccentricity
T = 3.0;
a = 0.001;
e = 0.0;

%Hubble paramter (expansion ratio)
H = 0.01;

%time for ODE solver (now the time resolution is not important hence leave
%automatic)
tspan = [0 300];

%Calculate the (unperturbed) initial conditions for the orbit
[G, M, u0] = getInitialConditions_Polar(T, a, e);

%Solve ODE
opts = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,u]= ode113('diffExpansionNaive_Polar', tspan, u0, opts);

%Calculate coordinates
[x, y, r, theta, orbits] = getSolution_Polar(u);

%Plot the expansion of orbit radius vs. expansion from Hubble-law with
%constant H (expansion ratio) with logarthmic Y
r = r/a; %Normalizing the distance scale
t = t*H; %Normalizing the time scale
figure(1);
semilogy(t,r,'k-',t,exp(t),'b--',t,exp(2*t),'r:');
xlabel('time (in 1/H unit)');
ylabel('size (log scale)');
legend('orbit radius','e^{Ht}','e^{2Ht}');
%Plot the X-Y trajectory on second figure
figure(2);
plot(x,y);
ylim([-0.002 0.006]);
set(gca,'XTick',[], 'YTick', [])
xlabel('X');
ylabel('Y');
axis equal