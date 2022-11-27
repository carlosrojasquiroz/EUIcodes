function [J,Jsup,Jdem]=compute_Jac(p,m,SS)
dr=1e-6;
r=SS.r*ones(1,p.ntt);
r(p.ntt-1)=SS.r+dr;
g_c=zeros(p.nzz,p.naa,p.ntt);
g_a=zeros(p.nzz,p.naa,p.ntt);
g_a(:,:,end)=SS.Kp;
g_c(:,:,end)=SS.c;
w=(1-p.alpha)*(p.Z.*(p.alpha./(r+p.delta)).^p.alpha).^(1/(1-p.alpha));
for t=p.ntt-1:-1:1
    [g_a(:,:,t),g_c(:,:,t)]=step_egm(g_c(:,:,t+1),r(t+1),r(t),w(t),p,m);
end
dK_0s=NaN(1,p.ntt-1);
dD_1s=NaN(p.nzz*p.naa,p.ntt-1);
[~,LambdaSS]=getDist_cnsJ(p,m,SS.Kp);
for t = p.ntt-1:-1:1            
    s = p.ntt-t;
    % compute dK_0s
    dK_0s(s) = (sum(sum(SS.dist.*g_a(:,:,t)))-sum(sum(SS.dist.*SS.Kp)))/dr;
    % compute dD_1s
    [~,Lambda0]=getDist_cnsJ(p,m,g_a(:,:,t));
    dD_1s(:,s)=(reshape(SS.dist,1,p.nzz*p.naa)*(Lambda0-LambdaSS))/dr;
end
E_t=NaN(p.nzz*p.naa,p.ntt-2);
Lambda_rec=(LambdaSS^0);
y_SS=reshape(SS.Kp,p.nzz*p.naa,1);
for t = 1:p.ntt-2            
    E_t(:,t)=Lambda_rec*y_SS;
    Lambda_rec=Lambda_rec*LambdaSS;
end
F = NaN(p.ntt-1,p.ntt-1);
F(1,:)=dK_0s;
for s=1:p.ntt-1
    for t=2:p.ntt-1
        F(t,s)= E_t(:,t-1)'*dD_1s(:,s);
    end
end
Jsup = NaN(p.ntt-1,p.ntt-1);
Jsup(1,:)=F(1,:);
Jsup(:,1)=F(:,1);
for s=2:p.ntt-1
    for t=2:p.ntt-1
        Jsup(t,s)=Jsup(t-1,s-1)+F(t,s);
    end
end
dKdem=(1/(p.alpha-1)) * (1/(p.alpha*p.Z*p.L^(1-p.alpha)))*((SS.r+p.delta)/(p.alpha*p.Z*p.L^(1-p.alpha)))^((2-p.alpha)/(p.alpha-1));
Jdem=dKdem*eye(p.ntt-1);
J=[zeros(1,p.ntt-1); Jsup(1:end-1,:)]-Jdem;