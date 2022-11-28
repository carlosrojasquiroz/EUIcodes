function val=median_dist(dist,pctl)
[R,~]=size(dist);

for ii=1:R
    val=ii;
    crit1=sum(dist(1:ii,1));
    crit2=sum(dist(ii:R),1);
    if crit1>=pctl && crit2>=1-pctl
        break
    end
end

end

