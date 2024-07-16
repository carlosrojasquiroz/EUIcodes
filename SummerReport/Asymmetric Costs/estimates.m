function DeltaSim=estimates(p,v,d)
% % Value function iteration
% [v.idB,v.idD,v.q]=vfi(p,v);
% % Simulation
% r=simulation(p,v);
% % Estimation
% DeltaSim=estimation(p,r);
% DeltaSim=[DeltaSim(1,d.Nhorz+1) DeltaSim(2,d.Nhorz+1)];
% Value function iteration
[v.idB,v.idD,v.q]=vfi(p,v);
% Simulation
r=simulation(p,v);
%---------------------------------------------------------------------------------------------------------------------------
% Simulated method of moments
%---------------------------------------------------------------------------------------------------------------------------
if p.moment==1
    RelativeStd=zeros(p.Get,1);
    MeanSpread=zeros(p.Get,1);
    for i=1:p.Get
    [~,SyT2]=hpfilter(log(r.yT(i,:)),p.lambdaHP);
    [~,SyN2]=hpfilter(log(r.yN(i,:)),p.lambdaHP);
    RelativeStd(i,:)=std(SyT2)/std(SyN2);
    rr=r.spread(i,:);
    MeanSpread(i,:)=mean(rr(isfinite(rr)));
    end
    Moment1=mean(RelativeStd);
    Moment2=mean(MeanSpread);
    DeltaSim=[Moment1 Moment2];
else
%---------------------------------------------------------------------------------------------------------------------------
% Indirect inference
%---------------------------------------------------------------------------------------------------------------------------
% Estimation
DeltaSim=estimation(p,r);
DeltaSim=[DeltaSim(1,d.Nhorz+1) DeltaSim(2,d.Nhorz+1)];
end
end