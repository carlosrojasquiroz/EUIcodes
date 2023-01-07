function m=matrices(p)
%---------------------------------------------------------------------------------------------------------------------------
% This function saves vectors and matrices of the model in the structure "m" 
%---------------------------------------------------------------------------------------------------------------------------
m.a_grid=gridspec(p.a_min,p.a_max,p.naa,1); % assets grid points (log-spaced)
m.z_grid=[0.1 1.0]; % idiosyncratic productivity grid points 
m.Pz=[0.9 0.1; 0.1 0.9]; % idiosyncratic productivity transition matrix
m.mu=stationarydist(p,p.nzz,m.Pz,1)'; % stationary distribution of idiosyncratic shocks
m.Z_grid=[0.99 1.01]; % aggregate productivity grid points 
m.PZ=[0.5 0.5; 0.1 0.9]; % aggregate productivity transition matrix
m.mU=stationarydist(p,p.nZZ,m.PZ,1)'; % stationary distribution of aggregate shocks
m.P=kron(m.PZ,m.Pz);  % matrix of transition probabilities
m.K_grid=gridspec(p.K_min,p.K_max,p.nKK,0); % aggregate capital grid points (linearly-spaced)
[m.Zsim,m.Zshock]=simulshocks(p,m); % p.simulT # of simulated aggregate shocks
m.B=[log(p.a_ss) 0 log(p.a_ss) 0]; % Initial vector of coefficients B of the ALM
m.L=(m.z_grid*m.mu');  % aggregate labor
%---------------------------------------------------------------------------------------------------------------------------
%% Initial assets function (a'=g_a)
%---------------------------------------------------------------------------------------------------------------------------
m.g_a=zeros(p.nzz,p.naa,p.nZZ,p.nKK);
for d_1=1:p.nzz
   for d_3=1:p.nZZ
      for d_4=1:p.nKK
         m.g_a(d_1,:,d_3,d_4)=0.9*m.a_grid;
      end
   end
end
%---------------------------------------------------------------------------------------------------------------------------
%% Initial density function for each idiosyncratic shock, defined in p.intp grid points 
%---------------------------------------------------------------------------------------------------------------------------
m.a_cross=zeros(p.nzz,p.intp); 
m.a_cross(1:p.nzz,round(p.a_ss/((p.avalues_max-p.avalues_min)/p.intp)))=1; 
%---------------------------------------------------------------------------------------------------------------------------