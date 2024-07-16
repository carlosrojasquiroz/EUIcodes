function [Betahat, DeBeta, DeReg, RsquareAdj] = OLS(Y,X,D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Running a simple ordinary least squares estimation with some interesting indicators 
% (c) Carlos Rojas Quiroz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Betahat, DeBeta, RSS] = ols(Y,X,D,Alpha)
% Inputs:
%       X = Vector with the endogenous variable
%       Y = Matrix with exogenous variables
%       D = Binary variable. If D = 1, run the regression with a constant
% Outputs:
%       Betahat = Regression coefficients 
%       DeBeta = Coefficients' standard errors
%       DeReg = Regression's standard error
%       RsquareAdj = Adjusted R^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if D==1
        C=ones(length(Y(:,1)),1);
        X=[X C];
    else
        X=X;
    end
    Betahat=inv(X'*X)*(X'*Y);
    n=length(Y(:,1));
    Yhat=X*Betahat;
    u=Y-Yhat;
    k=numel(Betahat);
    RSS=u*u';
    VarBeta=n.*(X'*X)^(-1)*(1/(n-k).*X'*(diag(RSS).*X))*(X'*X)^(-1);
    DeBeta=diag(VarBeta).^.5;    
    Ybar=mean(Y);
    RsquareAdj=1-(u'*u/(n-k))/((Y-repmat(Ybar,n,1))'* ...  
    (Y-repmat(Ybar,n,1))/(n-1));
    DeReg=sqrt(1-RsquareAdj)*std(Y);
end