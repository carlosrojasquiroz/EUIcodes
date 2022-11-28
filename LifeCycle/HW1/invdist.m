function muJ=invdist(nzz,Pz)
muAux=ones(1,nzz)./nzz;
err=1;
tol=1e-6;
    while err>tol
        muJ=muAux*Pz;
        err=max(abs(muJ-muAux));
        muAux=muJ;
    end
end