function m=matrices(p)
%---------------------------------------------------------------------------------------------------------------------------
% This function saves vectors and matrices of the model in the structure "m" 
%---------------------------------------------------------------------------------------------------------------------------
m.a_grid=gridspecA(p,p.naa); % assets grid points (log-spaced)
m.z_grid=[0.1 1.0]; % idiosyncratic productivity grid points 
m.Pi=[0.9 0.1; 0.1 0.9]; % idiosyncratic productivity transition matrix
m.mu=stationarydistZ(p,m); % stationary distribution for labor
%---------------------------------------------------------------------------------------------------------------------------