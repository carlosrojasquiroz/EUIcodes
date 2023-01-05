function mu0=stationarydistZ(p,m)
%---------------------------------------------------------------------------------------------------------------------------
% This function obtains the stationary distribution of the idiosyncratic
% productivity shocks, z. It is used for computing the aggregate labor.
%---------------------------------------------------------------------------------------------------------------------------
mu0=(1./p.nzz)*ones(1,p.nzz);
err=1;
iter=0;
while err>p.tol && iter<p.maxiter                
    mu1=mu0*m.Pi;
    err=max(abs(mu1-mu0)); 
    mu0=mu1;
    iter=iter+1;
end
%---------------------------------------------------------------------------------------------------------------------------