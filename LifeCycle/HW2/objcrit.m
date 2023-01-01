function J=objcrit(y,Mo,param,w,Itot)
%---------------------------------------------------------------------------------------------------------------------------
% This function computes the objective criterion
%---------------------------------------------------------------------------------------------------------------------------
if Itot==2
    if Mo(1)==1
        A1=mean(y)-param(1)/param(2);
    elseif Mo(1)==2
        A1=mean(y.^2)-param(1)*(param(1)+1)/(param(2)^2);
    elseif Mo(1)==3
        A1=mean(log(y))-psi(param(1))+log(param(2));
    elseif Mo(1)==4
        A1=mean((y.^-1))-param(2)/(param(1)-1);
    end
    if Mo(2)==1
        A2=mean(y)-param(1)/param(2);
    elseif Mo(2)==2
        A2=mean(y.^2)-param(1)*(param(1)+1)/(param(2)^2);
    elseif Mo(2)==3
        A2=mean(log(y))-psi(param(1))+log(param(2));
    elseif Mo(2)==4
        A2=mean((y.^-1))-param(2)/(param(1)-1);
    end
    A=[A1 A2];
    J=A*w*A';
elseif Itot==4
    A1=mean(y)-param(1)/param(2);
    A2=mean(y.^2)-param(1)*(param(1)+1)/(param(2)^2);
    A3=mean(log(y))-psi(param(1))+log(param(2));
    A4=mean((y.^-1))-param(2)/(param(1)-1);
    A=[A1 A2 A3 A4];
    J=A*w*A';
end
%---------------------------------------------------------------------------------------------------------------------------