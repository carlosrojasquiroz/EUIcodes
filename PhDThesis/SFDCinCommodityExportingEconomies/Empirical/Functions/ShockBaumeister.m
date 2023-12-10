function shock=ShockBaumeister(p,type)
%---------------------------------------------------------------------------------
% This function estimates expectational shocks. Shocks are stored in structure "e".
%---------------------------------------------------------------------------------
% 1. Load expectations series
%---------------------------------------------------------------------------------
ex = readtimetable('DataBase.xlsx','Sheet','OILEXPECTATIONS','Range','A2:E449');
ex.MONTH.Format = 'MMM-yyyy';
%---------------------------------------------------------------------------------
% 2. Load oil WTI prices
%---------------------------------------------------------------------------------
wti = readtimetable('DataBase.xlsx','Sheet','OILPRICES','Range','A2:B767');
%---------------------------------------------------------------------------------
% 3. Construct surprises
%---------------------------------------------------------------------------------
% First differences
if strcmp(type,'first')   
    ex.Variables = 100*log(ex.Variables);
    deltaDay = diff(ex);
    deltaDay.MONTH = ex.MONTH(2:end);
elseif strcmp(type,'basis')
    smpl = ex.MONTH(1):calmonths(1):ex.MONTH(end);
    price = wti.WTI(smpl);
    expec = table2array(ex);
    deltaDay = log(expec./price)*100;
    deltaDay = array2timetable(deltaDay,"RowTimes",smpl);
end
% Complete the matrix
oo = fillmissing(deltaDay,'constant',0);
%---------------------------------------------------------------------------------
% 4. Principal component analysis
%---------------------------------------------------------------------------------
proxySel =table2array(oo(:,1:end));
[~,score,~,~,~] = pca(zscore(proxySel));
oilPC = score(:,1);
oilPC =oilPC./std(oilPC)*mean(std(proxySel));
% Collect PC
oilProxy= addvars(oo, oilPC,'NewVariableNames', 'COMP');
% Dates
months = p.smplStart:calmonths(1):p.smplEndEProxy;
months.Format = 'MMM-yyyy';
months = months';
% Create a new timetable with extended dates
oilProxy = retime(oilProxy, months, 'fillwithconstant');
%---------------------------------------------------------------------------------
% 5. Work on the proxy (instrumental) variable 
%---------------------------------------------------------------------------------
proxyRaw = [oilProxy(:,end)]; 
%---------------------------------------------------------------------------------
% 6. Figure
%---------------------------------------------------------------------------------
if p.showFigs
    figure('DefaultAxesFontSize',13);
else
    figure('DefaultAxesFontSize',13,'visible','off');
end       
hold on
TimeInterval=p.smplStartEProxy:calmonths(1):p.smplEndEProxy;
varEx=proxyRaw.COMP(TimeInterval);
plot(TimeInterval,varEx)
if strcmp(type,'first')
    varEx=proxyRaw(TimeInterval,"COMP");
    TimePoints = {'Aug-1986','Aug-1990','Feb-1991','Jan-2005','Oct-2008','Dec-2014',...
        'May-2020'};
    TimePoints = datetime(TimePoints);
    TimePoints.Format = 'MMM-yyyy';
    plot(TimePoints,varEx.COMP(TimePoints),'ro')
    % Expected lower supply by OPEC restriction
    text(TimeInterval(TimeInterval=='Aug-1986'),varEx.COMP(TimeInterval=='Aug-1986')+1,...
        'Aug-1986','fontsize',11)
    % Start Gulf War
    text(TimeInterval(TimeInterval=='Aug-1990'),varEx.COMP(TimeInterval=='Aug-1990')+1,...
        'Aug-1990','fontsize',11)
    % End Gulf War
    text(TimeInterval(TimeInterval=='Feb-1991'),varEx.COMP(TimeInterval=='Feb-1991')-1,...
        'Feb-1991','fontsize',11)
    % Expected lower supply by outages  in NOR, NIG, IRQ, MEX
    text(TimeInterval(TimeInterval=='Jan-2005'),varEx.COMP(TimeInterval=='Jan-2005')+1,...
        'Jan-2005','fontsize',11)
    % Expected lower demand by the global financial crisis
    text(TimeInterval(TimeInterval=='Oct-2008'),varEx.COMP(TimeInterval=='Oct-2008')-1,...
        'Oct-2008','fontsize',11)
    % Expected lower demand by EU, JPN, CHN
    text(TimeInterval(TimeInterval=='Dec-2014'),varEx.COMP(TimeInterval=='Dec-2014')-1,...
        'Dec-2014','fontsize',11)
    % Expected lower supply by OPEC restriction
    text(TimeInterval(TimeInterval=='May-2020'),varEx.COMP(TimeInterval=='May-2020')+1,...
        'May-2020','fontsize',11)
    ylabel('Variation in oil price expectations (\%)')
elseif strcmp(type,'basis')
    varEx=proxyRaw(TimeInterval,"COMP");
    TimePoints = {'Jun-1990','Oct-1990','Jun-1998','Jul-2008','Jul-2014','Feb-2016','Apr-2020',...
        'Jun-2022'};
    TimePoints = datetime(TimePoints);
    TimePoints.Format = 'MMM-yyyy';
    plot(TimePoints,varEx.COMP(TimePoints),'ro')
    % Start Gulf War
    text(TimeInterval(TimeInterval=='Jun-1990'),varEx.COMP(TimeInterval=='Jun-1990')+1,...
        'Jun-1990','fontsize',11)
    % End Gulf War
    text(TimeInterval(TimeInterval=='Oct-1990'),varEx.COMP(TimeInterval=='Oct-1990')-1,...
        'Oct-1990','fontsize',11)
    % Expected lower supply by Asian crisis
    text(TimeInterval(TimeInterval=='Jun-1998'),varEx.COMP(TimeInterval=='Jun-1998')+1,...
        'Jun-1998','fontsize',11)
    % Expected lower demand by the global financial crisis
    text(TimeInterval(TimeInterval=='Jul-2008'),varEx.COMP(TimeInterval=='Jul-2008')-1,...
        'Jul-2008','fontsize',11)
    % Expected lower demand by EU, JPN, CHN
    text(TimeInterval(TimeInterval=='Jul-2014'),varEx.COMP(TimeInterval=='Jul-2014')-1,...
        'Jul-2014','fontsize',11)
    % Expected lower supply by OPEC restriction
    text(TimeInterval(TimeInterval=='Feb-2016'),varEx.COMP(TimeInterval=='Feb-2016')+1,...
        'Feb-2016','fontsize',11)
    % Expected lower supply by OPEC restriction
    text(TimeInterval(TimeInterval=='Apr-2020'),varEx.COMP(TimeInterval=='Apr-2020')+1,...
        'Apr-2020','fontsize',11)
    % Expected lower GLOBAL demand 
    text(TimeInterval(TimeInterval=='Jun-2022'),varEx.COMP(TimeInterval=='Jun-2022')-1,...
        'Jun-2022','fontsize',11)
    ylabel('Oil price basis (\%)')
end
line(get(gca,'xlim'),[0 0],'Color','k')
grid on
box on
if p.saveFigs
    if strcmp(type,'first')  
        saveas(gcf,'Figures\Baumeister_firstproxy','epsc2')
    elseif strcmp(type,'basis')  
        saveas(gcf,'Figures\Baumeister_basisproxy','epsc2')
    end
end
%---------------------------------------------------------------------------------
% 7. Output
%---------------------------------------------------------------------------------
shock = proxyRaw;
%---------------------------------------------------------------------------------