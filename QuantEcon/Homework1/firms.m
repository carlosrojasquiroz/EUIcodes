function [K,L]=firms(p,m)
%-------------------------------------------------------------------
% Aggregate labor
%-------------------------------------------------------------------
L=m.z_grid*m.mu';
%-------------------------------------------------------------------
% Aggregate capital
%-------------------------------------------------------------------
K=(p.alpha*p.Z./(p.r + p.delta))^(1/(1-p.alpha))*L;