function beta=estimation(p,r)
betayT=zeros(1,2*p.Nhorz+1);
betayN=zeros(1,2*p.Nhorz+1);
for i=1:p.Get
    % Tradable
    [~,SyT2]=hpfilter(log(r.yT(i,:)),p.lambdaHP);
    [beta1,~]=Obstfeld_Gourinchas(SyT2,r.def(i,:)',p.Nhorz);
    betayT(i,:)=beta1(2,:);
    % Nontradable
    [~,SyN2]=hpfilter(log(r.yN(i,:)),p.lambdaHP);
    [beta2,~]=Obstfeld_Gourinchas(SyN2,r.def(i,:)',p.Nhorz);
    betayN(i,:)=beta2(2,:);
end
betaAverageT=zeros(1,2*p.Nhorz+1);
betaAverageN=zeros(1,2*p.Nhorz+1);
for j=1:2*p.Nhorz+1
    betaAverageT(1,j)=mean(betayT(:,j),'omitnan');
    betaAverageN(1,j)=mean(betayN(:,j),'omitnan');
end
iD=linspace(9,1,9);
beta=[betaAverageT(iD);  betaAverageN(iD)];
%---------------------------------------------------------------------------------------------------------------------------
end