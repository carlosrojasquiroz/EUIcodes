function [g_a,g_c]=step_egm(g_c,rp,r,w,p,m)
g_a=zeros(p.nzz,p.naa);
distC=1;
distV=1;
c_aux=g_c;
Vp = utility(c_aux,p.sigma)./(1-p.beta);
% Algorithm
%while distC>p.tol
while distV>p.tol    
    EUc= m.Pi*c_aux.^(-p.sigma);
    Ucp= ((1+rp)*p.beta*EUc).^(-1/p.sigma);
    a=(Ucp + m.a_grid - m.z_grid'*w)/(1+r);
    for j=1:p.nzz % productivity
        g_a(j,:)=interp1(a(j,:),m.a_grid,m.a_grid,'linear','extrap');
    end
     g_a(g_a<m.a_grid(1)) = m.a_grid(1);
     g_a(g_a>m.a_grid(end)) = m.a_grid(end);
     g_c=m.z_grid'*w + (1+r)*m.a_grid - g_a;
     V=utility(g_c,p.sigma)+p.beta*m.Pi*Vp;      
     distC=max(max(abs(g_c-c_aux)));
     distV=max(max(abs(V-Vp)));
     c_aux=g_c;
     Vp=V;
end