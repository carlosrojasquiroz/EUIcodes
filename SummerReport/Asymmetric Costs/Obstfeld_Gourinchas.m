function [beta,stdevbeta]=Obstfeld_Gourinchas(Y,X,Nhorz)

[T,V]=size(X);
beta=zeros(V+1,2*Nhorz+1);
stdevbeta=zeros(V+1,2*Nhorz+1);

for i=1:Nhorz
    XX=[ones(T-i,1) X(1:end-i,:)];
    YY=Y(1+i:end);
    beta(:,Nhorz+1-i)=(XX'*XX)^(-1)*(XX'*YY);
    %%%%%%%%%%%%%%%%%%%%%%
    n=length(XX(:,1));
    Yhat=XX*beta(:,Nhorz+1-i);
    u=YY-Yhat;
    k=numel(beta(:,Nhorz+1-i));
    RSS=u*u';
    %%%%%%%%%%%%%%%%%%%%%%
    VarBeta=n.*(XX'*XX)^(-1)*(1/(n-k).*XX'*(diag(RSS).*XX))*(XX'*XX)^(-1);
    stdevbeta(:,Nhorz+1-i)=diag(VarBeta).^0.5;
end

    XX=[ones(T,1) X];
    YY=Y(1:end);
    beta(:,Nhorz+1)=(XX'*XX)^(-1)*(XX'*YY);
    %%%%%%%%%%%%%%%%%%%%%%
    n=length(XX(:,1));
    Yhat=XX*beta(:,Nhorz+1);
    u=YY-Yhat;
    k=numel(beta(:,Nhorz+1));
    RSS=u*u';
    %%%%%%%%%%%%%%%%%%%%%%
    VarBeta=n.*(XX'*XX)^(-1)*(1/(n-k).*XX'*(diag(RSS).*XX))*(XX'*XX)^(-1);
    stdevbeta(:,Nhorz+1)=diag(VarBeta).^.5;

for j=1:Nhorz
    XX=[ones(T-j,1) X(1+j:end,:)];
    YY=Y(1:end-j);
    beta(:,Nhorz+j+1)=(XX'*XX)^(-1)*(XX'*YY);
    %%%%%%%%%%%%%%%%%%%%%%
    n=length(XX(:,1));
    Yhat=XX*beta(:,Nhorz+j+1);
    u=YY-Yhat;
    k=numel(beta(:,Nhorz+j+1));
    RSS=u*u';
    %%%%%%%%%%%%%%%%%%%%%%
    VarBeta=n.*(XX'*XX)^(-1)*(1/(n-k).*XX'*(diag(RSS).*XX))*(XX'*XX)^(-1);
    stdevbeta(:,Nhorz+j+1)=diag(VarBeta).^.5;    
end