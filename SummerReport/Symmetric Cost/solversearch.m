function [chiTss0,chiNss0,Jss0]=solversearch(p,v,d,ii)
%
fun = @(param) inference(param,p,v,d,ii.W);
x0 = ii.chiTopt0;
[chiss0,Jss0] = fminsearch(fun,x0);
%
chiTss0=chiss0;
chiNss0=chiss0;
end