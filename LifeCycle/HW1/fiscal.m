function [theta,b]=fiscal(p,m)
    theta=p.omega*sum(m.Psi(p.JR:p.J))/sum(m.Psi(1:p.JR-1));
    b_aux=theta*p.w*p.L./sum(m.Psi(p.JR:p.J));
    b=zeros(p.J,1);
    b(p.JR:p.J,1)=ones(p.J-p.JR+1,1).*b_aux;
end