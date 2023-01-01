function standerr=inference(d,p,r)
%---------------------------------------------------------------------------------------------------------------------------
% This function calculates the standard errors of GMM parameters
%---------------------------------------------------------------------------------------------------------------------------
if p.usedmom==2
    standerr=zeros(p.R,p.usedmom);
    for ii=1:p.R
        Mo(1)=p.comb(ii,1);
        Mo(2)=p.comb(ii,2);
        param(1)=r.param2(ii,1);
        param(2)=r.param2(ii,2);
        standerr(ii,:)=standarderrors(d.y,Mo,param,p);
    end
elseif p.usedmom==4
    Mo=zeros(1,2);
    param(1)=r.param2(1);
    param(2)=r.param2(2);
    standerr=standarderrors(d.y,Mo,param,p);
end
%---------------------------------------------------------------------------------------------------------------------------