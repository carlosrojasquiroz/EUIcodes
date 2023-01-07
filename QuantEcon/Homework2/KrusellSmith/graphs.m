function graphs(p,m,s,format)
%---------------------------------------------------------------------------------------------------------------------------
% This function creates graphs on assets distribution, time series and the DenHaan measure 
%---------------------------------------------------------------------------------------------------------------------------
LW=1.5;
FS=16;
if p.fig==1
%---------------------------------------------------------------------------------------------------------------------------
% Assets distribution
%---------------------------------------------------------------------------------------------------------------------------    
a_values=gridspec(p.avalues_min,p.avalues_max,p.intp,1)'; 
adist=sum(s.a_cross);
figure()
plot(a_values,adist,'LineWidth',LW+1)
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Fraction of households','fontsize',FS,'interpreter','latex')
grid on;
ax=gca;
ax.FontSize =FS;
saveas(gcf,'Histogram',format)
%---------------------------------------------------------------------------------------------------------------------------
% Time series
%---------------------------------------------------------------------------------------------------------------------------    
time=p.init0:1:p.end0;
figure()
subplot(2,2,1)
plot(time,m.Zsim(p.init0:p.end0),'LineWidth',LW+1)
grid on;
ylim([0.985 1.015])
xlabel('Periods, $t$','fontsize',FS,'interpreter','latex')
ylabel('PTF, $Z_t$','fontsize',FS,'interpreter','latex')
ax=gca;
ax.FontSize =FS;
subplot(2,2,2)
plot(time,s.K_ts(p.init0:p.end0),'LineWidth',LW+1)
grid on;
xlabel('Periods, $t$','fontsize',FS,'interpreter','latex')
ylabel('Aggregate capital, $K_t$','fontsize',FS,'interpreter','latex')
ax=gca;
ax.FontSize =FS;
subplot(2,2,3)
plot(time,s.r_ts(p.init0:p.end0),'LineWidth',LW+1)
grid on;
xlabel('Periods, $t$','fontsize',FS,'interpreter','latex')
ylabel('Interest rate, $r_t$','fontsize',FS,'interpreter','latex')
ax=gca;
ax.FontSize =FS;
subplot(2,2,4)
plot(time,s.w_ts(p.init0:p.end0),'LineWidth',LW+1)
grid on;
xlabel('Periods, $t$','fontsize',FS,'interpreter','latex')
ylabel('Wages, $w_t$','fontsize',FS,'interpreter','latex')
ax=gca;
ax.FontSize =FS;
saveas(gcf,'TimeSeries',format)
%---------------------------------------------------------------------------------------------------------------------------
% DenHaan's Test
%---------------------------------------------------------------------------------------------------------------------------
[K_alm,maxError,meanError]=DenHaanTest(p,m,s);
figure()
plot(time,s.K_ts(p.init0:p.end0),'LineWidth',LW+1)
hold on;
plot(time,K_alm,'LineWidth',LW+1,'LineStyle','--')
xlabel('Periods, $t$','fontsize',FS,'interpreter','latex')
ylabel('Aggregate capital, $K_t$','fontsize',FS,'interpreter','latex')
legend('$Simulation$','$ALM$','fontsize',FS,'interpreter','latex','Location','best')
grid on;
txt1 = ['Max(|Error|): ', num2str(maxError)];
text(1010,5.235,txt1,'FontSize',FS)
txt2 = ['Mean(|Error|): ', num2str(meanError)];
text(1010,5.225,txt2,'FontSize',FS)
ax=gca;
ax.FontSize =FS;
saveas(gcf,'DenHaanTest',format)
end
%---------------------------------------------------------------------------------------------------------------------------