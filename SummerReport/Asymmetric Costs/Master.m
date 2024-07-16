clc,clear,close;
%---------------------------------------------------------------------------------------------------------------------------
% Empirical evidence
%---------------------------------------------------------------------------------------------------------------------------
d=empiricalevidence(0); % Figures deactivated
%---------------------------------------------------------------------------------------------------------------------------
% Calibration
%---------------------------------------------------------------------------------------------------------------------------
p.sigma=2.00; % Risk aversion
p.R=1.04; % Gross risk-free rate
p.theta=0.68; % NT share
p.eta=0.50; % Elasticity of substitution
p.alphaN=0.34; % Labor share in NT
p.alphaT=0.43; % Labor share in T
p.omegaN=1.455; % Wage elasticity for NT labor
p.omegaT=1.455; % Wage elasticity for T labor
p.beta=0.825; % Discount factor
p.lambda= 0.25; % Probability of reentry
%---------------------------------------------------------------------------------------------------------------------------
% VFI, simulation and estimation
%---------------------------------------------------------------------------------------------------------------------------
p.tol=1e-5; % Tolerance level 
p.Ntime=d.Nobs; % Sample length
p.Nhorz=d.Nhorz; % Event window
p.Events=d.Ndefaults; % Number of defaults from the data
p.burning=30; % Number of discarded simulations
p.lambdaHP=100; % HP smooth parameter
p.Get=100; % Number of simulations
%---------------------------------------------------------------------------------------------------------------------------
% Productivity
%---------------------------------------------------------------------------------------------------------------------------
p.Nz=21;
p.mu=d.Rho_TFP(2);
p.rho=d.Rho_TFP(1);
p.varsigma=d.Sigma_TFP;
[v.Z, v.Pz]=Tauchen(p.mu,p.rho,p.varsigma,p.Nz,3);
v.z=exp(v.Z');
%---------------------------------------------------------------------------------------------------------------------------
% Bonds
%---------------------------------------------------------------------------------------------------------------------------
p.Nb=151;
p.Bmin=-0.4;
p.Bmax=0;
v.b=linspace(p.Bmin,p.Bmax,p.Nb);
p.zero_ind=find(v.b>=0,1);
%---------------------------------------------------------------------------------------------------------------------------
% Grid search
%---------------------------------------------------------------------------------------------------------------------------
p.LowBoundT=0.005; % Lower bound
p.UpBoundT=0.1; % Upper bound
p.LowBoundN=0.005; % Lower bound
p.UpBoundN=0.1; % Upper bound
p.Steps=35; % Grid steps
%---------------------------------------------------------------------------------------------------------------------------
% Simulated Method of Moments
%---------------------------------------------------------------------------------------------------------------------------
p.moment=1;
% First step: grid search
smm=gridsearch(p,v,d);
% Second step: solver
[smm.chiTss0,smm.chiNss0,smm.Jss0]=solversearch(p,v,d,smm);
% Standard errors
smm.Qs=standarderrors(p,d,v,smm);
%---------------------------------------------------------------------------------------------------------------------------
% Indirect inference
%---------------------------------------------------------------------------------------------------------------------------
p.moment=0;
% First step: grid search
ii=gridsearch(p,v,d);
% Second step: solver
[ii.chiTss0,ii.chiNss0,ii.Jss0]=solversearch(p,v,d,ii);
% Standard errors
ii.Qs=standarderrors(p,d,v,ii);
%---------------------------------------------------------------------------------------------------------------------------
cd '/Users/carlosrojasquiroz/Desktop/SummerReport/SymmetricCosts'
%---------------------------------------------------------------------------------------------------------------------------
run Master.m
%---------------------------------------------------------------------------------------------------------------------------
cd '/Users/carlosrojasquiroz/Desktop/SummerReport/AsymmetricCosts'
%---------------------------------------------------------------------------------------------------------------------------
productivityloss(v,smm,smm0,'CF1_smm.eps','CF2_smm.eps')
productivityloss(v,ii,ii0,'CF1_ii.eps','CF2_ii.eps')
searchspaces(smm,ii,'SSsmm.eps','SSii.eps')
%---------------------------------------------------------------------------------------------------------------------------
p.moment=1;
smm_sim=targets(p,v,smm);
p.moment=0;
ii_sim=targets(p,v,ii);
%---------------------------------------------------------------------------------------------------------------------------
p.moment=1;
smm_sim0=targets(p,v,smm0);
p.moment=0;
ii_sim0=targets(p,v,ii0);
%---------------------------------------------------------------------------------------------------------------------------
momentsdistribution(d,smm_sim,ii_sim,'SMM_01.eps','SMM_02.eps','II_01.eps','II_02.eps')
%---------------------------------------------------------------------------------------------------------------------------
[smm.W,smm.pvalue]=hypothesistesting(p,smm,smm0);
[ii.W,ii.pvalue]=hypothesistesting(p,ii,ii0);
