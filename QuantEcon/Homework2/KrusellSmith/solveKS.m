function s=solveKS(p,m)
%--------------------------------------------------------------------------------------------------------------------------
% This function solves the Aiyagari model with aggregate shocks. Solutions
% are saved in the structure "s".
%--------------------------------------------------------------------------------------------------------------------------
%% Initial objects
%-------------------------------------------------------------------------------------------------------------------------- 
dif_B=1; % initial value for the difference between estimates
iter=0; % initial iteration
p.disp1=0; % no display information from the endogenous grid method
B=m.B; % initial value of betas
g_a=m.g_a; % initial policy of individual assets
load ss0.mat dist;  % results from Aiyagari without aggregate shocks
a_cross=dist; % initial distribution of individual assets
%--------------------------------------------------------------------------------------------------------------------------    
%% Algorithm
%--------------------------------------------------------------------------------------------------------------------------
if p.disp2==1
    disp('I start to solve the Aiyagari model with aggregate shocks...')
end
tic;
while dif_B>p.tol
    iter=iter+1;
    if p.disp2==1
        disp('------------------------------------------------------------------------------')
        disp(['Iteration number ',num2str(iter)])
        disp('------------------------------------------------------------------------------')
    end
%--------------------------------------------------------------------------------------------------------------------------    
% Computing a solution to the individual problem
%--------------------------------------------------------------------------------------------------------------------------
    if p.disp2==1
        disp('---> Solving the individual problem...')
    end
    [g_a,~]=egm_i(p,m,B,g_a);
%--------------------------------------------------------------------------------------------------------------------------    
% Non-stochastic simulation
%--------------------------------------------------------------------------------------------------------------------------
    if p.disp2==1
        disp('----> Computing the non-stochastic simulation...')
    end
    [K_ts,a_cross_temp]=aggns(p,m,g_a,a_cross);
%--------------------------------------------------------------------------------------------------------------------------
% Time series for the ALM regression
%--------------------------------------------------------------------------------------------------------------------------
    i_l=0;   i_h=0;
    x_l=0;  y_l=0;
    x_h=0; y_h=0;
    for ii=1:p.simulT-1
       if m.Zshock(ii)==1
          i_l=i_l+1;
          x_l(i_l,1)=log(K_ts(ii));
          y_l(i_l,1)=log(K_ts(ii+1));
       else
          i_h=i_h+1;
          x_h(i_h,1)=log(K_ts(ii));
          y_h(i_h,1)=log(K_ts(ii+1));
       end
    end
%--------------------------------------------------------------------------------------------------------------------------
% OLS regression ln(km')=B(1)+B(2)*ln(km)
%--------------------------------------------------------------------------------------------------------------------------    
    [Bx(1:2),~,~,~,stats]=regress(y_l,[ones(i_l,1) x_l]);
    R2l=stats(1); 
    [Bx(3:4),~,~,~,stats]=regress(y_h,[ones(i_h,1) x_h]);
    R2h=stats(1);
%--------------------------------------------------------------------------------------------------------------------------
% Difference between the initial and obtained vector of coefficients
%--------------------------------------------------------------------------------------------------------------------------
    dif_B=norm(B-Bx);
% To ensure that initial capital distribution comes from the ergodic set, we use the terminal 
% distribution of the current iteration as initial distribution for a subsequent iteration. 
% When the solution is sufficiently accurate, dif_B<p.tol, we stop such an updating 
% and hold the distribution "a_cross_temp" fixed for the rest of iterations. ·
    %if dif_B>p.tol*100
        a_cross=a_cross_temp;
    %end
    B=Bx*p.update_B+B*(1-p.update_B); % update the vector of the ALM coefficients 
    if p.disp2==1
        disp('------------------------------------------------------------------------------')
        disp(['Tolerance error: ',num2str(dif_B)])
    end
end
endtime=toc;
if p.disp2==1
    disp('------------------------------------------------------------------------------')
    disp(['Time to execute the algorithm ',num2str(endtime)])
    disp('------------------------------------------------------------------------------')
end
%--------------------------------------------------------------------------------------------------------------------------
s.R2l=R2l;
s.R2h=R2h;
s.B=B;
s.a_cross=a_cross;
s.g_a=g_a;
s.K_ts=K_ts;
for jj=1:p.simulT
    [s.r_ts(jj),s.w_ts(jj)]=prices(p,s.K_ts(jj),m.L,m.Zsim(jj));
end
%--------------------------------------------------------------------------------------------------------------------------