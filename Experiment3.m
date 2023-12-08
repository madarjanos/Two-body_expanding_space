%Calculation of orbital precession speed (complete expansion model)
%The result is compared with the approximation formula in the literature
%Also calculate the change of major axis and period time compared with
% the unperturbed (without expansion) orbit

%global parameters for ODE
global G M H

%Initial (unperturbed) orbit configuration
%T: orbit time, a: orbit semi-major axis, e: eccentricity
T = 1.0;
a = 0.001;
e = 0.1;

%Hubble paramter (expansion ratio)
H = 0.2;

%Time for ODE solver
% Note that we must use high time resolution for accurate precession 
% calculation. So the solving will take some CPU time.
tspan = [0 : 1E-4 : 50];

%Calculate the (unperturbed) initial conditions for the orbit
[G, M, u0] = getInitialConditions_Polar(T, a, e);

%Solve ODE
opts = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,u]= ode113('diffExpansion_Polar', tspan, u0, opts);

%Calculate coordinates
[x, y, r, theta, orbits] = getSolution_Polar(u);

%calculate some important orbital elements
[period, orbitsize, ecc, prec] = getOrbitalElements(t, r, theta, orbits);

%save
T0 = T; a0 = a;

%check precession speed
T = mean(period);
prec_speed = mean(prec(2, 2:end)) / T;
Lambda = 3*H*H;
omega = 2*pi/T;
e = mean(ecc);
prec_speed_eq = Lambda*sqrt(1-e^2)/(2*omega);
ratio = prec_speed / prec_speed_eq;
a = mean(orbitsize(:,4));
fprintf('H: %g (=Lambda: %g) T: %0.4g a: %0.4g e: %0.4g \n', H, Lambda, T, a, e);
fprintf('Precession speed: %0.4g vs. theoretical: %0.4g (ratio: %0.3g)\n', prec_speed, prec_speed_eq, ratio);
fprintf('Precession/orbit: %0.4g vs. theoreticals: %0.4g and ~ %0.4g\n', prec_speed*T, prec_speed_eq*T, pi*Lambda*a^3/(M*G)*sqrt(1-e^2));

%change of major axis and period time
da = (a - a0);
da_eq = 2*(H^2 / omega^2)*a0;
fprintf('Change of major axis: %g vs. equation for circle: %g\n', da, da_eq);
