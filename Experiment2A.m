%Complete expansion model using the "v1" ODE
%Change of orbit with high eccentricity and very high Hubble paramter.
%Illustrates the orbital precession.

%global parameters for ODE
global G M H

%Initial (unperturbed) orbit configuration
%T: orbit time, a: orbit semi-major axis, e: eccentricity
T = 1.0;
a = 0.001;
e = 0.5;

%Hubble paramter (expansion ratio)
H = 0.726;

%time for ODE solver
tspan = [0 : 1E-4 : 5];

%Calculate the (unperturbed) initial conditions for the orbit
[G, M, u0] = getInitialConditions_Polar(T, a, e);

%Solve ODE
opts = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,u]= ode113('diffExpansion_Polar', tspan, u0, opts);

%Calculate coordinates
[x, y, r, theta, orbits] = getSolution_Polar(u);

%calculate Angular momentum from polar solution
omega = u(:,4);
vtan = r .* omega;
N = r .* vtan;

%calculate total energy from polar solution
vr = u(:,2);
Ekin = 1/2*(vtan .* vtan + vr .* vr);
Epot = -G*M ./ r;
Etot = Ekin+Epot;

%Plots
figure(1);
plot(t,Etot);
xlabel('Time (orbits)');
ylabel('Total energy');

figure(2);
plot(t,N);
xlabel('Time (orbits)');
ylabel('Angular momentum');
ylim([N(1)*0.99 N(1)*1.01]);

figure(3);
plot(x,y,'k-',[0],[0],'r.');
set(gca,'XTick',[], 'YTick', []);
xlabel('X');
ylabel('Y');
axis equal

