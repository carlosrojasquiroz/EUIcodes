function p=parameters()
%---------------------------------------------------------------------------------------------------------------------------
% This function saves parameters of the model in the structure "p" 
%---------------------------------------------------------------------------------------------------------------------------
p.naa=200; % # of asset grid points
p.Amin=0; % borrowing limit
p.Amax=30; % max level of assets
p.Z=1; % aggregate productivity
p.nzz=2; % # of idiosyincratic productivity grid points
p.sigma=1; % intertemporal elasticity of substitution
p.beta=0.96; % discount factor
p.alpha=0.33; % participation of capital
p.delta=0.05; % depreciation rate
p.r=0.03; % interest rate (initial)
p.w=1.3; % wage (initial)
p.N=1; % mass of households
%---------------------------------------------------------------------------------------------------------------------------
% Moreover, it also includes parameters to configurate the algorithm, display of information, 
% and plotting some figures
%---------------------------------------------------------------------------------------------------------------------------
p.gridform=1; % gridform=0, linearly-spaced grid / gridform=1, log-spaced grid for assets
p.tol=1e-6; % tolerance criterion
p.intp=500; % # of asset grid points for interpolation
p.maxiter=1000; % maximum # iterations in the algorithms
p.algo=0; % algo=0, EGM iterates over the VF / algo=1, EGM iterates over the PF
p.disp1=1; % disp=1, displays the tolerance error and the time to execute the EGM
p.disp2=1; % disp=1, displays the tolerance error and the time to solve the model
p.fig=1; % fig=1, plots figures, 0 otherwise
%---------------------------------------------------------------------------------------------------------------------------