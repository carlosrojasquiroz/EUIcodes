function [W,pvalue]=hypothesistesting(p,smm,smm0)
D=[smm.chiTss0-smm0.chiTss0 smm.chiNss0-smm0.chiNss0];
W=p.Ntime*D*(smm.Qs^-1)*D';
pvalue=1-chi2cdf(W,2);
end