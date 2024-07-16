function u=utility(p,c,hT,hN)
cNeg=(c-(hT.^p.omegaT)/p.omegaT-(hN.^p.omegaN)/p.omegaN<=0);
u = ((c-(hT.^p.omegaT)/p.omegaT-(hN.^p.omegaN)/p.omegaN).^(1-p.sigma)-1)./ (1-p.sigma);
u(cNeg)=-Inf;
end
