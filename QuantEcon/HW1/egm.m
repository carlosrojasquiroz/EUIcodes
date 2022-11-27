function [V, a, g_a,g_c]=egm(p,m)
g_a=zeros(p.nzz,p.naa);
g_c=zeros(p.nzz,p.naa);
distC=1;
distV=1;
c_aux=p.w*m.z_grid'+p.r*m.a_grid;
V=utility(c_aux,p.sigma)./(1-p.beta);
% Algorithm
%while distC>p.tol
while distV>p.tol
    Vaux=V;
    EUc= m.Pi*c_aux.^(-p.sigma);
    Ucp= ((1+p.r)*p.beta*EUc).^(-1/p.sigma);
    a=(Ucp + m.a_grid - m.z_grid'*p.w)/(1+p.r);
    for j=1:p.nzz % productivity
        g_a(j,:)=interp1(a(j,:),m.a_grid,m.a_grid,'linear','extrap');
    end
     g_a(g_a<m.a_grid(1)) = m.a_grid(1);
     g_a(g_a>m.a_grid(end)) = m.a_grid(end);
     g_c=m.z_grid'*p.w + (1+p.r)*m.a_grid - g_a;
     V=utility(g_c,p.sigma)+p.beta*m.Pi*Vaux;
     distC=max(max(abs(g_c-c_aux)));
     distV=max(max(abs(V-Vaux)));
     c_aux=g_c;
end