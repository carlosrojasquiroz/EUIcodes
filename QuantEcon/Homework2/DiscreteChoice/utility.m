function u=utility(c,sigma)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the utility of a vector of consumption points, c_aux. 
% The utility form is the CRRA.
%---------------------------------------------------------------------------------------------------------------------------
IndNeg=(c<=0);
c(IndNeg)=0;
if sigma==1
    u=log(c);
else
    u=(c.^(1-sigma)-1)./(1-sigma);
end
%---------------------------------------------------------------------------------------------------------------------------