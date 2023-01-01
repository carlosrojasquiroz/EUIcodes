function G=gfun(Mo,param,Itot)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the vector of partial derivatives
%---------------------------------------------------------------------------------------------------------------------------
if Itot==2
    if Mo(1)==1
        G1=[-1/param(2) param(1)/(param(2)^2)];
    elseif Mo(1)==2
        G1=[-(2*param(1)+1)/(param(2)^2) 2*param(1)*(param(1)+1)/(param(2)^3)];
    elseif Mo(1)==3
        G1=[-psi(1,param(1)) 1/param(2)];
    elseif Mo(1)==4
        G1=[param(2)/((param(1)-1)^2) -1/(param(1)-1)];
    end
    if Mo(2)==1
        G2=[-1/param(2) param(1)/(param(2)^2)];
    elseif Mo(2)==2
        G2=[-(2*param(1)+1)/(param(2)^2) 2*param(1)*(param(1)+1)/(param(2)^3)];
    elseif Mo(2)==3
        G2=[-psi(1,param(1)) 1/param(2)];
    elseif Mo(2)==4
        G2=[param(2)/((param(1)-1)^2) -1/(param(1)-1)];
    end
    G=[G1; G2];
elseif Itot==4
    G1=[-1/param(2) param(1)/(param(2)^2)];
    G2=[-(2*param(1)+1)/(param(2)^2) 2*param(1)*(param(1)+1)/(param(2)^3)];
    G3=[-psi(1,param(1)) 1/param(2)];
    G4=[param(2)/((param(1)-1)^2) -1/(param(1)-1)];
    G=[G1; G2; G3; G4];
end
%---------------------------------------------------------------------------------------------------------------------------