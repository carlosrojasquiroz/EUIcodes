clc, close, clear;
%---------------------------------------------------------------------------------------------------------------------------
%% GMM estimation of Gamma Distribution parameters
%---------------------------------------------------------------------------------------------------------------------------
% This code estimates the shape and the rate parameters of the Gamma distribution
%---------------------------------------------------------------------------------------------------------------------------
%% 1. Parameters
%---------------------------------------------------------------------------------------------------------------------------
p=parameters();
%---------------------------------------------------------------------------------------------------------------------------
%% 2. Data
%---------------------------------------------------------------------------------------------------------------------------
d=data();
%---------------------------------------------------------------------------------------------------------------------------
%% 3. Estimation (weighting matrix = identity matrix)
%---------------------------------------------------------------------------------------------------------------------------
% 3.1 By pairs
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=2; p.w=eye(p.usedmom); p.algo=1; r=estimation(p,d); r.standerr=inference(d,p,r);
%---------------------------------------------------------------------------------------------------------------------------
% 3.2 All the moments
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=4; p.w=eye(p.usedmom); p.algo=1; rT=estimation(p,d); rT.standerr=inference(d,p,rT);
%---------------------------------------------------------------------------------------------------------------------------
%% 4. Robustness (different solvers + identity matrix)
%---------------------------------------------------------------------------------------------------------------------------
% 4.1 By pairs
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=2; p.w=eye(p.usedmom);
% 4.1.1 solver: fminunc
p.algo=2; r2=estimation(p,d); r2.standerr=inference(d,p,r2);
% 4.1.2 solver: fmincon
p.algo=3; r3=estimation(p,d); r3.standerr=inference(d,p,r3);
% 4.1.3 solver: patternsearch
p.algo=4; r4=estimation(p,d); r4.standerr=inference(d,p,r4);
%---------------------------------------------------------------------------------------------------------------------------
% 4.2 All the moments
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=4; p.w=eye(p.usedmom);
% 4.2.1 solver: fminunc
p.algo=2; r2T=estimation(p,d); r2T.standerr=inference(d,p,r2T);
% 4.2.2 solver: fmincon
p.algo=3; r3T=estimation(p,d); r3T.standerr=inference(d,p,r3T);
% 4.2.3 solver: patternsearch
p.algo=4; r4T=estimation(p,d); r4T.standerr=inference(d,p,r4T);
%---------------------------------------------------------------------------------------------------------------------------
%% 5. Estimation (optimal weighting matrix)
%---------------------------------------------------------------------------------------------------------------------------
% 5.1 By pairs
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=2; p.algo=1; o=estimationoptw(p,d,r); o.standerr=inferenceopt(d,p,o);
%---------------------------------------------------------------------------------------------------------------------------
% 5.2 All the moments
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=4; p.algo=1; oT=estimationoptw(p,d,rT); oT.standerr=inferenceopt(d,p,oT);
%---------------------------------------------------------------------------------------------------------------------------
%% 6. Robustness (different solvers + optimal matrix)
%---------------------------------------------------------------------------------------------------------------------------
% 6.1 By pairs
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=2;
% 6.1.1 solver: fminunc
p.algo=2; o2=estimationoptw(p,d,r2); o2.standerr=inferenceopt(d,p,o2);
% 6.1.2 solver: fmincon
p.algo=3; o3=estimationoptw(p,d,r3); o3.standerr=inferenceopt(d,p,o3);
% 6.1.3 solver: patternsearch
p.algo=4; o4=estimationoptw(p,d,r4); o4.standerr=inferenceopt(d,p,o4);
%---------------------------------------------------------------------------------------------------------------------------
% 6.2 All the moments
%---------------------------------------------------------------------------------------------------------------------------
p.usedmom=4;
% 6.2.1 solver: fminunc
p.algo=2; o2T=estimationoptw(p,d,r2T); o2T.standerr=inferenceopt(d,p,o2T);
% 6.2.2 solver: fmincon
p.algo=3; o3T=estimationoptw(p,d,r3T); o3T.standerr=inferenceopt(d,p,o3T);
% 6.2.3 solver: patternsearch
p.algo=4; o4T=estimationoptw(p,d,r4T); o4T.standerr=inferenceopt(d,p,o4T);
%---------------------------------------------------------------------------------------------------------------------------
                                % (c) Carlos Rojas Quiroz - 16.01.2023
