function d = DataManagement(p)
%---------------------------------------------------------------------------------
% This function orders variables about global oil market and stored them in structure "d".
%---------------------------------------------------------------------------------
% 1. Loading global oil market database
%---------------------------------------------------------------------------------
oo = readtimetable('DataBase.xlsx','Sheet','VARSYSTEM');
oo.MONTH.Format = 'MMM-yyyy';
%---------------------------------------------------------------------------------
%  2. Including deterministic components
%---------------------------------------------------------------------------------
% Constant
Tall = size(oo,1);
if p.Cons
    C = ones(Tall,1);
end
% Time length
smplProxy = p.smplStart:calmonths(1):p.smplEnd;
smplProxy = smplProxy';
%---------------------------------------------------------------------------------
% 3. VAR dataset
%---------------------------------------------------------------------------------
d.data = oo(smplProxy,{'WTI', 'WORLDOIL','STOCKOILWORLDSA','WORLDIP'}); 
d.varNames = {'POIL','OILPROD','OILSTOCKS','WORLDIP'}; 
d.varNames_Paper = {'Real Oil Price',...
    'World Oil Production',...
    'World Oil Inventories',...
    'World Industrial Production'};
d.dataExo = C(1:size(d.data,1));
%---------------------------------------------------------------------------------
% 4. Risk indicator for Norway + Canada
%---------------------------------------------------------------------------------
spr = readtimetable('DataBase.xlsx','Sheet','ADVANCEDGOVBONDRATES','range','AC2:AP610');
spr.MONTH.Format = 'MMM-yyyy';
spr = spr.*100;
if p.spreadAlt
    spr = fillmissing(spr,'constant',0);
else
    spr = fillmissing(spr,'constant',NaN);
end
spr = spr(smplProxy,:);
% Norway
if p.spreadAlt
    proxySel = table2array(spr(:,1:6));
    [~,score,~,~,~] = pca(zscore(proxySel));
    sprNOR = score(:,1);
    EMBINOR = sprNOR./std(sprNOR)*mean(std(proxySel));
else
    EMBINOR = spr.SPR10NOR;
end
% Canada
if p.spreadAlt
    proxySel = table2array(spr(:,7:13));
    [~,score,~,~,~] = pca(zscore(proxySel));
    sprCAN = score(:,1);
    EMBICAN = sprCAN./std(sprCAN)*mean(std(proxySel));
else
    EMBICAN = spr.SPR10CAN;
end
% Joining country indicators
d.EMBIadv = timetable(smplProxy,EMBINOR,EMBICAN);
%---------------------------------------------------------------------------------
% 5. Creating dummy variables
%---------------------------------------------------------------------------------
% Two dummy variables, for each global crisis happened since 1990's
%---------------------------------------------------------------------------------
R = size(smplProxy,1);
TEQUILACrisis = zeros(R,1);
ASIANCrisis = zeros(R,1);
RUSSIANCrisis = zeros(R,1);
GFCrisis = zeros(R,1);
COVIDCrisis = zeros(R,1);
dummys = timetable(smplProxy,TEQUILACrisis,ASIANCrisis,RUSSIANCrisis,GFCrisis,COVIDCrisis);
% Tequila crisis (1995)
smplTEQUILA = datetime(1995,1,1):calmonths(1):datetime(1995,12,31);  
dummys.TEQUILACrisis(smplTEQUILA,:) = 1;
% Asian crisis (July 1997 - December 1998)
smplASIAN = datetime(1997,7,1):calmonths(1):datetime(1998,12,31);
dummys.ASIANCrisis(smplASIAN,:) = 1;
% Russian crisis (August 1998 - March 2000)
smplRUSSIAN = datetime(1998,8,1):calmonths(1):datetime(2000,3,31);  
dummys.RUSSIANCrisis(smplRUSSIAN,:) = 1;
% Global financial crisis (September 2008 - September 2009)
smplGFC = datetime(2008,9,1):calmonths(1):datetime(2009,09,30);  
dummys.GFCrisis(smplGFC,:) = 1;
% Covid-19 crisis (mar2020 - oct2020)
smplCOVID = datetime(2020,03,1):calmonths(1):datetime(2020,10,31);  
dummys.COVIDCrisis(smplCOVID,:) = 1;
% Outcome
d.dVar = dummys;
%---------------------------------------------------------------------------------
%  Dummy variables, for each country with a specific crisis
%---------------------------------------------------------------------------------
MEXCrisis = zeros(R,1);
RUSCrisis = zeros(R,1);
MYSCrisis = zeros(R,1);
NGACrisis = zeros(R,1);
VENCrisis = zeros(R,1); 
% Mexican crisis
smplMEX = datetime(1986,1,1):calmonths(1):datetime(1994,12,31);  
d.dummyMEX = timetable(smplProxy,MEXCrisis);
d.dummyMEX.MEXCrisis(smplMEX,:) = 1;
% Russian crisis
smplRUS = datetime(1993,1,1):calmonths(1):datetime(1998,8,31);  
d.dummyRUS = timetable(smplProxy,RUSCrisis);
d.dummyRUS.RUSCrisis(smplRUS,:) = 1;
% Malaysian crisis
smplMYS = datetime(1979,1,1):calmonths(1):datetime(1997,12,31);
d.dummyMYS = timetable(smplProxy,MYSCrisis);
d.dummyMYS.MYSCrisis(smplMYS,:) = 1;
% Nigerian crisis
smplNGA1 = datetime(1979,12,31):calmonths(1):datetime(1986,9,30);
smplNGA2 = datetime(1986,10,31):calmonths(1):datetime(1998,12,31);
smplNGA3 = datetime(1999,1,31):calmonths(1):datetime(2016,6,30);
d.dummyNGA1 = timetable(smplProxy,NGACrisis);
d.dummyNGA2 = timetable(smplProxy,NGACrisis);
d.dummyNGA3 = timetable(smplProxy,NGACrisis);
d.dummyNGA1.NGACrisis(smplNGA1,:) = 1;
d.dummyNGA2.NGACrisis(smplNGA2,:) = 1;
d.dummyNGA3.NGACrisis(smplNGA3,:) = 1; 
% Venezuelan hyperinflation
smplVEN1 = datetime(1987,1,31):calmonths(1):datetime(1989,2,28);
smplVEN2 = datetime(1989,3,31):calmonths(1):datetime(1990,12,31);
smplVEN3 = datetime(1991,1,31):calmonths(1):datetime(1994,5,31);
smplVEN4 = datetime(1994,6,30):calmonths(1):datetime(1996,5,31);
smplVEN5 = datetime(1996,6,30):calmonths(1):datetime(1999,12,31);
smplVEN6 = datetime(2000,1,31):calmonths(1):datetime(2002,5,31);
smplVEN7 = datetime(2002,6,30):calmonths(1):datetime(2010,12,31);
smplVEN8 = datetime(2011,1,31):calmonths(1):datetime(2013,12,31);
smplVEN9 = datetime(2014,1,31):calmonths(1):datetime(2018,6,30);
d.dummyVEN1 = timetable(smplProxy,VENCrisis);
d.dummyVEN2 = timetable(smplProxy,VENCrisis);
d.dummyVEN3 = timetable(smplProxy,VENCrisis);
d.dummyVEN4 = timetable(smplProxy,VENCrisis);
d.dummyVEN5 = timetable(smplProxy,VENCrisis);
d.dummyVEN6 = timetable(smplProxy,VENCrisis);
d.dummyVEN7 = timetable(smplProxy,VENCrisis);
d.dummyVEN8 = timetable(smplProxy,VENCrisis);
d.dummyVEN9 = timetable(smplProxy,VENCrisis);
d.dummyVEN1.VENCrisis(smplVEN1,:) = 1;
d.dummyVEN2.VENCrisis(smplVEN2,:) = 1;
d.dummyVEN3.VENCrisis(smplVEN3,:) = 1;
d.dummyVEN4.VENCrisis(smplVEN4,:) = 1;
d.dummyVEN5.VENCrisis(smplVEN5,:) = 1;
d.dummyVEN6.VENCrisis(smplVEN6,:) = 1;
d.dummyVEN7.VENCrisis(smplVEN7,:) = 1;
d.dummyVEN8.VENCrisis(smplVEN8,:) = 1;
d.dummyVEN9.VENCrisis(smplVEN9,:) = 1;
%---------------------------------------------------------------------------------