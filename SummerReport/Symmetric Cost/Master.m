%---------------------------------------------------------------------------------------------------------------------------
% Simulated Method of Moments
%---------------------------------------------------------------------------------------------------------------------------
p.Steps=151;
p.moment=1;
% First step: grid search
smm0=gridsearch(p,v,d);
% Second step: solver
[smm0.chiTss0,smm0.chiNss0,smm0.Jss0]=solversearch(p,v,d,smm0);
% Standard errors
smm0.Qs=standarderrors(p,d,v,smm0);
%---------------------------------------------------------------------------------------------------------------------------
% Indirect inference
%---------------------------------------------------------------------------------------------------------------------------
p.moment=0;
% First step: grid search
ii0=gridsearch(p,v,d);
% Second step: solver
[ii0.chiTss0,ii0.chiNss0,ii0.Jss0]=solversearch(p,v,d,ii0);
% Standard errors
ii0.Qs=standarderrors(p,d,v,ii0);
%---------------------------------------------------------------------------------------------------------------------------
% sim=figureresults(p,d,v,f,frcsim);