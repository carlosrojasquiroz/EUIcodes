function [Tg_agg,K_agg,rg_eq,w_eq,theta_eq,b_eq,K_Y_agg,dist,g_a,g_e,g_c]=solve_hugget(p,m)
Tg_agg=1.2;
rg_new=0.02;
err_R=1;
err_T=1;
while err_R>p.tol
    p.rg=rg_new;
    [p.K,p.w]=firms(p);
    [p.theta,m.b]=fiscal(p,m);
    while err_T>p.tol
        p.Tg=Tg_agg;
        [~,g_a,g_c,g_e] = egm(p,m);
%-------------------------------------------------------------------------------------------
% Stationary distribution + aggregate transfers + aggregate capital 
%-------------------------------------------------------------------------------------------
        dist=zeros(p.naa,p.nzz,p.J);
        Tg_j=zeros(p.J,1);
         k_j=zeros(p.J,1);
            for k=1:p.J
                dist(:,:,k)=getDist_cns(p,m,g_a(:,:,k));
                Tg_j(k,1)=m.Psi(k).*(1-m.Sj(k))*sum(sum((1+p.rg).*dist(:,:,k).*g_a(:,:,k)));
                k_j(k,1) = m.Psi(k)*sum(sum(dist(:,:,k).*g_a(:,:,k)));
            end
        Tg_agg=sum(Tg_j(:));
        K_agg=sum(k_j(:));
        K_Y_agg=(K_agg./p.L)^(1-p.alpha);
        err_T=abs(p.Tg-Tg_agg);
    end
    rg_eq=p.alpha*(K_agg/p.L)^(p.alpha-1)-p.delta;
    err_R=abs(p.rg-rg_eq);
    rg_new=rg_eq*0.5+p.rg*0.5;
end
w_eq=p.w;
theta_eq=p.theta;
b_eq=m.b;
end