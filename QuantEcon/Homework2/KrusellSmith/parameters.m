function p=parameters()
%---------------------------------------------------------------------------------------------------------------------------
% This function saves parameters of the model in the structure "p" 
%---------------------------------------------------------------------------------------------------------------------------
p.naa=100; % # of assets grid points
p.nKK=5; % # of aggregate capital grid points
p.a_min=0; % borrowing limit
p.a_max=30; % max level of assets
p.avalues_min=0;  % minimum grid value for the non-stochastic simulation
p.avalues_max=30; % maximum grid value for the non-stochastic simulation
p.nzz=2; % # of idiosyincratic productivity grid points
p.nZZ=2;% # of aggregate productivity grid points
p.sigma=1; % intertemporal elasticity of substitution
p.beta=0.96; % discount factor
p.alpha=0.33; % participation of capital
p.delta=0.05; % depreciation rate
p.r=0.03; % interest rate (initial)
p.w=1.3; % wage (initial)
p.N=1; % mass of households
load ss0.mat Ks;
p.a_ss=Ks; % assets steady state (from the stationary solution)
p.K_min=Ks*0.5; % low level for K
p.K_max=Ks*1.5; % max level for K
p.update_a=0.7; % updating parameter for the individual assets function
p.update_B=0.3; % updating parameter for the coefficients B in the ALM
%---------------------------------------------------------------------------------------------------------------------------
% Moreover, it also includes parameters to configurate the algorithm, displaying information, 
% and plotting some figures
%---------------------------------------------------------------------------------------------------------------------------
p.tol=1e-8; % tolerance criterion
p.intp=500; % # of asset grid points for interpolation
p.maxiter=1000; % maximum # iterations in the algorithms
p.ndiscard=100; % number of periods to discard
p.simulT=1000; % # of time periods for aggregate shocks simulation
p.algo=1; % algo=0, EGM iterates over the VF / algo=1, EGM iterates over the PF
p.disp1=1; % disp=1, displays the tolerance error and the time to execute the EGM
p.disp2=1; % disp=1, displays the tolerance error and the time to solve the model
p.fig=0; % fig=1, plots figures, 0 otherwise
%---------------------------------------------------------------------------------------------------------------------------