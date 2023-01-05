function m=matrices(p)
%---------------------------------------------------------------------------------------------------------------------------
% This function houses vectors and matrices of the model in the structure "m" 
% (you can call it whatever you want, but be careful of being coherent in the whole code)
%---------------------------------------------------------------------------------------------------------------------------
m.a_grid=gridspec(p.Amin,p.Amax,p.naa,1); % assets grid points (log-spaced=1)
m.z_grid=1; % idiosyncratic productivity grid points
%---------------------------------------------------------------------------------------------------------------------------