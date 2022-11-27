function TRANS=solve_transJ(p,m,SS,J)

r=SS.r*ones(1,p.ntt);
dist=zeros(p.nzz,p.naa,p.ntt);
g_c=zeros(p.nzz,p.naa,p.ntt);
g_a=zeros(p.nzz,p.naa,p.ntt);
Kh=zeros(1,p.ntt);
C=zeros(1,p.ntt);
dist(:,:,1)=SS.dist;
g_a(:,:,end)=SS.Kp;
g_c(:,:,end)=SS.c;
Kh(1)=sum(sum(dist(:,:,1).*(ones(p.nzz,1)*m.a_grid)));

    for ii=1:p.maxiter
        w=(1-p.alpha)*(m.Zt.*(p.alpha./(r+p.delta)).^p.alpha).^(1/(1-p.alpha));
        Kdem=((r+p.delta)./(p.alpha*m.Zt*p.L^(1-p.alpha))).^(1/(p.alpha-1)); 
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
        rnew = r(1:end-1)' - J\(Kh(1:end-1)-Kdem(1:end-1))'; 
        rnew = [rnew' SS.r]; % anchor last period, not to be updated
        r = rnew;
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