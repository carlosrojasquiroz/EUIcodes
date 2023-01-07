clc,close,clear;
%---------------------------------------------------------------------------------------------------------------------------
%% Aiyagari model with aggregate shocks
%---------------------------------------------------------------------------------------------------------------------------
% This code solves the Aiyagari model with aggregate shocks by the K-S method.
%---------------------------------------------------------------------------------------------------------------------------
%% 1. Parameters
%---------------------------------------------------------------------------------------------------------------------------
    p=parameters();
%---------------------------------------------------------------------------------------------------------------------------
%% 2. Matrices (grid specifications, transition probabilities, etc.)
%---------------------------------------------------------------------------------------------------------------------------
    m=matrices(p);
%---------------------------------------------------------------------------------------------------------------------------
%% 3. Solving the model
%---------------------------------------------------------------------------------------------------------------------------
    s=solveKS(p,m);
%---------------------------------------------------------------------------------------------------------------------------
%% 4. Solving the model
%---------------------------------------------------------------------------------------------------------------------------
    graphs(p,m,s,'epsc')
%---------------------------------------------------------------------------------------------------------------------------
                              % (c) Carlos Rojas Quiroz  - This version: 08.01.2023
