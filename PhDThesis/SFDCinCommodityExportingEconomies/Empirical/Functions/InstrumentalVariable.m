function iv=InstrumentalVariable(p,d,s,shock)
%---------------------------------------------------------------------------------
% 1. Instrument sample (range has to be contained in estimation sample)
%---------------------------------------------------------------------------------
StartProxy = p.smplStart + calmonths(p.pLag);
StartProxy.Format = 'MMM-yyyy';
EndProxy = p.smplEnd;
if strcmp(shock,'Baumeister')
   EndProxy = p.smplEndEProxy;
end
EndProxy.Format = 'MMM-yyyy';
smplProxy = StartProxy:calmonths(1):EndProxy;
smplProxy = smplProxy';
iv.smplProxy = smplProxy;
iv.Flag = shock;
%---------------------------------------------------------------------------------
% 2. Loading data
%---------------------------------------------------------------------------------
% Number of variables
nvar = size(d.data,2);  
% Select sample
data = table2array(d.data);
if strcmp(shock,'Baumeister')
   smplaux= p.smplStart:calmonths(1):EndProxy;
   data = table2array(d.data(smplaux,:));
end
dataExo = ones(size(data,1),1);
%---------------------------------------------------------------------------------
% 3. First stage regression
%---------------------------------------------------------------------------------
% Oil proxies
if strcmp(shock,'Kanzig')   
    proxyRaw = [s.K.COMP(smplProxy,1)]; 
elseif strcmp(shock,'Baumeister')
    proxyRaw = [s.B.COMP(smplProxy,1)];
end
[T,C] = size(proxyRaw);
iv.C = C;
iv.Proxy = proxyRaw;
% Run reduced-form VAR 
iv.varEst = varxest(data,dataExo,p.pLag);
nexo = size(dataExo,2);
% Collecting residuals  
U = iv.varEst.U;    
Sigma = U'*U/(T-p.pLag*nvar-nexo);
iv.Sigma = Sigma;
% Run first stage
iv.ols = olsest(proxyRaw,U(:,1),p.Cons,true);
if strcmp(shock,'Kanzig')   
    disp('Oil supply news shock')
elseif strcmp(shock,'Baumeister')
    disp('Expectations by asset price approach')
end
fprintf('F-stat: %4.3f, F-stat (robust): %4.3f, R^2: %4.3f, R^2 (adj): %4.3f \n',...
iv.ols.F,iv.ols.Frobust,iv.ols.R2,iv.ols.R2adj)
iv.uhat = iv.ols.yhat;
%---------------------------------------------------------------------------------
% 4. Second stage regression
%---------------------------------------------------------------------------------
% Index of variable(s) to be instrumented
k = 1;
% Second stage
b21ib11_2SLS    =   [ones(length(proxyRaw),1) iv.uhat]\U(:,k+1:end);  
b21ib11 = b21ib11_2SLS(2:end,:)';         
Sig11   = Sigma(1:k,1:k);
Sig21   = Sigma(k+1:nvar,1:k);
Sig22   = Sigma(k+1:nvar,k+1:nvar);
ZZp     = b21ib11*Sig11*b21ib11'-(Sig21*b21ib11'+b21ib11*Sig21')+Sig22;
b12b12p = (Sig21- b21ib11*Sig11)'*(ZZp\(Sig21- b21ib11*Sig11));
b11b11p = Sig11-b12b12p;
b11     = sqrt(b11b11p);
iv.b1      = [b11; b21ib11*b11];
iv.b1unit  = [1; b21ib11]*p.ShockSize;
%---------------------------------------------------------------------------------
% 5. Shock as in Stock and Watson (2018)
%---------------------------------------------------------------------------------
if strcmp(p.ShockType,'custom')
    % Unit normalization
    iv.structuralshock = (iv.b1unit'*inv2(Sigma)*U')'*inv2(iv.b1unit'*...
        inv2(Sigma)*iv.b1unit);
else
    % One stdev normalization
    iv.structuralshock = (iv.b1'*inv2(Sigma)*U')'*1; 
end
iv.Shock = array2timetable(iv.structuralshock,'RowTimes',iv.smplProxy,'VariableNames', ...
    {'SHOCK'});
%---------------------------------------------------------------------------------
% 6. Figure
%---------------------------------------------------------------------------------
if p.showFigs
    figure('DefaultAxesFontSize',13);
else
    figure('DefaultAxesFontSize',13,'visible','off');
end    
hold on
plot(iv.smplProxy,iv.structuralshock)
ylabel('Structural expectational oil price shocks (\%)')
line(get(gca,'xlim'),[0 0],'Color','k')
grid on
box on
if p.saveFigs
    if strcmp(shock,'Kanzig')
        saveas(gcf,'Figures\Kanzig_SS','epsc2')
    elseif strcmp(shock,'Baumeister')
        saveas(gcf,'Figures\Baumeister_SS','epsc2')
    end
end
%---------------------------------------------------------------------------------