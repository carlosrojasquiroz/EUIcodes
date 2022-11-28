function [V, g_a, g_c] = vfic(p,m)
    V=zeros(p.naa,p.nzz,p.J);
    g_a=zeros(p.naa,p.nzz,p.J);
    g_c=zeros(p.naa,p.nzz,p.J);
    d=(1-p.theta)*m.e*p.w+m.b+p.Tg;
    %   In period j=J
    for i=1:p.naa % current assets 
        for j=1:p.nzz % productivity
            g_c(i,j,p.J)=max(d(p.J,j)+(1+p.rg)*m.a_grid(i),0);
            V(i,j,p.J)=utility(g_c(i,j,p.J),p.sigma);
        end
    end
    g_a(:,:,p.J)=zeros(p.naa,p.nzz);
    %   In period j<J
    for k=1:p.J-1 % age
        for i=1:p.naa % current assets
            for j=1:p.nzz % productivity
                w_aux=d(p.J-k,j)+(1+p.rg)*m.a_grid(i);
                auxvar= @(ap) -(utility(w_aux-ap,p.sigma)+p.beta.*m.Sj(p.J-k)*m.Pz(j,:)*interp1(m.a_grid,V(:,:,p.J-k+1),ap)');
                [g_a(i,j,p.J-k),V(i,j,p.J-k)]=fminbnd(auxvar,m.a_grid(1),min(w_aux,m.a_grid(end)));
                g_c(i,j,p.J-k)=max(d(p.J-k,j)+(1+p.rg)*m.a_grid(i)-g_a(i,j,p.J-k),0);
                V(i,j,p.J-k)=-V(i,j,p.J-k);
            end
        end
    end
end