The files in capital letters are the various scripts. They need to be run.
--------------------------------------------------------------------------

Example1 and Example2 are two examples of solving the ordinary two-body problem with numerical integration (ODE). They are also used to test the ODE solver and its settings. The tolerance should be chosen small enough to ensure that all the trajectories on the X-Y graph are exactly the same after many orbits.

Experiment1A/B/C performs some experiments on the naive expansion model and generates some plots.

Experiment2A/B/C performs a few experiments on the exact expansion model and generates a few plots.

Experiment3 checks how the precession velocity depends on different parameters (period time, orbit size, expansion rate, eccentricity).

Animation is just an auxiliary script. You can use it after running an experiment. It will generate a nice animation from the t, x, y vectors. The "m=50" shall be changed if the ODE solver time interval <> 0.001 (e.g. "tspan = (0:0.001:10)" has 0.001 time interval).

Lower case filenames are the functions
--------------------------------------
*_Certesian -> functions written in the Descartes coordinate system.
*_Polar -> functions written in the polar coordinate system.

diffBase_* -> the differential equations of the basic two-body problem.
diffExpansionNaive_* -> naive ("incomplete") expansion model, where expansion only increases distances.
diffExpansion_* -> the exact expansion model, which takes into account the decrease in the peculiar velocity.

The other functions are various auxiliary functions:

getInitialConditions_* specifies the initial conditions for solving diff.equation. This computes the central mass and initial velocity (angular velocity) for the basic two-body problem, which yields an orbit with a given period time, semi-major axis and eccentricity.

getSolution_* converts the solution of the diff. equation written in one coordinate system to the other coordinate system, and also computes an auxiliary vector to count the orbit.

getOrbitalElements calculates from the solution the usual orbital parameters for all fully completed orbits: minimum and maximum distance from the (0,0) focal point, half-major-axis and half-minor-axis lengths, eccentricity, and the angle of the precession axis and its variation (how much it rotates with the given orbit).

Comments
--------
1. The basic ode45 is good for these diff. equations, because they are all "easy" (non-stiff) equations. But for the sake of higher speed, I chose ode113. But it doesn't really matter which ODE solver you use, you just have to make sure that the tolerance of the solution is tight enough and the time interval is dense enough, because e.g. the accuracy of the precession calculation depends very much on the (temporal) resolution of the resulting solution. 

2. Either Descartes' or polar coordinate equations can be used to taste. The basic one is the polar system description, which I suggest to use, in principle it is more ideal for ODE, although I could not find any analysis on this.  I did the Descartes prescription to check that the equations written in polar coordinate system are really correct. Indeed, the Descartes prescription follows directly from the vector prescription, whereas the polar-system equations have to be worked out that way.

3. I calculate the precession not in terms of periapsis (the location of the smallest distance from the focal point), but in terms of apoapsis (the location of the largest distance from the focal point). Theoretically, it doesn't matter because the apse line connects exactly these two points, and the precession for a two-body problem is only the rotation of this apse line in the X-Y plane. I use the apoapse because it is numerically more stable and accurate, since the trajectory is computed as an integral in time, and thus has a higher spatial resolution in the slow section of the trajectory than in the fast section of the trajectory.

4. The models are dimensionless (G = 1, c = 1), so that the period of the circulation is T = 1 unit of time (of course, you could choose anything else). Since these are quasi-Newtonian models, there is no constraint on the velocity, it can be as large as you like, but it is worth choosing it so that it is not too large (which could mean >= the speed of light), because my experience is that then the model and the calculated precession velocity will be inaccurate. In fact, if c=1 is chosen as the dimensionlessness, then for T = 1 time unit it would be a < 1E-4 for Solar System. But if a < T*0.1, then the model can be used. It is also not worth choosing a very small one, because in principle it can reduce the accuracy of the calculation (although not very much). The precession velocity is not affected by the size of the major axis, as can be seen from the formula. The suggested half-major axis is therefore about a 1E-4 - 1E-3. This is still well within Newtonian dynamics, and the accuracy is reasonable, but as I wrote it doesn't matter much, just small relative to T to make the dimensionless model physically realistic.
