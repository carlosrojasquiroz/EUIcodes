function s=vfi(p,m)
%---------------------------------------------------------------------------------------------------------------------------
% This function executes the VFI algorithm to solve a model with discrete
% choice. It saves the solution in the structure "s" 
%---------------------------------------------------------------------------------------------------------------------------
distV=1;
iter=0;
%---------------------------------------------------------------------------------------------------------------------------
% Period T (end of the economy)
%---------------------------------------------------------------------------------------------------------------------------
% Working state
c1=p.w*m.z_grid+(1+p.r)*m.a_grid;
V1=utility(c1,p.sigma)-p.phi;
% Not working state
c0=(1+p.r)*m.a_grid;
V0=utility(c0,p.sigma); 
% Actual value function
V=zeros(1,p.naa);
if p.evind==0
    V=max(V1,V0);
else
    Vt=[V1; V0]; % set of value functions 
    prob=zeros(2,p.naa); % probability of working/not working
    for ind_2=1:p.naa
        V(1,ind_2)=p.epsilon*logsumexp(Vt(:,ind_2)./p.epsilon); % total value function
        prob(:,ind_2)=softmax(Vt(:,ind_2)./p.epsilon); % probability of working/not working
    end
end
%---------------------------------------------------------------------------------------------------------------------------
% VFI algorithm
%---------------------------------------------------------------------------------------------------------------------------
tic;
while distV>p.tol && iter<p.maxiter
    [Vnew,V1,V0,p1,p0]=vfi_step(p,m,V);
    distV=norm(V-Vnew)./(1+norm(V));
    V=Vnew;
    iter=iter+1;
    if p.disp1==1
        if p.phi==0
            disp(['SIM model - VFI iteration number ',num2str(iter)])
        elseif p.phi>0 && p.evind==0
            disp(['Discrete choice model - VFI iteration number ',num2str(iter)])
        elseif p.phi>0 && p.evind==1
            disp(['DC model and EV shocks - VFI iteration number ',num2str(iter)])
        end
        disp(['error = ',num2str(distV)])
    end
end
endtime=toc;
if p.disp1==1   
    disp(['Time to execute the algorithm ',num2str(endtime)])
end
if p.evind==0
    s.g_n=(V1>V0);    
else
    Vt=[V1; V0];
    prob=zeros(2,p.naa);
    for ind_2=1:p.naa
        prob(:,ind_2)=softmax(Vt(:,ind_2)./p.epsilon);
    end
    s.g_n=prob(1,:);
end
s.g_a=s.g_n.*m.a_grid(p1)+(1-s.g_n).*m.a_grid(p0);
s.V=V;
s.V1=V1;
s.V0=V0;
s.g_c=s.g_n.*p.w*m.z_grid+(1+p.r)*m.a_grid-s.g_a;
%---------------------------------------------------------------------------------------------------------------------------