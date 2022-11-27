function [R]=solve_aiyagari(p,m,I)
r_min=-p.delta;
r_max=(1-p.beta)/p.beta;
err_R=1;
err_W=1;
iter=0;
if I==0
    p.tol=1e-4;
end

while abs(err_R)>p.tol && abs(err_W)
    iter = iter + 1;
    p.r=0.5*(r_max+r_min);
    [p.K0,p.L]=firms(p,m);
    p.w=(1-p.alpha)*p.Z*(p.K0/p.L)^p.alpha;
    if p.r<0
        p.Amin=0;
    else
        p.Amin=max(0,-p.w*m.z_grid(1)/p.r);
    end
    m.a_grid=linspace(p.Amin,p.Amax,p.naa);
    if I==0
        [V,g_a,p_a,g_c]=vfi(p,m);
        dist=getDist_dis(p,m,p_a);
    elseif I==1
        [V, ~, g_a, g_c]=egm(p,m);
        dist=getDist_cns(p,m,g_a);
    end
    KH=sum(sum(dist.*g_a));
    r1=p.alpha*p.Z*(p.L./max(KH,0.01)).^(1-p.alpha)-p.delta;
    w1=(1-p.alpha)*p.Z*(max(KH,0.01)./p.L).^p.alpha;
    err_R=r1-p.r;
    err_W=w1-p.w;
    if err_R < 0
        r_max = p.r;
    else
        r_min = p.r;
    end 
    disp(['Iteration number ',num2str(iter)])
    disp(['r0 = ',num2str(p.r),', r1 = ',num2str(r1),', w0 = ',num2str(p.w),', w1 = ',num2str(w1)])
    disp(['errR = ',num2str(abs(err_R)),', errW = ',num2str(abs(err_W))])
end
R.r=p.r;
R.w=p.w;
R.Kg=KH;
R.L=p.L;
R.c=g_c;
R.Kp=g_a;
R.V=V;
R.dist=dist;
R.Assets_dist=m.mu*dist;
R.a_grid=m.a_grid;
R.Y=p.Z*R.Kg^p.alpha*R.L^(1-p.alpha);