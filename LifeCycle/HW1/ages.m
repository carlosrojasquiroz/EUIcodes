function [J,Psi]=ages(p,m)
    J=length(m.Sj);
    Psi=ones(J,1);
    %Psi(1,1)=p.N0*(1+p.n);
        %for ii=2:J
         %   Psi(ii,1)=m.Sj(ii-1,1)*Psi(ii-1,1)/(1+p.n);
        %end
     Ms=cumprod(m.Sj);
     Gn=(1+p.n).^(0:J);
        for ii=1:J
            Psi(ii,1)=Ms(ii,1)*Gn(J-ii+1);
        end
    Psi=Psi./sum(Psi);
end