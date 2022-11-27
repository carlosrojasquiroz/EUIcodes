function [V,g_a,p_a,g_c]=vfi(p,m)
V=utility(m.z_grid'*p.w + p.r*m.a_grid,p.sigma)./(1-p.beta);
p_a=zeros(p.nzz,p.naa);
g_a=zeros(p.nzz,p.naa);
g_c=zeros(p.nzz,p.naa);
distV=1;
% Algorithm
    while distV>p.tol
        Vaux=V;
        for j=1:p.nzz % productivity
            for i=1:p.naa % current assets
                c=p.w*m.z_grid(j)+(1+p.r)*m.a_grid(i)-m.a_grid;
                auxvar=utility(c,p.sigma)+(p.beta*m.Pi(j,:)*Vaux);
                [V(j,i),p_a(j,i)] = max(auxvar(:));
                g_a(j,i)=m.a_grid(p_a(j,i));
                g_c(j,i)=max(p.w*m.z_grid(j)+(1+p.r)*m.a_grid(i)-g_a(j,i),0);
            end
        end
        distV=max(max(abs(V-Vaux)));
    end