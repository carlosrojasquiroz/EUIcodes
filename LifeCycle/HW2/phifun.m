function PHI=phifun(y,Mo,param,Itot)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the covariance matrix of the moments
%---------------------------------------------------------------------------------------------------------------------------
if Itot==2
    if Mo(1)==1
        M1=y-param(1)/param(2);
    elseif Mo(1)==2
        M1=y.^2-param(1)*(param(1)+1)/(param(2)^2);
    elseif Mo(1)==3
        M1=log(y)-psi(param(1))+log(param(2));
    elseif Mo(1)==4
        M1=(y.^-1)-param(2)/(param(1)-1);
    end
    if Mo(2)==1
        M2=y-param(1)/param(2);
    elseif Mo(2)==2
        M2=y.^2-param(1)*(param(1)+1)/(param(2)^2);
    elseif Mo(2)==3
        M2=log(y)-psi(param(1))+log(param(2));
    elseif Mo(2)==4
        M2=(y.^-1)-param(2)/(param(1)-1);
    end  
    PHI=[mean(M1.^2) mean(M1.*M2);
            mean(M2.*M1) mean(M2.^2)];
elseif Itot==4
    M1=y-param(1)/param(2);
    M2=y.^2-param(1)*(param(1)+1)/(param(2)^2);
    M3=log(y)-psi(param(1))+log(param(2));
    M4=(y.^-1)-param(2)/(param(1)-1);
    PHI=[mean(M1.^2) mean(M1.*M2) mean(M1.*M3) mean(M1.*M4);
            mean(M2.*M1) mean(M2.^2) mean(M2.*M3) mean(M2.*M4);
            mean(M3.*M1) mean(M3.*M2) mean(M3.^2) mean(M3.*M4);
            mean(M4.*M1) mean(M4.*M2) mean(M4.*M3) mean(M4.^2);];
end
%---------------------------------------------------------------------------------------------------------------------------