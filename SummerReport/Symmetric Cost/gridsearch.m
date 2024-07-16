function f=gridsearch(p,v,d)
f.GridT=linspace(p.LowBoundT,p.UpBoundT,p.Steps);
f.GridN=linspace(p.LowBoundN,p.UpBoundN,p.Steps);
%--------------------------------------------------------------------------------------------------------------------------
disp('I start the algorithm of...')
if p.moment==1
    disp('Simulated Method of Moments')
else
    disp('Indirect inference')
end
f.W=eye(2);
iter=0;
for i=1:p.Steps
      paramgs=f.GridT(i);
      f.Jgs0(i)=inference(paramgs,p,v,d,f.W);
      iter=iter+1;
      display(iter)
end
%    
[f.Jopt0,f.idT0] = min(f.Jgs0(:));
f.chiTopt0=f.GridT(f.idT0);
display(f.chiTopt0)
%--------------------------------------------------------------------------------------------------------------------------
p.chi1_T=f.chiTopt0; 
p.chi1_N=f.chiTopt0; 
% %---------------------------------------------------------------------------------------------------------------------------
% % Value function iteration
% %---------------------------------------------------------------------------------------------------------------------------
% [v.idB,v.idD,v.q]=vfi(p,v);
% %---------------------------------------------------------------------------------------------------------------------------
% % Simulation
% %---------------------------------------------------------------------------------------------------------------------------
% r=simulation(p,v);
% if p.moment==1
%    RelativeStd=zeros(p.Get,1);
%     MeanSpread=zeros(p.Get,1);
%     for i=1:p.Get
%     [~,SyT2]=hpfilter(log(r.yT(i,:)),p.lambdaHP);
%     [~,SyN2]=hpfilter(log(r.yN(i,:)),p.lambdaHP);
%     RelativeStd(i,:)=std(SyT2)/std(SyN2);
%     rr=r.spread(i,:);
%     MeanSpread(i,:)=mean(rr(isfinite(rr)));
%     end
%     Moment1=mean(RelativeStd);
%     Moment2=mean(MeanSpread);
%     MomentSim=[Moment1 Moment2];
%     f.Md=(d.MomentData-MomentSim);
% else
%     DeltaSim=estimation(p,r);
%     DeltaHatT=[d.DeltaHat(1,d.Nhorz+1) d.DeltaHat(2,d.Nhorz+1)];
%     DeltaSimT=[DeltaSim(1,d.Nhorz+1) DeltaSim(2,d.Nhorz+1)];
%     f.Md=(DeltaHatT-DeltaSimT);
% end
% VarCovar=f.Md'*f.Md/p.Ntime;
% f.Wopt=VarCovar^-1;
% disp('Second round with the optimal matrix...')
% iter=0;
% for i=1:p.Steps
%       paramgs=f.GridT(i);
%       f.Jgs0(i)=inference(paramgs,p,v,d,f.Wopt);
%       iter=iter+1;
%       display(iter)
% end
% %    
% [f.Jopt0,f.idT0] = min(f.Jgs0(:));
% f.chiTopt0=f.GridT(f.idT0);
%
f.ST=p.Ntime*p.Get/(1+p.Get)*f.Jopt0;
f.Jchi2_0=1-chi2cdf(f.ST,1);
end