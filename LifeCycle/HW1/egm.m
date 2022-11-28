function [V, g_a, g_c,g_e] = egm(p,m)
    V=zeros(p.naa,p.nzz,p.J);
    g_a=zeros(p.naa,p.nzz,p.J);
    g_e=zeros(p.naa,p.nzz,p.J);
    g_c=zeros(p.naa,p.nzz,p.J);
    d=(1-p.theta)*m.e*p.w+m.b+p.Tg;
% Algorithm
    for k=1:p.J-1 % age
        for j=1:p.nzz % productivity
                d1=(1-p.theta)*m.e(p.J-k,j)*p.w+m.b(p.J-k)+p.Tg;
                d2=(1-p.theta)*m.e(p.J-k+1,:)*p.w+m.b(p.J-k+1)+p.Tg;
                g_aux=zeros(p.naa,1);
            for i=1:p.naa % current assets
                cp=(1+p.rg)*m.a_grid(i)+d2-g_a(i,:,p.J-k+1);
                g_aux(i) =((p.beta*(1+p.rg)*m.Sj(p.J-k)*m.Pz(j,:)*cp'.^(-p.sigma)).^(-1/p.sigma)+ m.a_grid(i) - d1)./(1+p.rg);
            end
                g_temp=interp1(g_aux,m.a_grid,m.a_grid,'linear','extrap');
                g_temp(g_temp<m.a_grid(1))=m.a_grid(1);
                g_temp(g_temp>m.a_grid(end))=m.a_grid(end);
                g_a(:,j,p.J-k)=g_temp;
        end
    end
    %   In period j=J
    for i=1:p.naa % current assets 
        for j=1:p.nzz % productivity
            g_c(i,j,p.J)=max(d(p.J,j)+(1+p.rg)*m.a_grid(i),0);
            g_e(i,j,p.J)=d(p.J,j)+(1+p.rg)*m.a_grid(i);
            V(i,j,p.J)=utility(g_c(i,j,p.J),p.sigma);
        end
    end
    %   In period j<J
    for k=1:p.J-1 % age
        for i=1:p.naa % current assets
            for j=1:p.nzz % productivity
                g_c(i,j,p.J-k)=max(d(p.J-k,j)+(1+p.rg)*m.a_grid(i)-g_a(i,j,p.J-k),0);
                g_e(i,j,p.J-k)=d(p.J-k,j)+(1+p.rg)*m.a_grid(i);
                V(i,j,p.J-k)=utility(g_c(i,j,p.J-k),p.sigma)+p.beta*m.Sj(p.J-k)*V(i,j,p.J-k+1);
            end
        end
    end
end