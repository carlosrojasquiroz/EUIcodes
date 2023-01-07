function [K_ts,a_cross] =aggns(p,m,g_a,a_cross)
%---------------------------------------------------------------------------------------------------------------------------
%% Setting matrices
%---------------------------------------------------------------------------------------------------------------------------
% Time series of the mean of capital distribution
%---------------------------------------------------------------------------------------------------------------------------
K_ts=zeros(p.simulT,1);         
%---------------------------------------------------------------------------------------------------------------------------   
% Time series of aggregate variables
%---------------------------------------------------------------------------------------------------------------------------   
Z_ts=m.Zsim';  % aggregate productivity
L=m.L; % aggregate employment 
rg_ts=zeros(p.simulT-1,1); % interest rate
w_ts=zeros(p.simulT-1,1); % wage
%---------------------------------------------------------------------------------------------------------------------------   
% Beginning-of-period assets distributions
%---------------------------------------------------------------------------------------------------------------------------
% for the low idiosyncratic shock
a_dist_l=zeros(p.simulT,p.intp);
% for the high idiosyncratic shock
a_dist_h=zeros(p.simulT,p.intp); 
%---------------------------------------------------------------------------------------------------------------------------
% Initial-period assets distributions
%---------------------------------------------------------------------------------------------------------------------------
% for the low idiosyncratic shock
a_dist_l(1,1:p.intp)=[a_cross(1,1:p.intp-1) 1-sum(a_cross(1,1:p.intp-1))];
% for the high idiosyncratic shock
a_dist_h(1,1:p.intp)=[a_cross(2,1:p.intp-1) 1-sum(a_cross(2,1:p.intp-1))]; 
%---------------------------------------------------------------------------------------------------------------------------
% Grid for the assets distribution
%---------------------------------------------------------------------------------------------------------------------------
a_values=gridspec(p.avalues_min,p.avalues_max,p.intp,1)'; 
%---------------------------------------------------------------------------------------------------------------------------
% Transition probabilities
%---------------------------------------------------------------------------------------------------------------------------
% Transition probabilities from one idiosyncratic shock, epsilon, to another, 
% epsilon', given that agg. shocks are s and s'
p_LL=[m.P(1,1) m.P(1,2); m.P(2,1) m.P(2,2)];
p_LH=[m.P(1,3) m.P(1,4); m.P(2,3) m.P(2,4)];
p_HL=[m.P(3,1) m.P(3,2); m.P(4,1) m.P(4,2)];
p_HH=[m.P(3,3) m.P(3,4); m.P(4,3) m.P(4,4)];
%---------------------------------------------------------------------------------------------------------------------------
%% Non-stochastic simulation
%---------------------------------------------------------------------------------------------------------------------------
for t=1:p.simulT   
% Aggregate capital
    K_ts(t)=(a_dist_l(t,:)+a_dist_h(t,:))*a_values;
    K_ts(t)=K_ts(t)*(K_ts(t)>=p.K_min)*(K_ts(t)<=p.K_max)+p.K_min*(K_ts(t)<p.K_min)+...
       p.K_max*(K_ts(t)>p.K_max);
% Prices
    %[rg_ts(t),w_ts(t)]=prices(p,K_ts(t),L_ts(t),Z_ts(t));
    rg_ts(t)=p.alpha*Z_ts(t)*(K_ts(t)/L)^(p.alpha-1)-p.delta;
    w_ts(t)=(1-p.alpha)*Z_ts(t)*(K_ts(t)/L)^p.alpha;
%--------------------------------------------------------------------------------------------------------------------------
% Individual assets function, a'
%--------------------------------------------------------------------------------------------------------------------------   
    g_a_ts(:,1)=interpn(m.a_grid,m.K_grid,reshape(g_a(1,:,m.Zshock(t),:),p.naa,p.nKK),...
        a_values,K_ts(t)*ones(p.intp,1),'linear');  
    g_a_ts(:,2)=interpn(m.a_grid,m.K_grid,reshape(g_a(2,:,m.Zshock(t),:),p.naa,p.nKK),...
        a_values,K_ts(t)*ones(p.intp,1),'linear');  
    g_a_ts=g_a_ts.*(g_a_ts>=p.avalues_min).*(g_a_ts<=p.avalues_max)+...
        p.avalues_min*(g_a_ts<p.avalues_min)+p.avalues_max*(g_a_ts>p.avalues_max);
%--------------------------------------------------------------------------------------------------------------------------
% Inverse of the individual capital function, g'(a) 
%--------------------------------------------------------------------------------------------------------------------------
% To invert g'(a), in the code is the object g_a_ts, we treat g'(a) as an argument and "a_ts" as  
% a value of the function in the argument g'(a).
% An inverse of g'(a) is not well defined for those points of the grid for which the value of 
% g'(a) is the same (for example, for low-productivity agents, we have g'(a)=0 for several 
% small grid values). Therefore, when inverting, we remove all but one grid points for which
% the values of g'(a) are repeated
%--------------------------------------------------------------------------------------------------------------------------
% g_a=p.a_min 
   index_min=zeros(1, p.nzz);
   index_min=sum(g_a_ts==p.avalues_min);
% if index_min>0, consider g'(a) starting from the (index_min)-th grid point; 
% otherwise, consider g'(a) starting from the first grid point 
   first=index_min.*(index_min>0)+1*(index_min==0); 
% g_a=p.a_max       
   index_max=zeros(1, p.nzz);     
   index_max=sum(g_a_ts==p.avalues_max);
% if index_max>0, consider g'(a) until the grid point (p.intp-(index_max-1)); otherwise, 
% consider g'(a) until the last grid point, which is p.intp    
   last=p.intp-((index_max-1).*(index_max>0)+0*(index_max==0)); 
% find a(g') in the low idiosyncratic productivity shock (state 1) by interpolation
   a_ts(:,1)=interp1(g_a_ts(first(1):last(1),1),a_values(first(1):last(1),1),a_values,'linear'); 
% find a(g') in the high idiosyncratic productivity shock (state 2) by interpolation
   a_ts(:,2)=interp1(g_a_ts(first(2):last(2),2),a_values(first(2):last(2),1),a_values,'linear');
% restrict a_ts to be in [p.a_min, p.a_max]       
    a_ts=a_ts.*(a_ts>=p.avalues_min).*(a_ts<=p.avalues_max)+...
        p.avalues_min*(a_ts<p.avalues_min)+p.avalues_max*(a_ts>p.avalues_max);
%--------------------------------------------------------------------------------------------------------------------------    
% Some values of a_ts at the beginning and in the end of the grid will be NaN. 
% This is because there are no values of g_a_ts (i.e., g'(a)) that correspond to some values 
% of a_ts (i.e., a). 
% For example, to have g_a_ts(a_ts)=0 for an employed agent a_ts must be negative, 
% which is not allowed, so we get NaN. These NaN values of a_ts create a problem when 
% computing the end-of-period capital distribution for terminal (but not for initial) grid-value 
% points. To deal with this problem, we set a_ts in the end of the grid to p.a_max whenever 
% they are NaN. 
%--------------------------------------------------------------------------------------------------------------------------
% Low idiosyncratic productivity shock
    jj=0; 
    while isnan(a_ts(p.intp-jj,1)) 
      a_ts(p.intp-jj,1)=p.avalues_max;
      jj=jj+1;
    end
    jj=0; 
    while isnan(a_ts(jj+1,1))
      a_ts(jj+1,1)=p.avalues_min;
      jj=jj+1;
    end
    % High idiosyncratic productivity shock
    jj=0; 
    while isnan(a_ts(p.intp-jj,2))
      a_ts(p.intp-jj,2)=p.avalues_max;
      jj=jj+1;
    end
    jj=0; 
    while isnan(a_ts(jj+1,2))
      a_ts(jj+1,2)=p.avalues_min;
      jj=jj+1;
    end
%--------------------------------------------------------------------------------------------------------------------------
% End-of-period cumulative capital distribution 
%--------------------------------------------------------------------------------------------------------------------------
    Fl=zeros(p.intp,1); 
    Fh=zeros(p.intp,1); 
% we have p.intp values of a_ts(j,1) and p.intp values of a_ts(j,2) which are inverse of 
% g'(a) for the low and high idiosyncratic productivity shocks
    for jj=1:p.intp
     % low idiosyncratic productivity shocks
        for ii=1:p.intp
              if a_values(ii,1)<=a_ts(jj,1)
                 Fl(jj)=Fl(jj)+a_dist_l(t,ii);             
              end
              if a_values(ii,1)>a_ts(jj,1)
                 Fl(jj)=Fl(jj)+(a_ts(jj,1)-a_values(ii-1,1))/(a_values(ii,1)-a_values(ii-1,1))*a_dist_l(t,ii); break
              end     
        end       
    % high idiosyncratic productivity shocks
        for ii=1:p.intp 
            if a_values(ii,1)<=a_ts(jj,2)
                  Fh(jj)=Fh(jj)+a_dist_h(t,ii); 
            end
            if a_values(ii,1)>a_ts(jj,2)
                Fh(jj)=Fh(jj)+(a_ts(jj,2)-a_values(ii-1,1))/(a_values(ii,1)-a_values(ii-1,1))*a_dist_h(t,ii); break  
            end
        end
    end
%--------------------------------------------------------------------------------------------------------------------------
% Next period's beginning-of-period distribution
%-------------------------------------------------------------------------------------------------------------------------- 
    if t <p.simulT     
%  Mass of agents in different idiosyncratic states conditional on agg. states
        if (m.Zshock(t)==1)&&(m.Zshock(t+1)==1);g=p_LL; end 
        if (m.Zshock(t)==1)&&(m.Zshock(t+1)==2);g=p_LH; end
        if (m.Zshock(t)==2)&&(m.Zshock(t+1)==1);g=p_HL; end
        if (m.Zshock(t)==2)&&(m.Zshock(t+1)==2);g=p_HH; end
% Next period's beginning-of-period distribution (see formulas in Den Haan, Judd and Juillard, 2008)    
% low idiosyncratic productivity shocks        
        Pl=(g(1,1)*Fl+g(2,1)*Fh)/(g(1,1)+g(2,1));
% high idiosyncratic productivity shocks        
        Ph=(g(1,2)*Fl+g(2,2)*Fh)/(g(1,2)+g(2,2));   
% low idiosyncratic productivity shocks
       a_dist_l(t+1,1)=Pl(1,1); % probability of having a=p.a_min at t+1
       a_dist_l(t+1,2:p.intp-1)=Pl(2:p.intp-1,1)'-Pl(1:p.intp-2,1)'; % probabilities of different grid points kvalues
       a_dist_l(t+1,p.intp)=1-sum(a_dist_l(t+1,1:p.intp-1)); % probability of a=p.a_max is set so that 
   % "a_dist_l" is normalized to one     
% high idiosyncratic productivity shocks 
       a_dist_h(t+1,1)=Ph(1,1); 
       a_dist_h(t+1,2:p.intp-1)=Ph(2:p.intp-1,1)'-Ph(1:p.intp-2,1)';
       a_dist_h(t+1,p.intp)=1-sum(a_dist_h(t+1,1:p.intp-1));
    end
end
%--------------------------------------------------------------------------------------------------------------------------
% Aggregate capital in T
%--------------------------------------------------------------------------------------------------------------------------
K_ts(p.simulT)=(a_dist_l(p.simulT,:)+a_dist_h(p.simulT,:))*a_values;
K_ts(p.simulT)=K_ts(p.simulT)*(K_ts(p.simulT)>=p.K_min)*(K_ts(p.simulT)<=p.K_max)+...
    p.K_min*(K_ts(p.simulT)<p.K_min)+p.K_max*(K_ts(p.simulT)>p.K_max);
%--------------------------------------------------------------------------------------------------------------------------
% Terminal distribution of assets
%--------------------------------------------------------------------------------------------------------------------------
a_cross(1,:)=a_dist_l(p.simulT,:); % distribution for unemployed
a_cross(2,:)=a_dist_h(p.simulT,:); % distribution for employed
%--------------------------------------------------------------------------------------------------------------------------