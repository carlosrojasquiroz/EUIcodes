%---------------------------------------------------------------------------------
%% Self-fulfilling debt crises in commodity-exporting economies
%---------------------------------------------------------------------------------
% - I estimate the effect of oil price expectational shocks over sovereign risk 
%    for a sample of oil exporters.
% - The methodology follows two stages. Firstly, I estimate a VAR system
%    for global oil market. Then I obtain the structural shocks using
%    an instrumental variable.
% - Secondly, I use the estimated structural shocks in Local Projections to
%    obtain dynamic multipliers of the effect of oil price expectations 
%    on sovereign spreads.
%---------------------------------------------------------------------------------
clc;clear;close all;
%---------------------------------------------------------------------------------
addpath(genpath('Auxfiles')); addpath(genpath('Data')); addpath(genpath('Functions')); 
%---------------------------------------------------------------------------------
%% Setting 
%---------------------------------------------------------------------------------
p = Parameters();
%---------------------------------------------------------------------------------
%% Computing proxy variables
%---------------------------------------------------------------------------------
% Kanzig's surprises shocks
s.K = ShockKanzig(p);
% Baumeister's expectational shocks
s.B = ShockBaumeister(p,'basis');
%---------------------------------------------------------------------------------
%% Data management
%---------------------------------------------------------------------------------
d = DataManagement(p);
%---------------------------------------------------------------------------------
%% IV estimation
%---------------------------------------------------------------------------------
% Kanzig's surprises shocks
ivK = InstrumentalVariable(p,d,s,'Kanzig');
% Baumeister's expectational shocks
ivB = InstrumentalVariable(p,d,s,'Baumeister');
%---------------------------------------------------------------------------------
%% Impulse response functions
%---------------------------------------------------------------------------------
% Kanzig's surprises shocks
lpK.risk = LocalProjection(p,d,ivK,'risk');
% Baumeister's expectational shocks
lpB.risk = LocalProjection(p,d,ivB,'risk');
%---------------------------------------------------------------------------------
%                                         (c) Carlos Rojas Quiroz - EUI 2023