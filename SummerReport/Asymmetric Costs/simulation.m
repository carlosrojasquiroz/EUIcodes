function r=simulation(p,v)
%---------------------------------------------------------------------------------------------------------------------------
% Initial indices
%---------------------------------------------------------------------------------------------------------------------------
Ind_z=zeros(1,p.burning+p.Ntime+1);
Ind_b=zeros(1,p.burning+p.Ntime+1);
%---------------------------------------------------------------------------------------------------------------------------
% Allocate and fill output
%---------------------------------------------------------------------------------------------------------------------------
Rdef=zeros(p.Get,p.Ntime);
Rstatus=zeros(p.Get,p.Ntime);
RyT=zeros(p.Get,p.Ntime);
RyN=zeros(p.Get,p.Ntime);
Rspread=zeros(p.Get,p.Ntime);
Rc=zeros(p.Get,p.Ntime);
RcN=zeros(p.Get,p.Ntime);
RcT=zeros(p.Get,p.Ntime);
Rrer=zeros(p.Get,p.Ntime);
RnX=zeros(p.Get,p.Ntime);
RpN=zeros(p.Get,p.Ntime);
RB=zeros(p.Get,p.Ntime);
RBprime=zeros(p.Get,p.Ntime);
%---------------------------------------------------------------------------------------------------------------------------
% Simulation (following QuantEcon example)
%---------------------------------------------------------------------------------------------------------------------------
n=0;
while n<p.Get
    Ind_z(1)=randi(p.Nz);
    Ind_b(1)=randi(p.Nb);
    SyT=zeros(1,p.burning+p.Ntime+1);
    SyN=zeros(1,p.burning+p.Ntime+1);
    Sdebt=zeros(1,p.burning+p.Ntime+1);
    Sq=zeros(1,p.burning+p.Ntime+1);
    Sspread=zeros(1,p.burning+p.Ntime+1);
    Sc=zeros(1,p.burning+p.Ntime+1);
    ScN=zeros(1,p.burning+p.Ntime+1);
    ScT=zeros(1,p.burning+p.Ntime+1);
    SpN=zeros(1,p.burning+p.Ntime+1);
    SpC=zeros(1,p.burning+p.Ntime+1);
    Srer=zeros(1,p.burning+p.Ntime+1);
    SnX=zeros(1,p.burning+p.Ntime+1);
    default_today=zeros(1,p.burning+p.Ntime+1);
    default_status=zeros(1,p.burning+p.Ntime+1);    
        for t=1:p.burning+p.Ntime
            zi = Ind_z(t);
            bi = Ind_b(t);
            defstat = default_status(t);
            if defstat==0
                default_today(t)=v.idD(bi,zi);
                    if default_today(t)==1
                        default_status(t) = 1;
                        default_status(t+1) = 1;
                        [Sc(t),SyT(t),SyN(t),~,~] = cdefault(v.z(Ind_z(t)),p);                  
                        Ind_b(t+1) = p.zero_ind;
                        Sdebt(t) = 0;
                        Sq(t) = v.q(p.zero_ind,Ind_z(t));
                        ScN(t) = SyN(t);
                        ScT(t) = SyT(t);
                        SpN(t) = p.theta/(1-p.theta)*(ScN(t)/ScT(t))^(-1/p.eta);
                        SpC(t) = ((1-p.theta)+p.theta*SpN(t)^(1-p.eta))^(1/(1-p.eta));
                        Srer(t) = 1/SpC(t);
                        SnX(t) = 1 - (ScT(t) + SpN(t)*ScN(t))/(SyT(t) + SpN(t)*SyN(t));                        
                    else
                        default_status(t) = 0;
                        [SyT(t),SyN(t),~,~] = production(v.z(Ind_z(t)),p);
                        Ind_b(t+1) = v.idB(bi,zi);
                        Sdebt(t+1) = v.b(Ind_b(t+1));
                        Sq(t) = v.q(Ind_b(t+1),Ind_z(t));
                        ScN(t) = SyN(t);
                        ScT(t) = SyT(t)-Sdebt(t+1)*Sq(t)+Sdebt(t);
                        Sc(t) = ((1-p.theta).*ScT(t).^((p.eta-1)/p.eta)+p.theta.*ScN(t).^((p.eta-1)/p.eta)).^(p.eta/(p.eta-1));
                        SpN(t) = p.theta/(1-p.theta)*(ScN(t)/ScT(t))^(-1/p.eta);
                        SpC(t) = ((1-p.theta)+p.theta*SpN(t)^(1-p.eta))^(1/(1-p.eta));
                        Srer(t) = 1/SpC(t);
                        SnX(t) = 1 - (ScT(t) + SpN(t)*ScN(t))/(SyT(t) + SpN(t)*SyN(t));                        
                    end
            else
                Ind_b(t+1) = p.zero_ind;
                Sdebt(t+1)=v.b(Ind_b(t+1));
                [Sc(t),SyT(t),SyN(t),~,~] = cdefault(v.z(Ind_z(t)),p);
                Sq(t+1) = v.q(p.zero_ind,Ind_z(t));
                ScN(t) = SyN(t);
                ScT(t) = SyT(t);
                SpN(t) = p.theta/(1-p.theta)*(ScN(t)/ScT(t))^(-1/p.eta);
                SpC(t) = ((1-p.theta)+p.theta*SpN(t)^(1-p.eta))^(1/(1-p.eta));
                Srer(t) = 1/SpC(t);
                SnX(t) = 1 - (ScT(t) + SpN(t)*ScN(t))/(SyT(t) + SpN(t)*SyN(t));                
                default_status(t+1) = (rand >= p.lambda);
            end
            Sspread(t)=Sq(t).^-1 - p.R;
            Cy=cumsummat(v.Pz(Ind_z(t),:));
            Ind_z(t+1)=find(Cy>=rand,1);    
        end
%---------------------------------------------------------------------------------------------------------------------------
% Saving only the simulations with at least one default event
%---------------------------------------------------------------------------------------------------------------------------
    if sum(default_today(p.burning+1:end-1))>0
        n=n+1;     
        Rdef(n,:)=default_today(p.burning+1:end-1);
        Rstatus(n,:)=default_status(p.burning+1:end-1);
        RyT(n,:)=SyT(p.burning+1:end-1);
        RyN(n,:)=SyN(p.burning+1:end-1);
        Rspread(n,:)=Sspread(p.burning+1:end-1);
        Rc(n,:)=Sc(p.burning+1:end-1);
        RcN(n,:)=ScN(p.burning+1:end-1);
        RcT(n,:)=ScT(p.burning+1:end-1);
        Rrer(n,:)=Srer(p.burning+1:end-1);
        RnX(n,:)=SnX(p.burning+1:end-1);    
        RpN(n,:)=SpN(p.burning+1:end-1);
        RBprime(n,:)=Sdebt(p.burning+2:end);
        RB(n,:)=Sdebt(p.burning+1:end-1);
    end
end
r.def=Rdef;
r.status=Rstatus;
r.yT=RyT;
r.yN=RyN;
r.spread=Rspread;
r.c=Rc;
r.cT=RcT;
r.cN=RcN;
r.rer=Rrer;
r.nX=RnX;
r.pN=RpN;
r.B=RB;
r.Bprime=RBprime;
%---------------------------------------------------------------------------------------------------------------------------
end