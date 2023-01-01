function standerr=inferenceopt(d,p,o)
%---------------------------------------------------------------------------------------------------------------------------
% This function calculates the standard errors of GMM parameters using an
% optimal weighting matrix
%---------------------------------------------------------------------------------------------------------------------------
if p.usedmom==2
    standerr=zeros(p.R,p.usedmom);
    for ii=1:p.R
        Mo(1)=p.comb(ii,1);
        Mo(2)=p.comb(ii,2);
        param(1)=o.param2(ii,1);
        param(2)=o.param2(ii,2);
        p.w=o.wopt(:,:,ii);
        standerr(ii,:)=standarderrors(d.y,Mo,param,p);
    end
elseif p.usedmom==4
    Mo=zeros(1,2);
    param(1)=o.param2(1);
    param(2)=o.param2(2);
    p.w=o.wopt;
    standerr=standarderrors(d.y,Mo,param,p);
end
%---------------------------------------------------------------------------------------------------------------------------