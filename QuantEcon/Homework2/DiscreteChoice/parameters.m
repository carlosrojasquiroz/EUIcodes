function p=parameters()
%---------------------------------------------------------------------------------------------------------------------------
% This function houses parameters of the model in the structure "p" 
% (you can call it as whatever you want, but be careful of being coherent in the whole code)
%---------------------------------------------------------------------------------------------------------------------------
p.naa=1000; % # of asset grid points
p.Amin=0; % borrowing limit
p.Amax=10; % max level of assets
p.sigma=1; % intertemporal elasticity of substitution
p.beta=0.96; % discount factor
p.alpha=0.33; % participation of capital
p.phi=0; % scalar factor of labor disutility (if phi=0, then standard incomplete markets)
p.r=0.03; % interest rate
p.w=1.0; % wage
p.evind=0; % if evind=1 (conditional on phi=1), then extreme value (EV) shocks
p.epsilon=0.01; % scale factor of the EV shock
%---------------------------------------------------------------------------------------------------------------------------
% Moreover, this script also includes parameters to configurate the algorithm,
% the display of information from the code, and plotting some figures
%---------------------------------------------------------------------------------------------------------------------------
p.tol=1e-6; % tolerance criterion
p.maxiter=500; % maximum # iterations in the algorithm
p.disp1=1; % disp1=1, displays the tolerance error and the time to execute the VFI
p.fig=1; % fig=1, plots figures, 0 otherwise
%---------------------------------------------------------------------------------------------------------------------------