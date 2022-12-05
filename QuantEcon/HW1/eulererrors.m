function EE=eulererrors(g_a,p,m)
a_intp=exp(linspace(log(p.Amin+1),log(p.Amax+1),p.intp))-1;
EE=zeros(p.nzz,p.intp);
for z_i=1:p.nzz % productivity                        
    for a_i=1:p.intp % current assets
    ap=interp1(m.a_grid,g_a(z_i,:),a_intp(a_i),'linear');
    c=m.z_grid(z_i)*p.w+(1+p.r)*a_intp(a_i)-ap;
    uc=Uc(c,p.sigma);
    
    Euc=0;
    for zp_i=1:p.nzz % productivity
        app=interp1(m.a_grid,g_a(zp_i,:),ap,'linear');
        cp=m.z_grid(zp_i)*p.w+(1+p.r)*ap-app;
        Euc=m.Pi(z_i,zp_i)*Uc(cp,p.sigma)+Euc;
    end

    EE(z_i,a_i)=(1+p.r)*p.beta*Euc/uc-1;
    end
end
