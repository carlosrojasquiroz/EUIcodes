function d=empiricalevidence(Ff)
%---------------------------------------------------------------------------------------------------------------------------
% Data management
%---------------------------------------------------------------------------------------------------------------------------
data= readmatrix('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Empirical strategy/Argentina_DataSet.xlsx');
% Extracting data: dummy variables
DDefault=data(:,4); % Sovereign default crises
DCurrency=data(:,5); % Currency crises
DBanking=data(:,6); % Systemic Banking crises
DIFC=data(:,7); % International financial crisis
% Extracting data: variables
BC_NT=data(:,2);  % Nontradable GDP
BC_T=data(:,3); % Tradable GDP
TFP=log(data(:,10)); % Productivity in logs
SPREAD=data(:,14); % Spread
% Sample information
[d.Nobs,~]=size(DDefault); % Sample length
d.Ndefaults=sum(DDefault); % Number of default events in the sample
%---------------------------------------------------------------------------------------------------------------------------
% Empirical strategy: Gourinchas and Obstfeld (2012)
%---------------------------------------------------------------------------------------------------------------------------
d.Nhorz=4;
X=[DDefault DCurrency DBanking DIFC];
% Tradable GDP
Y=BC_T;
[DeltaHat_T,StdevDelta_T]=Obstfeld_Gourinchas(Y,X,d.Nhorz);
% Non-tradable GDP
Y=BC_NT;
[DeltaHat_NT,StdevDelta_NT]=Obstfeld_Gourinchas(Y,X,d.Nhorz);
%---------------------------------------------------------------------------------------------------------------------------
% Moments
%---------------------------------------------------------------------------------------------------------------------------
RelativeStd=std(BC_T)/std(BC_NT);
MeanSpread=mean(SPREAD,'omitnan');
d.MomentData=[RelativeStd MeanSpread];
%---------------------------------------------------------------------------------------------------------------------------
% Collecting results
%---------------------------------------------------------------------------------------------------------------------------
iD=linspace(9,1,9);
d.DeltaHat=[DeltaHat_T(2,iD); DeltaHat_NT(2,iD)];
d.StdevDelta=[StdevDelta_T(2,iD); StdevDelta_NT(2,iD)];
%---------------------------------------------------------------------------------------------------------------------------
% TFP - AR(1) estimation
%---------------------------------------------------------------------------------------------------------------------------
Lag1TFP=TFP(1:end-1);
Lag0TFP=TFP(2:end);
[d.Rho_TFP, d.DeBeta_TFP, d.Sigma_TFP, d.RsquareAdj_TFP] = OLS(Lag0TFP,Lag1TFP,1);
%---------------------------------------------------------------------------------------------------------------------------
% Figures
%---------------------------------------------------------------------------------------------------------------------------
if Ff==1
TT=-d.Nhorz:1:d.Nhorz;
% Tradable GDP
visualize(TT,d.DeltaHat(1,:),d.StdevDelta(1,:),'Tradable_Argentina.eps',1)
% Non-tradable GDP
visualize(TT,d.DeltaHat(2,:),d.StdevDelta(2,:),'NonTradable_Argentina.eps',2)
end
%---------------------------------------------------------------------------------------------------------------------------
close all;
%---------------------------------------------------------------------------------------------------------------------------
end