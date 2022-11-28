function [K,w]=firms(p)
%-------------------------------------------------------------------------------------------
% Aggregate capital
%-------------------------------------------------------------------------------------------
    K=((p.rg+p.delta)./(p.alpha*p.A)).^(1/(p.alpha-1))*p.L;
%-------------------------------------------------------------------------------------------
% Wages
%-------------------------------------------------------------------------------------------
    w=(1-p.alpha)*p.A.*(K./p.L).^p.alpha;
end