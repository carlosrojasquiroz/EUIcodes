function TRANS=solve_trans(p,m,SS0,SS1)

r=[linspace(SS0.r,SS1.r,p.ntt/2), SS1.r*ones(1,p.ntt/2)] ;
dist=zeros(p.nzz,p.naa,p.ntt);
g_c=zeros(p.nzz,p.naa,p.ntt);
g_a=zeros(p.nzz,p.naa,p.ntt);
Kh=zeros(1,p.ntt);
C=zeros(1,p.ntt);
dist(:,:,1)=SS0.dist;
g_a(:,:,end)=SS1.Kp;
g_c(:,:,end)=SS1.c;
Kh(1)=sum(sum(dist(:,:,1).*(ones(p.nzz,1)*m.a_grid)));

    for ii=1:p.maxiter
        w=(1-p.alpha)*(m.Zt.*(p.alpha./(r+p.delta)).^p.alpha).^(1/(1-p.alpha));
        for t=p.ntt-1:-1:1
            [g_a(:,:,t),g_c(:,:,t)]=step_egm(g_c(:,:,t+1),r(t+1),r(t),w(t),p,m);
        end
        dist(:,:,2:end)=0; 
        C(1)=sum(sum(dist(:,:,1).*g_c(:,:,1)));
        for t=1:p.ntt-1
            % iterate distribution forward
            [dist(:,:,t+1)]=step_dist(dist(:,:,t),g_a(:,:,t),p,m);
            % compute HH aggregates
            Kh(t+1)=sum(sum(dist(:,:,t).*g_a(:,:,t)));
            C(t+1)=sum(sum(dist(:,:,t+1).*g_c(:,:,t+1)));
        end
        r_new=m.Zt.*p.alpha.*Kh.^(p.alpha-1)*p.L^(1-p.alpha)-p.delta;
        disp([ 'iter = ', num2str(ii),'   ', 'err_r = ', num2str((max(abs(r - r_new))))])
        if (max(abs(r - r_new)) < p.tol)
            break
        else
        if (ii<=10) % begin with slower updating for stability
            weight = p.weightr/2;
        else
            weight = p.weightr;
        end
            r = (1-weight)*r + weight*r_new;
        end
    end

    if ii == p.maxiter
        disp(['Maximum number of iterations on transition reached. Remaining error is ', num2str(max(abs(r - r_new)))])
    end
% load output
TRANS.g_c=g_c;
TRANS.g_a=g_a;
TRANS.dist=dist;
TRANS.r=r;
TRANS.w=w;
TRANS.Kh=Kh;
TRANS.C=C;
TRANS.Y=m.Zt.*Kh.^p.alpha.*p.L^(1-p.alpha);    