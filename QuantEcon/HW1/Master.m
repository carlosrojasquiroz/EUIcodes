clc,close,clear;
%-------------------------------------------------------------------
%% Q1. Aiyagari
%-------------------------------------------------------------------
% Parameters
%-------------------------------------------------------------------
p.naa=1000; % Asset grid points
p.Amin=0; % Borrowing limit
p.Amax=50; % Maximum level of assets
p.Z=1; % Aggregate productivity
p.nzz=2; % Idiosyincratic productivity grid points
p.sigma=1; % Averse risk
p.beta=0.96; % Discount factor
p.alpha=0.33; % Participation of capital
p.delta=0.05; % Depreciation rate
p.r=0.03; % Interest rate 
p.w=1.3; % Wages
p.N=1; % Mass of households
p.tol=1e-6; % Tolerance criterion
p.intp=5000; % Asset grid points for interpolation
p.ntt=100; % length of transition path
p.maxiter=90; % maximum # iterations on transition path
p.weightr=0.1;% updating weight for r transition path 
%-------------------------------------------------------------------
% Grids
%-------------------------------------------------------------------
m.a_grid=linspace(p.Amin,p.Amax,p.naa); % Assets
m.z_grid=[0.1 1.0]; % Idiosyncratic productivity
m.Pi=[0.9 0.1; 0.1 0.9]; % Transition matrix
%-------------------------------------------------------------------
% Stationary distribution for z
%-------------------------------------------------------------------
m.mu=stationary_dist(p,m);
%-------------------------------------------------------------------
% Firms' decisions
%-------------------------------------------------------------------
[p.K,p.L]=firms(p,m);
%-------------------------------------------------------------------
% Value function iteration
%-------------------------------------------------------------------
[m.V0,m.g_a0,~,m.g_c0]=vfi(p,m);
m.EE0=eulererrors(m.g_a0,p,m);
%-------------------------------------------------------------------
% Endogenous grid method
%-------------------------------------------------------------------
[m.V1,a1,m.g_a1,m.g_c1]=egm(p,m);
m.EE1=eulererrors(m.g_a1,p,m);
%-------------------------------------------------------------------
% Solving the model (VFI=0, EGM=1)
%-------------------------------------------------------------------
vf=solve_aiyagari(p,m,0);
eg=solve_aiyagari(p,m,1);
%-------------------------------------------------------------------
%% Q2. Transition and MIT shocks
%-------------------------------------------------------------------
% Permanent productivity shock
%-------------------------------------------------------------------
m.Zt = p.Z*ones(1,p.ntt);
m.Zt(1) = p.Z;
m.Zt(2:end) = 0.9*p.Z; 
% Solve for the initial Steady State
p.Z=m.Zt(1);
ss0_p = solve_aiyagari(p,m,1);
fprintf('Initial steady state computed. \n\n')
% Solve for the final Steady State
p.Z=m.Zt(end);
ss1_p= solve_aiyagari(p,m,1);
fprintf('Final steady state computed. \n\n')
permZ=solve_trans(p,m,ss0_p,ss1_p);
%-------------------------------------------------------------------
% Transitory productivity shock
%-------------------------------------------------------------------
p.Z=1;
m.Zt = p.Z*ones(1,p.ntt);
m.Zt(1) = 0.9*p.Z;
% Solve for the initial Steady State
p.Z=m.Zt(1);
ss0_t = solve_aiyagari(p,m,1);
fprintf('Initial steady state computed. \n\n')
% Solve for the final Steady State
p.Z=m.Zt(end);
ss1_t = solve_aiyagari(p,m,1);
fprintf('Final steady state computed. \n\n')
transZ=solve_trans(p,m,ss0_t,ss1_t);
%-------------------------------------------------------------------
%% Q3. Sequence Space Jacobians
%-------------------------------------------------------------------
p.Z=1;
m.Zt=p.Z*ones(1,p.ntt);
m.Zt(1) = 0.9*p.Z;
% Solve for the initial Steady State
ss_J=solve_aiyagari(p,m,1);
fprintf('Initial steady state computed. \n\n')
trans_J=solve_trans(p,m,ss_J,ss_J);
% Compute the Jacobians
J=compute_Jac(p,m,ss_J);
% Solve transition with sequence space Jacobian
transSSJ=solve_transJ(p,m,ss_J,J);