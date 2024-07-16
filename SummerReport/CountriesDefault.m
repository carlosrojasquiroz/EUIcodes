clear; close; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data management
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[data,~] = xlsread( '/Users/carlosrojasquiroz/Desktop/Summer Report/CountriesDefault.xlsx' ,'CountryCases','B3:Y11');
Periods=[-4:1:4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphical representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figureCyc(1,Periods,data(:,1),data(:,2),'Argentina, 2002','Argentina2002')
figureCyc(2,Periods,data(:,3),data(:,4),'Chile, 1983','Chile1983')
figureCyc(3,Periods,data(:,5),data(:,6),'Costa Rica, 1981','CostaRica1981')
figureCyc(4,Periods,data(:,7),data(:,8),'Ecuador, 1999','Ecuador1999')
figureCyc(5,Periods,data(:,9),data(:,10),'Grenada,2004','Grenada2004')
figureCyc(6,Periods,data(:,11),data(:,12),'Greece, 2012','Greece2012')
figureCyc(7,Periods,data(:,13),data(:,14),'Mexico, 1982','Mexico1982')
figureCyc(8,Periods,data(:,15),data(:,16),'Pakistan, 1999','Pakistan1999')
figureCyc(9,Periods,data(:,17),data(:,18),'Peru, 1984','Peru1984')
figureCyc(10,Periods,data(:,19),data(:,20),'Turkey, 2001','Turkey2001')
figureCyc(11,Periods,data(:,21),data(:,22),'Uruguay, 2003','Uruguay2003')
figureCyc(12,Periods,data(:,23),data(:,24),'Ukraine, 2015','Ukraine2015')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;