function p=Parameters()
%---------------------------------------------------------------------------------
% This function sets parameters for the VAR estimation of oil global market and the
% Local Projections over sovereign spreads. Values are stored in structure "p".
%---------------------------------------------------------------------------------
% 1. Setting figures and random number generator properties
%---------------------------------------------------------------------------------
rng default; % Set the random number generator to its default settings
set(groot,'defaultAxesTickLabelInterpreter','latex'); % Set the interpreter for tick labels to 'latex'
set(groot,'defaulttextinterpreter','latex'); % Set the interpreter for all text objects to 'latex'
set(groot,'defaultLegendInterpreter','latex'); % Set the interpreter for legend labels to 'latex'
%---------------------------------------------------------------------------------
% 2. VAR sample
%---------------------------------------------------------------------------------
p.smplStart = datetime(1973,1,1); 
p.smplEnd = datetime(2023,8,1);
%---------------------------------------------------------------------------------
% 3. Instrument sample 
%---------------------------------------------------------------------------------
% Surprises shocks
p.smplStartSProxy = datetime(1983,1,1); 
p.smplEndSProxy = datetime(2023,8,1);
% Expectational shocks
p.smplStartEProxy = datetime(1986,1,1); 
p.smplEndEProxy = datetime(2023,3,1);
%---------------------------------------------------------------------------------
% 4. Switches
%---------------------------------------------------------------------------------
p.Cons = true; % Including constant in the first-stage of the IV
p.spreadAlt = false; % Using PC analysis when EMBI does not exist for a country
p.showFigs = true; % Show figures
p.saveFigs = true; % Save figures to disk
p.CBshow = false; % Show confidence bands a la Inoue et al (2023), "Significance Bands for Local Projections"
p.Dummys = false; % Include financial crises dummy variables in LP estimation
%---------------------------------------------------------------------------------
% 5. VAR specifics
%---------------------------------------------------------------------------------
p.pLag = 12; % Lag order in the VAR - Oil Market
p.pLP = 1; % Lag order in the Local Projections - Sovereign Risk vs Expectational shocks
p.ContractMax = 13; % Maximum number of future oil contracts
p.Horizon = 30; % Horizon for IRFs
p.ShockType = 'custom'; % One standard deviation 'sd' or 'custom'
p.ShockSize = 10; % If custom, specify shock size here
p.Alpha = 0.1; % Significance level for bands (alpha=0.1 => 90% CIs (two SD))
p.Alpha2 = 0.32; % Significance level for bands (alpha=0.32 => 68% CIs (two SD))
%---------------------------------------------------------------------------------