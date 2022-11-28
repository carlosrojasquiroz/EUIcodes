function EE=eulererrors(g_a,p,m)
    naa_intp=p.intp;
    a_intp=linspace(p.a_min,p.a_max,naa_intp);
    Uc=zeros(naa_intp,p.nzz,p.J);
    EUc=zeros(naa_intp,p.nzz,p.J);
    EE=zeros(naa_intp,p.nzz,p.J);
    g_a_intp=interp1(m.a_grid,g_a,a_intp,'linear','extrap');
    for k=1:p.J-1 % age
        for j=1:p.nzz % productivity                        
            for i=1:naa_intp % current assets
                Uc(i,j,k)=((1+p.rg)*a_intp(i)+(1-p.theta)*m.e(k,j)*p.w+m.b(k)+p.Tg-g_a_intp(i,j,k))^(-p.sigma);
                EUc(i,j,k)=m.Pz(j,:)*(((1+p.rg)*g_a_intp(i,j,k)+(1-p.theta)*m.e(k+1,:)*p.w+m.b(k+1)+p.Tg-g_a_intp(i,:,k+1)).^(-p.sigma))';
                EE(i,j,k)=Uc(i,j,k)./EUc(i,j,k)-p.beta*(1+p.rg)*m.Sj(k);
            end
        end
    end
end
