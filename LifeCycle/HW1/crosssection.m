function d=crosssection(p,m,r)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes cross-section statistics for three objetcs:
% assets, consumption and earnings
%---------------------------------------------------------------------------------------------------------------------------
d.dist_age=zeros(p.naa,p.J);
dist_mean=zeros(p.J,1);
dist_median=zeros(p.J,1);
dist_q75=zeros(p.J,1);
dist_q25=zeros(p.J,1);
gini_index=zeros(p.J,1);
lorenz_curve=zeros(p.naa+1,2,p.J);
% Assets
for d_3=1:p.J-1
    aux=m.Psi(d_3)*(r.g_a(:,:,d_3)*m.muJ')';
    d.dist_age(:,d_3)=sum(r.dist(:,:,d_3),2);
    dist_mean(d_3,1)=m.Psi(d_3)*sum(sum(r.dist(:,:,d_3).*r.g_a(:,:,d_3)));
    dist_median(d_3,1)=moments(0.5,aux,r.dist(:,:,d_3));
    dist_q25(d_3,1)=moments(0.25,aux,r.dist(:,:,d_3));
    dist_q75(d_3,1)=moments(0.75,aux,r.dist(:,:,d_3));
    [gini_index(d_3,1),lorenz_curve(:,:,d_3)]=gini(sum(r.dist(:,:,d_3),2),m.a_grid');
end
d.dist=d.dist_age*m.Psi;
d.dist=d.dist/sum(d.dist);
d.statsA=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];
d.lorenz_curveA=lorenz_curve;
% Earnings
for d_3=1:p.J
    aux=m.Psi(d_3)*(r.g_e(:,:,d_3)*m.muJ')';
    dist_mean(d_3,1)=m.Psi(d_3)*sum(sum(r.dist(:,:,d_3).*r.g_e(:,:,d_3)));
    dist_median(d_3,1)=moments(0.5,aux,r.dist(:,:,d_3));
    dist_q75(d_3,1)=moments(0.25,aux,r.dist(:,:,d_3));
    dist_q25(d_3,1)=moments(0.75,aux,r.dist(:,:,d_3));
    [gini_index(d_3,1),lorenz_curve(:,:,d_3)] = gini(sum(r.dist(:,:,d_3),2),aux');
end
d.statsE=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];
d.lorenz_curveE=lorenz_curve;
% Consumption
for d_3=1:p.J
    aux=m.Psi(d_3)*(r.g_c(:,:,d_3)*m.muJ')';
    dist_mean(d_3,1)=m.Psi(d_3)*sum(sum(r.dist(:,:,d_3).*r.g_c(:,:,d_3)));
    dist_median(d_3,1)=moments(0.5,aux,r.dist(:,:,d_3));
    dist_q75(d_3,1)=moments(0.25,aux,r.dist(:,:,d_3));
    dist_q25(d_3,1)=moments(0.75,aux,r.dist(:,:,d_3));
    [gini_index(d_3,1),lorenz_curve(:,:,d_3)] = gini(sum(r.dist(:,:,d_3),2),aux');
end
d.statsC=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];
d.lorenz_curveC=lorenz_curve;
%---------------------------------------------------------------------------------------------------------------------------