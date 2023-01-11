function mu=stationarydist(p,Pi,intp)
%---------------------------------------------------------------------------------------------------------------------------
% This function makes the stochastic simulation a la Young to obtain the
% stationary distribution of assets
%---------------------------------------------------------------------------------------------------------------------------
mu0=(1/(p.nzz*intp))*ones(1,p.nzz*intp); 
err=1;
iter=0;
while err> p.tol && iter<p.maxiter                
   mu1=mu0*Pi;
   err=max(abs(mu1-mu0));
   mu0=mu1;
   iter=iter+1;
end
mu=reshape(mu0,p.nzz,intp);
mu=mu';
%---------------------------------------------------------------------------------------------------------------------------