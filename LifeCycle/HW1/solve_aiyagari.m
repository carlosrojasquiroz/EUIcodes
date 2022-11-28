function [Tg_agg,K_agg,rg_eq,w_eq,theta_eq,b_eq,K_Y_agg,dist]=solve_aiyagari(p,m)
Tg_agg=1.2;
rg_new=0.02;
[K_agg,~]=firms(p);
err_R=1;
err_T=1;
while err_R>p.tol
    p.K=K_agg;
    p.rg=rg_new;
    while err_T>p.tol
        p.Tg=Tg_agg;
        [~,g_a,~] = egm(p,m);
%-------------------------------------------------------------------------------------------
% Stationary distribution + aggregate transfers
%-------------------------------------------------------------------------------------------
        dist=zeros(p.naa,p.nzz,p.J);
        Tg_j=zeros(p.J,1);
            for k=1:p.J
                dist(:,:,k)=getDist_cns(p,m,g_a(:,:,k));
                Tg_j(k,1)=sum(sum((1+p.rg).*dist(:,:,k).*g_a(:,:,k)));
            end
        Tg_agg=(m.Psi.*(1-m.Sj))'*Tg_j;
        err_T=abs(p.Tg-Tg_agg);
    end
%-------------------------------------------------------------------------------------------
% Aggregate capital + equilibrium interest rate
%-------------------------------------------------------------------------------------------    
    k_j=zeros(p.J,1);
    for k=1:p.J
        k_j(k,1) = sum(sum(dist(:,:,k).*g_a(:,:,k)));
    end
    K_agg=m.Psi'*k_j;
    rg_eq=p.alpha*(K_agg/p.L)^(p.alpha-1)-p.delta;
    rg_new=rg_eq*0.5+p.rg*0.5;
    err_R=abs(p.rg-rg_eq);
end
w_eq=(1-p.alpha).*(K_agg./p.L)^p.alpha;
theta_eq=p.omega*sum(m.Psi(p.JR:p.J))/sum(m.Psi(1:p.JR-1));
b_eq=theta_eq*w_eq*p.L./sum(m.Psi(p.JR:p.J));
K_Y_agg=(K_agg./p.L)^(1-p.alpha);
end