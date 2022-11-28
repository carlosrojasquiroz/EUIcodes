function [V, g_a, g_c] = vfi(p,m)
    V=zeros(p.naa,p.nzz,p.J);
    p_a=zeros(p.naa,p.nzz,p.J);
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
    p_a(:,:,p.J)=ones(p.naa,p.nzz);
    g_a(:,:,p.J)=zeros(p.naa,p.nzz);
    %   In period j<J
    for k=1:p.J-1 % age
        for i=1:p.naa % current assets
            for j=1:p.nzz % productivity
                c_aux=d(p.J-k,j)+(1+p.rg)*m.a_grid(i)-m.a_grid;
                auxvar=utility(c_aux,p.sigma)+p.beta.*m.Sj(p.J-k)*m.Pz(j,:)*V(:,:,p.J-k+1)';
                [V(i,j,p.J-k),p_a(i,j,p.J-k)]=max(auxvar(:));
                g_a(i,j,p.J-k)=m.a_grid(p_a(i,j,p.J-k));
                g_c(i,j,p.J-k)=max(d(p.J-k,j)+(1+p.rg)*m.a_grid(i)-g_a(i,j,p.J-k),0);
            end
        end
    end
end