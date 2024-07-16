function Qs=standarderrors(p,d,v,ii)
Delta=p.tol;
p.chi1_T=ii.chiTss0;
p.chi1_N=ii.chiNss0; 
DeltaSimT=estimates(p,v,d);
%---------------------------------------------------------------------------------------------------------------------------
% % Estimation of the auxiliary model given a small change
p.chi1_T=ii.chiTss0+Delta;
p.chi1_N=ii.chiNss0+Delta; 
DeltaSimcT=estimates(p,v,d);
%---------------------------------------------------------------------------------------------------------------------------
Js=([DeltaSimcT'] - [DeltaSimT'])/Delta;
Qs=(1+1/p.Get)*((Js'*ii.W*Js)^-1);
end