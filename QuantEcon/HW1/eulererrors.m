function EE=eulererrors(g_a,p,m)
    a_intp=linspace(p.Amin,p.Amax,p.intp);
    c=zeros(p.nzz,p.intp);
    Uc=zeros(p.nzz,p.intp);
    EUc=zeros(p.nzz,p.intp);
    EE=zeros(p.nzz,p.intp);
    g_a_intp=zeros(p.nzz,p.intp);
    for j=1:p.nzz % productivity    
    g_a_intp(j,:)=interp1(m.a_grid,g_a(j,:),a_intp,'linear','extrap');
    end
    c_aux=p.w*m.z_grid'+p.r*a_intp;
    distC=1;
    while distC>p.tol
        for j=1:p.nzz % productivity                        
            for i=1:p.intp % current assets
                EUc(j,i)= m.Pi(j,:)*c_aux(:,i).^(-p.sigma);
                c(j,i)=m.z_grid(j)*p.w + (1+p.r)*a_intp(i) - g_a_intp(j,i);
                Uc(j,i)=c(j,i)^(-p.sigma);
                EE(j,i)=(1+p.r)*p.beta*EUc(j,i)/Uc(j,i)-1;
            end
        end
        distC=max(max(abs(c-c_aux)));
        c_aux=c;
    end
    EE=log(abs(EE));
end