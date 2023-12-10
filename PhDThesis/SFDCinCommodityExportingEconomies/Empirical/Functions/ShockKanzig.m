function shock=ShockKanzig(p)
%---------------------------------------------------------------------------------
% This function estimates oil surprises shocks. Shocks are stored in structure "s".
%---------------------------------------------------------------------------------
% 1. Load OPEC announcements database
%---------------------------------------------------------------------------------
opec = readtimetable('DataBase.xlsx','Sheet','OPECANNOUNCEMENTS'); 
%---------------------------------------------------------------------------------
% 2. Create variables about OPEC announcements
%---------------------------------------------------------------------------------
statementDates = opec.AnnouncementDay;
statementDates_tradingDays = opec.TradingDay;
%---------------------------------------------------------------------------------
% 3. Load oil futures prices
%---------------------------------------------------------------------------------
foil = readtimetable('DataBase.xlsx','Sheet','OILFUTURES','Range','A2:Y10602'); 
%---------------------------------------------------------------------------------
% 4. Create a matrix with all the futures oil price contracts (100log(x))
%---------------------------------------------------------------------------------
foil.Variables = 100*log(foil.Variables);
%---------------------------------------------------------------------------------
% 5. Compute surprises (do it on selected trading days)
%---------------------------------------------------------------------------------
% First differences
deltaDay = diff(foil);
deltaDay.TIME = foil.TIME(2:end);
deltaDay = deltaDay(:,1:p.ContractMax);
% Complete the matrix
for jj = 1:length(statementDates_tradingDays)
    oo(jj,:) = deltaDay(deltaDay.TIME == statementDates_tradingDays(jj,1),:);
end
oo.TIME = statementDates;
oo = fillmissing(oo,'constant',0);
%---------------------------------------------------------------------------------
% 6. Principal component analysis
%---------------------------------------------------------------------------------
proxySel = table2array(oo(:,2:13));
[~,score,~,~,~] = pca(zscore(proxySel));
oilPC = score(:,1);
oilPC = oilPC./std(oilPC)*mean(std(proxySel));
% Collect PC
oilPCWTI = addvars(oo, oilPC,'NewVariableNames', 'COMP');
% Summing up surprises by month
oilProxyWTI = retime(oilPCWTI, 'monthly', 'sum');
% Dates
months = p.smplStart:calmonths(1):p.smplEnd;
months.Format = 'MMM-yyyy';
months = months';
% Create a new timetable with extended dates
oilProxy = retime(oilProxyWTI, months, 'fillwithconstant');
%---------------------------------------------------------------------------------
% 7. Work on the proxy (instrumental) variable 
%---------------------------------------------------------------------------------
proxyRaw = [oilProxy(:,p.ContractMax+1)]; 
%---------------------------------------------------------------------------------
% 8. Figure
%---------------------------------------------------------------------------------
if p.showFigs
    figure('DefaultAxesFontSize',13);
else
    figure('DefaultAxesFontSize',13,'visible','off');
end    
hold on
TimeInterval=p.smplStartSProxy:calmonths(1):p.smplEndSProxy;
varEx=proxyRaw.COMP(TimeInterval);
plot(TimeInterval,varEx)
plot(proxyRaw.TIME(abs(proxyRaw.COMP)>7),proxyRaw.COMP(abs(proxyRaw.COMP)>7),'ro')
varEx=proxyRaw(TimeInterval,"COMP");
TimePoints = {'Aug-1986','Nov-2001','Nov-2014','Nov-2016','Mar-2020','Jul-2021'};
TimePoints = datetime(TimePoints);
TimePoints.Format = 'MMM-yyyy';
plot(TimePoints,varEx.COMP(TimePoints),'ro')
ylim([-15 15]);
% OPEC agreement on new production quotas
text(proxyRaw.TIME('Aug-1986'),varEx.COMP(TimeInterval=='Aug-1986')+1,...
    '5 Aug 1986','fontsize',11)
% OPEC supply restriction that can potentially derived in a price war
text(proxyRaw.TIME('Nov-2001'),varEx.COMP(TimeInterval=='Nov-2001')-1,...
    '14 Nov 2001','fontsize',11)
% OPEC announcement on unchanged level production in the amidst of a weak global demand
text(proxyRaw.TIME('Nov-2014'),varEx.COMP(TimeInterval=='Nov-2014')-1,...
    '27 Nov 2014','fontsize',11)
% OPEC agreement on production cuts (also by non-OPEC members like Russia)
text(proxyRaw.TIME('Nov-2016'),varEx.COMP(TimeInterval=='Nov-2016')+1,...
    '30 Nov 2016','fontsize',11)
% Further production adjustments by OPEC do not fit with extremely weak global demand
text(proxyRaw.TIME('Mar-2020'),varEx.COMP(TimeInterval=='Mar-2020')-1,...
    '5 Mar 2020','fontsize',11)
% Expected increase in oil supply by OPEC between Aug-Dec 2021 by 0.4 million bpd per month
text(proxyRaw.TIME('Jul-2021'),varEx.COMP(TimeInterval=='Jul-2021')-1,...
    '5/18 Jul 2021','fontsize',11)
ylabel('Revision in oil price expectations (\%)')
line(get(gca,'xlim'),[0 0],'Color','k')
grid on
box on
if p.saveFigs
    saveas(gcf,'Figures\Kanzig_Proxy','epsc2')
end
%---------------------------------------------------------------------------------
% 9. Output
%---------------------------------------------------------------------------------
proxyRaw.Properties.DimensionNames{1}='MONTH';
shock= proxyRaw;
%---------------------------------------------------------------------------------