function se=standarderrors(y,Mo,param,p)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the standard errors of parameters estimated by GMM
%---------------------------------------------------------------------------------------------------------------------------
    G=gfun(Mo,param,p.usedmom);
    PHI=phifun(y,Mo,param,p.usedmom);
    [N,~]=size(y);

    varcovar=1/N.*(inv(G'*p.w*G)*(G'*p.w*PHI*p.w*G)*inv(G'*p.w*G));
    se=(diag(varcovar).^0.5)';
%---------------------------------------------------------------------------------------------------------------------------