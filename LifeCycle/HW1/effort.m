function [e,P]=effort(p,m)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the labor effort per age j
%---------------------------------------------------------------------------------------------------------------------------
e=zeros(p.J,p.nzz);
P=zeros(p.J,1);
for d_1=1:p.JR-1
    P(d_1,1)=(p.lambda0+p.lambda1*d_1+p.lambda2*d_1^2);
    e(d_1,:)=m.z_grid.*P(d_1);
end
%---------------------------------------------------------------------------------------------------------------------------