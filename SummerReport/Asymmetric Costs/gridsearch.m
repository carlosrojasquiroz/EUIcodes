function f=gridsearch(p,v,d)
f.GridT=linspace(p.LowBoundT,p.UpBoundT,p.Steps);
f.GridN=linspace(p.LowBoundN,p.UpBoundN,p.Steps);
%--------------------------------------------------------------------------------------------------------------------------
disp('I start the algorithm of...')
if p.moment==1
    disp('Simulated Method of Moments')
else
    disp('Indirect inference')
end
iter=0;
for i=1:p.Steps
     for j=1:p.Steps
            paramgs=[f.GridT(i) f.GridN(j)];
            f.Jgs0(i,j)=inference(paramgs,p,v,d);
            iter=iter+1;
            display(iter)
     end
end
%    
[f.Jopt0,idAux] = min(f.Jgs0(:));
[f.idT0,f.idN0]=ind2sub(size(f.Jgs0),idAux);
f.chiTopt0=f.GridT(f.idT0);
f.chiNopt0=f.GridN(f.idN0);
%--------------------------------------------------------------------------------------------------------------------------
%f.ST=p.Ntime*p.Get/(1+p.Get)*f.Jopt0;
%f.Jchi2_0=1-chi2cdf(f.ST,0);
end