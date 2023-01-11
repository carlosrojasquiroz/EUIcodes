function EE=eee(g_a,p,m)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the Euler equation errors using the policy function "g_a"
%---------------------------------------------------------------------------------------------------------------------------
a_intp=linspace(p.a_min,p.a_max,p.intp);
EE=zeros(p.intp,p.nzz,p.J);
if p.disp1==1
disp('Computing the Euler equation errors...')
end
tic;
for d_3=1:p.J-1 % age
    ap=zeros(p.intp,p.nzz);
    for d_2=1:p.nzz % productivity
        ap(:,d_2)=interp1(m.a_grid,g_a(:,d_2,d_3),a_intp,'linear','extrap');
        app=zeros(p.intp,p.nzz);
        for d_4=1:p.nzz % productivity in the next period
            app(:,d_4)=interp1(m.a_grid,g_a(:,d_4,d_3+1),ap(:,d_2),'linear');
        end
        nfe=(1-p.theta)*m.e(d_3,d_2)*p.w+m.b(d_3)+p.Tg;
        nfep=(1-p.theta)*m.e(d_3+1,:)*p.w+m.b(d_3+1)+p.Tg;
        for d_1=1:p.intp % current assets
            c=(1+p.rg)*a_intp(d_1)+nfe-ap(d_1,d_2);
            Uc=c.^(-p.sigma);
            cp=(1+p.rg)*ap(d_1,d_2)*ones(p.nzz,1)+nfep'-app(d_1,:)';
            EUc=m.Pz(d_2,:)*cp.^(-p.sigma); 
            EE(d_1,d_2,d_3)=Uc/EUc-p.beta*(1+p.rg)*m.Sj(d_3);    
        end
    end
end
if p.disp1==1
disp('...It is done!')
end
endtime=toc;
if p.disp1==1   
    disp(['Time to compute Euler equation errors ',num2str(endtime)])
end
%---------------------------------------------------------------------------------------------------------------------------