function mu=stationary_dist(p,m)
mu=(1./p.nzz)*ones(1,p.nzz);
err=1;
while err>p.tol                
    mu_Aux=mu*m.Pi;
    err=max(abs(mu_Aux-mu)); 
    mu=mu_Aux; 
end