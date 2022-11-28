function [x, P] = Tauchen(mu,rho,sigma,N,m)
    P = zeros(N,N);
    x_min = mu/(1-rho) - m*sqrt(sigma^2/(1-rho^2)); 
    x_max = mu/(1-rho) + m*sqrt(sigma^2/(1-rho^2));
    x = linspace(x_min,x_max,N)';
    dx = (x_max- x_min )/(N-1);
    for x_i = 1:N
        for zp_i = 2:N-1 
            P(x_i,zp_i) =   normcdf(  (x(zp_i) - mu - rho*x(x_i) + dx/2) / sigma)   ...
                           - normcdf(  (x(zp_i) - mu - rho*x(x_i) - dx/2) / sigma);
        end
        P(x_i,1) =      normcdf(  (x(1) - mu - rho*x(x_i) + dx/2) / sigma);
        P(x_i,N) = 1 -  normcdf(  (x(N) - mu - rho*x(x_i) - dx/2) / sigma);
    end
end