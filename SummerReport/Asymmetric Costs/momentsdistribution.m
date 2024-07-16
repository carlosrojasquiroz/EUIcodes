function momentsdistribution(d,smm_sim,ii_sim,name1, name2, name3, name4)
Warm=[234, 84, 85]/255;
Green=[33, 158, 50]/255;
%---------------------------------------------------------------------------------------------------------------------------
figure(1)
histogram(smm_sim.RelativeStd)
grid on;
hold on;
xline(d.MomentData(1),'LineWidth',3.5,'Color',Warm);
xline(smm_sim.Moment1,'LineWidth',3.5,'Color',Green);
c=gca;
c.FontSize=20; 
xlabel('$\frac{\sigma^T}{\sigma^N}$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name1);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(2)
histogram(smm_sim.MeanSpread)
grid on;
hold on;
xline(d.MomentData(2),'LineWidth',3.5,'Color',Warm);
xline(smm_sim.Moment2,'LineWidth',3.5,'Color',Green);
c=gca;
c.FontSize=20; 
xlabel('$Mean(Spread)$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name2);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(3)
histogram(ii_sim.betayT)
grid on;
hold on;
xline(d.DeltaHat(1,5),'LineWidth',3.5,'Color',Warm);
xline(ii_sim.betaAverageT,'LineWidth',3.5,'Color',Green);
c=gca;
c.FontSize=20; 
xlabel('$\delta^T_{d,0}$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name3);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(4)
histogram(ii_sim.betayN)
grid on;
hold on;
xline(d.DeltaHat(2,5),'LineWidth',3.5,'Color',Warm);
xline(ii_sim.betaAverageN,'LineWidth',3.5,'Color',Green);
c=gca;
c.FontSize=20; 
xlabel('$\delta^N_{d,0}$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name4);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
close all;
end