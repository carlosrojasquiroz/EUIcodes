function [chiTss0,chiNss0,Jss0]=solversearch(p,v,d,ii)
%
fun = @(param) inference(param,p,v,d);
x0 = [ii.chiTopt0,ii.chiNopt0];
[chiss0,Jss0] = fminsearch(fun,x0);
%
chiTss0=chiss0(1);
chiNss0=chiss0(2);
end