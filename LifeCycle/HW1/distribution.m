function [dist, statsA, statsE, statsC, dist_age]=distribution(m,p,r)

dist_age=zeros(p.naa,p.J);
dist_mean=zeros(p.J,1);
dist_median=zeros(p.J,1);
dist_q75=zeros(p.J,1);
dist_q25=zeros(p.J,1);
gini_index=zeros(p.J,1);
for k=1:p.J
    dist_age(:,k)=sum(r.dist(:,:,k),2);
    dist_mean(k,1)=m.a_grid*dist_age(:,k);
    dist_median(k,1)=m.a_grid(median_dist(dist_age(:,k),0.5));
    dist_q75(k,1)=m.a_grid(median_dist(dist_age(:,k),0.75));
    dist_q25(k,1)=m.a_grid(median_dist(dist_age(:,k),0.25));
    [gini_index(k,1),~] = gini(dist_age(:,k),m.a_grid');
end
dist=dist_age*m.Psi;
dist=dist/sum(dist);
statsA=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];


for k=1:p.J
    dist_age(:,k)=sum(r.dist(:,:,k),2);
    aux=sum(r.g_eF(:,:,k),2)';
    dist_mean(k,1)=aux*dist_age(:,k);
    dist_median(k,1)=aux(median_dist(dist_age(:,k),0.5));
    dist_q75(k,1)=aux(median_dist(dist_age(:,k),0.75));
    dist_q25(k,1)=aux(median_dist(dist_age(:,k),0.25));
    [gini_index(k,1),~] = gini(dist_age(:,k),aux');
end
statsE=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];

for k=1:p.J
    dist_age(:,k)=sum(r.dist(:,:,k),2);
    aux=sum(r.g_cF(:,:,k),2)';
    dist_mean(k,1)=aux*dist_age(:,k);
    dist_median(k,1)=aux(median_dist(dist_age(:,k),0.5));
    dist_q75(k,1)=aux(median_dist(dist_age(:,k),0.75));
    dist_q25(k,1)=aux(median_dist(dist_age(:,k),0.25));
    [gini_index(k,1),~] = gini(dist_age(:,k),aux');
end
statsC=[dist_mean,  dist_median,  dist_q25,  dist_q75, gini_index];

end

