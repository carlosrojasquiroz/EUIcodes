function u=utility(c_aux,sigma)
    naa=length(c_aux);
        for j=1:naa
            c_aux(j)=max(c_aux(j),0);
        end
        if sigma==1
            u   =   log(c_aux);
        else
            u   =   c_aux.^(1-sigma)./(1-sigma);
        end
end