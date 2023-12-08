function [period, orbitsize, ecc, prec] = getOrbitalElements(t, r, theta, orbits)
%Calculate some values of the orbits (which are totally finished)
%They are:
% period: period time
% orbitsize: [r_min, r_max, semi-minor axis, semi-major axis] lengths
% ecc: eccentricity
% prec: [prec_angel, delta_prec_angel]
% The delta_prec_angel(i) = prec_angel(i)-prec_angel(i-1), hence
%  the first element of delte_prec_angel is zero (do not use it!)
% Note that it uses the semimajor axis for precession calculation
%  becasue it is numerically more robust 


%First calculate the number of finished orbits
N = floor(orbits(end));

%starting and finishing indeces for orbits
ixs = zeros(N, 2);
ix = 1;
for i = 1:N
    ixs(i,1) = ix;
    ix = find(orbits >= i, 1);
    ixs(i,2) = ix-1; 
end
ixs(N,2) = min(ixs(N,2)+1, length(orbits)-1);

%calculate the orbital elements for each period
period = zeros(N, 1);
rmin = zeros(N, 1);
rmax = zeros(N, 1);
smajoraxis = zeros(N, 1);
sminoraxis = zeros(N, 1);
ecc = zeros(N, 1);
prec_angel = zeros(N, 1);
delta_prec_angel = zeros(N, 1);;
for i = 1:N
    %orbital period
    period(i) = t(ixs(i,2)+1) - t(ixs(i,1));
    %rmin, rmax
    [rm1, ix1] = max(r(ixs(i,1):ixs(i,2)));
    rmax(i) = rm1;    
    [rm2, ix2] = min(r(ixs(i,1):ixs(i,2)));
    rmin(i) = rm2;
    %prec angel
    ix = ix1 + ixs(i,1)-1;
    angel = theta(ix) - floor(theta(ix)/(2*pi))*2*pi;
    prec_angel(i) = angel;
    %prec angel change -> back to prev. index
    if i > 1
        dpa = prec_angel(i) - prec_angel(i-1);
        if dpa > +pi
            dpa = dpa - 2*pi;
        end
        if dpa < -pi
            dpa = dpa + 2*pi;
        end
        delta_prec_angel(i) = dpa;
    end
    %semi-minor axis, semi-major axis size
    smajoraxis(i) = (rmax(i)+rmin(i))/2.0;
    sminoraxis(i) = sqrt(rmax(i)*rmin(i));
    %eccentricity
    ecc(i) = sqrt(1.0 - sminoraxis(i)^2 / smajoraxis(i)^2);
end
orbitsize = [rmin, rmax, sminoraxis, smajoraxis];
prec = [prec_angel, delta_prec_angel];
