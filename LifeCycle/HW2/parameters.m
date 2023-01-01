function p=parameters()
%---------------------------------------------------------------------------------------------------------------------------
% This function collects parameters of the model in the structure "p" 
%---------------------------------------------------------------------------------------------------------------------------
p.moments=4; % total number of moments 
p.comb=nchoosek(1:p.moments,2); % combinations
[p.R,~]=size(p.comb); % total number of moments combinations
p.tol=1e-8; % tolerance criterion
p.maxiter=1000; % maximum number of iterations
p.Pmin=1e-4; % minimum value of P
p.Pmax=4; % maximum value of P
p.lambdamin=1e-4; % minimum value of lambda
p.lambdamax=0.2; % maximum value of lambda
p.nn=2500; % number of grid points
%---------------------------------------------------------------------------------------------------------------------------