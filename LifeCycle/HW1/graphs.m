% Graphs
LW=1.5;
FS=16;
zlow=6;
zmid=8;
zhigh=10;
young=21;
old=61;

figure(1)
plot(m.a_grid, r.g_a(:,zlow,young), 'LineWidth',LW)
hold on;
grid on;
xlabel('Current assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Next period assets, $a^{\prime}$','fontsize',FS,'interpreter','latex')
plot(m.a_grid, r.g_a(:,zmid,old), 'LineWidth',LW)
plot(m.a_grid, m.a_grid, 'LineWidth',LW,'LineStyle','--')
legend('46 years old, $z_{low}$','86 years old','45 degree line', 'fontsize',FS,'interpreter','latex'...
    ,'Location','northwest')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PolFunZlow','epsc')

figure(2)
plot(m.a_grid, r.g_a(:,zmid,young), 'LineWidth',LW)
hold on;
grid on;
xlabel('Current assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Next period assets, $a^{\prime}$','fontsize',FS,'interpreter','latex')
plot(m.a_grid, r.g_a(:,zmid,old), 'LineWidth',LW)
plot(m.a_grid, m.a_grid, 'LineWidth',LW,'LineStyle','--')
legend('46 years old, $z_{mid}$','86 years old','45 degree line', 'fontsize',FS,'interpreter','latex'...
    ,'Location','northwest')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PolFunZmid','epsc')

figure(3)
plot(m.a_grid, r.g_a(:,zhigh,young), 'LineWidth',LW)
hold on;
grid on;
xlabel('Current assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Next period assets, $a^{\prime}$','fontsize',FS,'interpreter','latex')
plot(m.a_grid, r.g_a(:,zmid,old), 'LineWidth',LW)
plot(m.a_grid, m.a_grid, 'LineWidth',LW,'LineStyle','--')
legend('46 years old, $z_{high}$','86 years old','45 degree line', 'fontsize',FS,'interpreter','latex'...
    ,'Location','northwest')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PolFunZhigh','epsc')

figure(4)
plot(m.a_grid, r.g_a(:,zlow,young)-m.a_grid', 'LineWidth',LW)
hold on;
grid on;
xlabel('Current assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Accumulation of assets, $a^{\prime}-a$','fontsize',FS,'interpreter','latex')
plot(m.a_grid, r.g_a(:,zmid,young)-m.a_grid', 'LineWidth',LW)
plot(m.a_grid, r.g_a(:,zhigh,young)-m.a_grid', 'LineWidth',LW)
legend('46 years old, $z_{low}$','46 years old, $z_{mid}$','46 years old, $z_{high}$','fontsize',FS,'interpreter','latex'...
    ,'Location','southwest')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Acc_AssetsYoung','epsc')

figure(5)
plot(m.a_grid, r.g_a(:,zmid,old)-m.a_grid', 'LineWidth',LW)
hold on;
grid on;
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Accumulation of assets, $a^{\prime}-a$','fontsize',FS,'interpreter','latex')
legend('86 years old','fontsize',FS,'interpreter','latex'...
    ,'Location','southwest')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Acc_AssetsOld','epsc')

figure(6)
a_intp=linspace(p.a_min,p.a_max,p.intp);
plot(a_intp,log(abs(r.EE(:,zlow,young))), 'LineWidth',LW)
hold on;
grid on;
plot(a_intp,log(abs(r.EE(:,zmid,young))), 'LineWidth',LW)
plot(a_intp,log(abs(r.EE(:,zhigh,young))), 'LineWidth',LW)
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('$\log(\|EE\|)$','fontsize',FS,'interpreter','latex')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
legend('46 years old, $z_{low}$','46 years old, $z_{mid}$','46 years old, $z_{high}$','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'EEyoung','epsc')

figure(7)
a_intp=linspace(p.a_min,p.a_max,p.intp);
plot(a_intp,log(abs(r.EE(:,zmid,old))), 'LineWidth',LW)
hold on;
grid on;
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('$\log(\|EE\|)$','fontsize',FS,'interpreter','latex')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'EEold','epsc')

figure(8)
bar(m.a_grid,r.Assets_dist, 'LineWidth',LW-0.75)
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Fraction of households','fontsize',FS,'interpreter','latex')
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Histograma','epsc')

figure(9)
scatter(25:24+p.J,r.Assets_stats(:,1),(r.Assets_stats(:,1)+0.001)*30,'o','MarkerEdgeColor','k','MarkerFaceColor',[0.6350 0.0780 0.1840])
hold on;
scatter(25:24+p.J,r.Assets_stats(:,2),(r.Assets_stats(:,1)+0.001)*30,'d','MarkerEdgeColor','k','MarkerFaceColor',[0.4660 0.6740 0.1880])
xlim([25 24+p.J])
scatter(25:24+p.J,r.Assets_stats(:,3),(r.Assets_stats(:,1)+0.001)*30,'_','MarkerEdgeColor','k','LineWidth',LW)
scatter(25:24+p.J,r.Assets_stats(:,4),(r.Assets_stats(:,1)+0.001)*30,'_','MarkerEdgeColor','k','LineWidth',LW,'HandleVisibility','off')
xline(24+p.JR,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
grid on
xlabel('Age','fontsize',FS,'interpreter','latex')
ylabel('Assets,$a$','fontsize',FS,'interpreter','latex')
legend('mean','median','25th/75th percentile','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Stats_Assets','epsc')

figure(10)
scatter(25:24+p.J,r.Earnings_stats(:,1),(r.Earnings_stats(:,1)+0.001)*2,'o','MarkerEdgeColor','k','MarkerFaceColor',[0.6350 0.0780 0.1840])
hold on;
scatter(25:24+p.J,r.Earnings_stats(:,2),(r.Earnings_stats(:,1)+0.001)*2,'d','MarkerEdgeColor','k','MarkerFaceColor',[0.4660 0.6740 0.1880])
xlim([25 24+p.J])
scatter(25:24+p.J,r.Earnings_stats(:,3),(r.Earnings_stats(:,1)+0.001)*2,'_','MarkerEdgeColor','k','LineWidth',LW)
scatter(25:24+p.J,r.Earnings_stats(:,4),(r.Earnings_stats(:,1)+0.001)*2,'_','MarkerEdgeColor','k','LineWidth',LW,'HandleVisibility','off')
xline(24+p.JR,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
grid on
xlabel('Age','fontsize',FS,'interpreter','latex')
ylabel('Earnings','fontsize',FS,'interpreter','latex')
legend('mean','median','25th/75th percentile','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Stats_Earnings','epsc')

figure(11)
scatter(25:24+p.J,r.Consumption_stats(:,1),(r.Consumption_stats(:,1)+0.001)*8,'o','MarkerEdgeColor','k','MarkerFaceColor',[0.6350 0.0780 0.1840])
hold on;
scatter(25:24+p.J,r.Consumption_stats(:,2),(r.Consumption_stats(:,1)+0.001)*8,'d','MarkerEdgeColor','k','MarkerFaceColor',[0.4660 0.6740 0.1880])
xlim([25 24+p.J])
scatter(25:24+p.J,r.Consumption_stats(:,3),(r.Consumption_stats(:,1)+0.001)*8,'_','MarkerEdgeColor','k','LineWidth',LW)
scatter(25:24+p.J,r.Consumption_stats(:,4),(r.Consumption_stats(:,1)+0.001)*8,'_','MarkerEdgeColor','k','LineWidth',LW,'HandleVisibility','off')
xline(24+p.JR,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
grid on
xlabel('Age','fontsize',FS,'interpreter','latex')
ylabel('Consumption','fontsize',FS,'interpreter','latex')
legend('mean','median','25th/75th percentile','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Stats_Consumption','epsc')

figure(12)
plot(25:24+p.J,r.Earnings_stats(:,5),'Color',[0.6350 0.0780 0.1840], 'LineWidth',LW)
hold on;
plot(25:24+p.J,r.Consumption_stats(:,5),'Color',[0.4660 0.6740 0.1880], 'LineWidth',LW)
xlim([25 24+p.J])
xline(24+p.JR,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
grid on
xlabel('Age','fontsize',FS,'interpreter','latex')
ylabel('Gini index','fontsize',FS,'interpreter','latex')
legend('Earnings','Consumption','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Ginis','epsc')

figure(13)
plot(25:24+p.J,r.Earnings_stats(:,1),'Color',[0.6350 0.0780 0.1840], 'LineWidth',LW)
hold on;
plot(25:24+p.J,r.Consumption_stats(:,1),'Color',[0.4660 0.6740 0.1880], 'LineWidth',LW)
xlim([25 24+p.J])
xline(24+p.JR,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
grid on
xlabel('Age','fontsize',FS,'interpreter','latex')
ylabel('Average','fontsize',FS,'interpreter','latex')
legend('Earnings','Consumption','fontsize',FS,'interpreter','latex'...
    ,'Location','best')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Averages','epsc')

clear LW FS a_intp zlow zmid zhigh young old; 
