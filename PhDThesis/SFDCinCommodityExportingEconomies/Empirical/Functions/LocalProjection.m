function lp = LocalProjection(p,d,iv,variable)
%---------------------------------------------------------------------------------
% 1. Load JP Morgan EMBI+
%---------------------------------------------------------------------------------
embi = readtimetable('DataBase.xlsx','Sheet','EMBI+','range','A4:L361');
embi.MONTH.Format = 'MMM-yyyy';
risk = synchronize(embi,d.EMBIadv);
%---------------------------------------------------------------------------------
% 2. Load Industrial Production
%---------------------------------------------------------------------------------
ip = readtimetable('DataBase.xlsx','Sheet','IPDATA','range','A4:AA768');
ip.MONTH.Format = 'MMM-yyyy';
ip = log(ip).*100;
%---------------------------------------------------------------------------------
% 3. Load Real Exchange Rate
%---------------------------------------------------------------------------------
rer = readtimetable('DataBase.xlsx','Sheet','RERDATA','range','A4:X540');
rer.MONTH.Format = 'MMM-yyyy';
rer = log(rer).*100;
%---------------------------------------------------------------------------------
% 4. Load VIX
%---------------------------------------------------------------------------------
vix = readtimetable('DataBase.xlsx','Sheet','VIX','range','A2:B454');
vix.MONTH.Format = 'MMM-yyyy';
%---------------------------------------------------------------------------------
% 5. Load foreign debt  + debt service indicators
%---------------------------------------------------------------------------------
crisk = readtimetable('DataBase.xlsx','Sheet','COUNTRYRISK','range','A3:AI479');
crisk.MONTH.Format = 'MMM-yyyy';
%---------------------------------------------------------------------------------
% 6. Getting the Impulse Response function per country
%---------------------------------------------------------------------------------
Countries = {'BRA','CAN','COL','ECU','IDN','KAZ','MYS','MEX','NGA','NOR','RUS','VEN'};
CountriesName = {'Brazil','Canada','Colombia','Ecuador','Indonesia','Kazakhstan','Malaysia',...
    'Mexico','Nigeria','Norway','Russia','Venezuela'};
lp.Countries = Countries;
lp.CountriesName = CountriesName;
%---------------------------------------------------------------------------------
% 7.1 Estimation by country
%---------------------------------------------------------------------------------
if strcmp(iv.Flag,'Baumeister')
    p.smplEnd=p.smplEndEProxy;
end
for jj = 1 : length(Countries)
    %-------------------------------------------------------------------------------
    % 7.1.1 Risk variable - indices
    %-------------------------------------------------------------------------------
    RISKCODE = strcat('EMBI',Countries{jj});
    firstRISK = find(~isnan(risk.(RISKCODE)), 1);
    lastRISK = firstRISK - 2 + find(isnan(risk.(RISKCODE)(firstRISK:end)),1,'first');
    if isempty(lastRISK) || risk.MONTH(lastRISK) > p.smplEnd
        lastRISK = find(risk.MONTH==p.smplEnd);
    end
    %-------------------------------------------------------------------------------
    % 7.1.2 Industrial production - indices
    %-------------------------------------------------------------------------------
    IPCODE = strcat('IPOECD',Countries{jj});
    if strcmp(Countries{jj}, 'ECU') || strcmp(Countries{jj}, 'MYS') || strcmp(Countries{jj}, 'VEN') || ...
            strcmp(Countries{jj}, 'EGY') || strcmp(Countries{jj}, 'KAZ') || strcmp(Countries{jj}, 'IDN')
        IPCODE = strcat('IPWB',Countries{jj});
    elseif strcmp(Countries{jj}, 'NGA')
        IPCODE = strcat('ICRG',Countries{jj});
    end
    firstIP = find(~isnan(ip.(IPCODE)), 1);
    lastIP = firstIP - 2 + find(isnan(ip.(IPCODE)(firstIP:end)),1,'first');
    if isempty(lastIP) || ip.MONTH(lastIP) > p.smplEnd
        lastIP = find(ip.MONTH==p.smplEnd);
    end 
    %-------------------------------------------------------------------------------
    % 7.1.3 Real exchange rate - indices
    %-------------------------------------------------------------------------------
    RERCODE = strcat('RERIMF',Countries{jj});
    if strcmp(Countries{jj}, 'ECU') || strcmp(Countries{jj}, 'VEN') || strcmp(Countries{jj}, 'KAZ') || ...
            strcmp(Countries{jj}, 'NGA') || strcmp(Countries{jj}, 'EGY') || strcmp(Countries{jj}, 'IDN')
        RERCODE = strcat('RERWB',Countries{jj});
    end
    firstRER = find(~isnan(rer.(RERCODE)), 1);
    lastRER = firstRER - 2 + find(isnan(rer.(RERCODE)(firstRER:end)),1,'first');
    if isempty(lastRER) || rer.MONTH(lastRER) > p.smplEnd
        lastRER = find(rer.MONTH==p.smplEnd);
    end
    %-------------------------------------------------------------------------------
    % 7.1.4 VIX - indices
    %-------------------------------------------------------------------------------
    firstVIX = find(~isnan(vix.VIX), 1);
    lastVIX = firstVIX - 2 + find(isnan(vix.VIX(firstVIX:end)),1,'first');
    if isempty(lastVIX) || vix.MONTH(lastVIX) > p.smplEnd
        lastVIX = find(vix.MONTH==p.smplEnd);
    end
    %-------------------------------------------------------------------------------
    % 7.1.5 Foreign debt - indices
    %-------------------------------------------------------------------------------
    FDCODE = strcat('FD',Countries{jj});
    firstFD = find(~isnan(crisk.(FDCODE)), 1);
    lastFD = firstFD - 2 + find(isnan(crisk.(FDCODE)(firstFD:end)),1,'first');
    if isempty(lastFD) || crisk.MONTH(lastFD) > p.smplEnd
        lastFD = find(crisk.MONTH==p.smplEnd);
    end
    %-------------------------------------------------------------------------------
    % 7.1.6 Debt service - indices
    %-------------------------------------------------------------------------------
    DSCODE = strcat('DS',Countries{jj});
    firstDS = find(~isnan(crisk.(DSCODE)), 1);
    lastDS = firstDS - 2 + find(isnan(crisk.(DSCODE)(firstDS:end)),1,'first');
    if isempty(lastDS) || crisk.MONTH(lastDS) > p.smplEnd
        lastDS = find(crisk.MONTH==p.smplEnd);
    end    
    %-------------------------------------------------------------------------------
    % 7.1.7 Making sample per country
    %-------------------------------------------------------------------------------
    initDates = [ip.MONTH(firstIP), risk.MONTH(firstRISK), rer.MONTH(firstRER)];
        % vix.MONTH(firstVIX), crisk.MONTH(firstFD), crisk.MONTH(firstDS)];
    endDates = [ip.MONTH(lastIP), risk.MONTH(lastRISK), rer.MONTH(lastRER)];
        % vix.MONTH(lastVIX), crisk.MONTH(lastFD), crisk.MONTH(lastDS)];    
    StartSmpl = max(initDates);
    EndSmpl = min(endDates);    
    Smpl = StartSmpl:calmonths(1):EndSmpl;
    Smpl = Smpl';
    SmplFig(jj,1) = StartSmpl;
    SmplFig(jj,2) = EndSmpl;
    lp.SmplFig = SmplFig;
    %-------------------------------------------------------------------------------
    % 7.1.8 Working on variables 
    %-------------------------------------------------------------------------------
    OIL = d.data(Smpl,1:end);
    RISK = risk(Smpl,RISKCODE);
    IP = ip(Smpl,IPCODE);
    RER = rer(Smpl,RERCODE);
    % VIX = vix(Smpl,'VIX');
    % FD = crisk(Smpl,FDCODE);
    % DS = crisk(Smpl,DSCODE);
    D = d.dVar(Smpl,:);
    SHOCK = iv.Shock(Smpl,'SHOCK');
    %-------------------------------------------------------------------------------
    % 7.1.9 Estimation: Y(t+h) = beta(h) * SHOCK(t) + X(t-p) * gamma + u(t) 
    %-------------------------------------------------------------------------------    
    CODE = strcat('LP_',Countries{jj});
        %----------------------------------------------------------------------------
        % 7.1.6.1 Confidence bands
        %----------------------------------------------------------------------------
        if p.CBshow
            y = RISK;
            s = SHOCK;
            gamma_s = mean(s.*s);
            eta = y.*s;
            cc = ones(size(y,1),1);
            aa = olsest(cc,eta,false,2,1);
            s_eta = aa.varbhatrobust(1)^0.5;
            s_beta = s_eta/gamma_s;
            CB_Low.(CODE) =norminv(p.Alpha/2*(p.Horizon+1),0,1)*s_beta;
            CB_Sup.(CODE) =norminv(1-p.Alpha/2*(p.Horizon+1),0,1)*s_beta;
        end
    %-------------------------------------------------------------------------------
    % 7.1.10 Local Projection
    %-------------------------------------------------------------------------------
    for hh = 0 : p.Horizon
        Z = synchronize(OIL,RISK,IP,RER,SHOCK);
        if p.pLP == 1
            LZ = lag(Z,p.pLP);
        else
            LZ = lag(Z,1);
            for ii = 2:p.pLP
                LZ = synchronize(LZ,lag(Z,ii));
            end
        end
        if strcmp(variable, 'risk')
            Y = lag(RISK,-hh);
        elseif strcmp(variable, 'ip')
            Y = lag(IP,-hh);
        elseif strcmp(variable, 'rer')
            Y = lag(RER,-hh);
        elseif strcmp(variable, 'oil')
            Y = lag(OIL(:,1),-hh);         
        end
        y = table2array(Y);
        y = y(1+p.pLP:end-hh,:);
        if p.Dummys
            dd = table2array(D(1+p.pLP:end-hh,:));
            dummy = [];
            for ff = 1 : size(dd,2)
                if sum(dd(:,ff)) > 0
                    dummy = [dummy dd(:,ff)];
                end
            end
            x = [table2array(SHOCK) table2array(LZ)];
            x = [x(1+p.pLP:end-hh,:) dummy];
        else
            x = [table2array(SHOCK) table2array(LZ)];
            x = x(1+p.pLP:end-hh,:);
        end
        oo = olsest(x,y,true,1);
        BETA.(CODE)(hh+1,1) = oo.bhat(1);
        BETALow.(CODE)(hh+1,1) = oo.bhat(1) + norminv(p.Alpha/2,0,1)*oo.varbhatrobust(1)^0.5;
        BETASup.(CODE)(hh+1,1) = oo.bhat(1) + norminv(1-p.Alpha/2,0,1)*oo.varbhatrobust(1)^0.5;
        BETALow2.(CODE)(hh+1,1) = oo.bhat(1) + norminv(p.Alpha2/2,0,1)*oo.varbhatrobust(1)^0.5;
        BETASup2.(CODE)(hh+1,1) = oo.bhat(1) + norminv(1-p.Alpha2/2,0,1)*oo.varbhatrobust(1)^0.5;
    end
    lp.BETA.(CODE) = BETA.(CODE);
    lp.BETALow.(CODE) = BETALow.(CODE);
    lp.BETASup.(CODE) = BETASup.(CODE);
    lp.BETALow2.(CODE) = BETALow2.(CODE);
    lp.BETASup2.(CODE) = BETASup2.(CODE);
    if p.CBshow
        lp.CB_Low.(CODE) = CB_Low.(CODE);
        lp.CB_Sup.(CODE) = CB_Sup.(CODE); 
    end
end
%---------------------------------------------------------------------------------
% 8. Figure
%---------------------------------------------------------------------------------
time = (0:p.Horizon)';
nvar = size(Countries,2);
adim = ceil(nvar/3);
bdim = ceil(nvar/adim);
figure('Position',[100 100 1000 600],'PaperPositionMode','Auto','DefaultAxesFontSize',15);
for jj = 1 : length(Countries)
    CODE = strcat('LP_',Countries{jj});
    signIRFs = 1;
    subplot(adim,bdim,jj); 
    hh=fill([time(1); time(1:end); flipud([time(1:end); time(end)])],[BETASup.(CODE)(1);...
            BETALow.(CODE)(1:end,1); flipud([BETASup.(CODE)(1:end,1); BETALow.(CODE)(end,1)])],...
            [0.1, 0.4470, 0.7410]); 
    set(hh,'facealpha',.2);
    set(hh,'edgecolor','none'); 
    hold on;
    hh=fill([time(1); time(1:end); flipud([time(1:end); time(end)])],[BETASup2.(CODE)(1);...
            BETALow2.(CODE)(1:end,1); flipud([BETASup2.(CODE)(1:end,1);...
            BETALow2.(CODE)(end,1)])],[0.1, 0.4470, 0.7410]);  
    set(hh,'facealpha',.4);
    set(hh,'edgecolor','none');
    plot(time, signIRFs*BETA.(CODE),'k', 'Linewidth', 1.5);
    if p.CBshow
        plot(time, CB_Low.(CODE).*ones(p.Horizon+1,1),'r', 'Linewidth', 1.5); 
        plot(time, CB_Sup.(CODE).*ones(p.Horizon+1,1),'r', 'Linewidth', 1.5);
    end
    if ~ismember(0,get(gca,'ylim'))
        line(get(gca,'xlim'),[0 0],'Color','k')
    end
    box on
    grid on ;
    title(CountriesName{jj} + " (" + string(SmplFig(jj,1)) + " to " + string(SmplFig(jj,2)) + ")" );    
    ylabel('Basis points');
    xlim([0,p.Horizon]);
    xlabel('Months');
    xticks(0:10:p.Horizon)
    pause(0.001)
    h=axes('Position',[0.25,0,.5,.5],'Xlim',[0 1],'Ylim',[0 1]);
    set(h,'Visible','off');
end
tightfig;
if p.saveFigs
    if strcmp(iv.Flag,'Kanzig')
        if strcmp(variable,'risk')
            saveas(gcf,'Figures\EMBI_IRFLP_Kanzig','epsc2')
        elseif strcmp(variable,'ip')
            saveas(gcf,'Figures\IP_IRFLP_Kanzig','epsc2')
        elseif strcmp(variable,'rer') 
            saveas(gcf,'Figures\RER_IRFLP_Kanzig','epsc2')
        end
    elseif strcmp(iv.Flag,'Baumeister')
        if strcmp(variable,'risk')
            saveas(gcf,'Figures\EMBI_IRFLP_Baumeister','epsc2')
        elseif strcmp(variable,'ip')
            saveas(gcf,'Figures\IP_IRFLP_Baumeister','epsc2')
        elseif strcmp(variable,'rer') 
            saveas(gcf,'Figures\RER_IRFLP_Baumeister','epsc2')
        end    
    end
end
%---------------------------------------------------------------------------------