%% Graphs
LW=1.5;
FS=16;
zlow=1;
zhigh=2;
Nend=p.naa;
%---------------------------------------------------------------------------------------------------------------------------
%% Plot value functions, asset and consumption policies as a function of assets
%---------------------------------------------------------------------------------------------------------------------------
% Assets
%---------------------------------------------------------------------------------------------------------------------------
figure(1)
plot(m.a_grid(1:Nend), m.g_a0(zlow,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$a^{\prime}$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.g_a1(zlow,1:Nend), 'LineWidth',LW)
plot(m.a_grid(1:Nend), m.a_grid(1:Nend), 'LineWidth',LW,'LineStyle','--')
legend('$VFI$','$EGM$','45 degree line', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PolFun_zlow','epsc')

figure(2)
plot(m.a_grid(1:Nend), m.g_a0(zhigh,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$a^{\prime}$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.g_a1(zhigh,1:Nend), 'LineWidth',LW)
plot(m.a_grid(1:Nend), m.a_grid(1:Nend), 'LineWidth',LW,'LineStyle','--')
legend('$VFI$','$EGM$','45 degree line', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PolFun_zhigh','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Consumption
%---------------------------------------------------------------------------------------------------------------------------
figure(3)
plot(m.a_grid(1:Nend), m.g_c0(zlow,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$c(z,a)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.g_c1(zlow,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'ConFun_zlow','epsc')

figure(4)
plot(m.a_grid(1:Nend), m.g_c0(zhigh,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$c(z,a)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.g_c1(zhigh,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'ConFun_zhigh','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Value function
%---------------------------------------------------------------------------------------------------------------------------
figure(5)
plot(m.a_grid(1:Nend), m.V0(zlow,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$V(z,a)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.V1(zlow,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Value_Zlow','epsc')

figure(6)
plot(m.a_grid(1:Nend), m.V0(zhigh,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$V(z,a)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.V1(zhigh,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Value_Zhigh','epsc')
%---------------------------------------------------------------------------------------------------------------------------
%% Euler equation errors 
%---------------------------------------------------------------------------------------------------------------------------
figure(7)
plot(m.a_grid(1:Nend), m.EE0(zlow,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$\log(|EE|)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.EE1(zlow,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'EE_Zlow','epsc')

figure(8)
plot(m.a_grid(1:Nend), m.EE0(zhigh,1:Nend), 'LineWidth',LW)
hold on;
grid on;
xlabel('$a$','fontsize',FS,'interpreter','latex')
ylabel('$\log(|EE|)$','fontsize',FS,'interpreter','latex')
plot(m.a_grid(1:Nend), m.EE1(zhigh,1:Nend), 'LineWidth',LW)
legend('$VFI$','$EGM$', 'fontsize',FS,'interpreter','latex'...
    ,'Location','best')
yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
ax = gca;
ax.FontSize = 16;
saveas(gcf,'EE_Zhigh','epsc')

%---------------------------------------------------------------------------------------------------------------------------
%% Plot the ergodic distribution of capital 
%---------------------------------------------------------------------------------------------------------------------------
figure(9)
plot(m.a_grid(1,1:500),vf.Assets_dist(1,1:500), 'LineWidth',LW+1)
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Fraction of households','fontsize',FS,'interpreter','latex')
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Histograma_VFI','epsc')

figure(10)
plot(m.a_grid(1,1:500),eg.Assets_dist(1,1:500), 'LineWidth',LW+1)
xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
ylabel('Fraction of households','fontsize',FS,'interpreter','latex')
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'Histograma_EGM','epsc')

%---------------------------------------------------------------------------------------------------------------------------
%% Transition paths
%---------------------------------------------------------------------------------------------------------------------------
time=[-5:1:p.ntt];
%---------------------------------------------------------------------------------------------------------------------------
% Permanent shock
%---------------------------------------------------------------------------------------------------------------------------
figure(11)
plot(time,[permZ.r(1)*ones(1,6) permZ.r], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Interest rate','fontsize',FS,'interpreter','latex')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PermTP_r','epsc')

figure(12)
plot(time,[permZ.w(1)*ones(1,6) permZ.w], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Wages','fontsize',FS,'interpreter','latex')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PermTP_w','epsc')

figure(13)
plot(time,[permZ.Kh(1)*ones(1,6) permZ.Kh], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Capital','fontsize',FS,'interpreter','latex')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PermTP_Kh','epsc')

figure(14)
plot(time,[permZ.C(1)*ones(1,6) permZ.C], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Consumption','fontsize',FS,'interpreter','latex')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PermTP_C','epsc')

figure(15)
plot(time,[permZ.Y(1)*ones(1,6) permZ.Y], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Output','fontsize',FS,'interpreter','latex')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'PermTP_Y','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Transitory shock
%---------------------------------------------------------------------------------------------------------------------------
figure(16)
plot(time,[permZ.r(1)*ones(1,6) transZ.r], 'LineWidth',LW+1)
hold on;
plot(time,[permZ.r(1)*ones(1,6) transSSJ.r], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Interest rate','fontsize',FS,'interpreter','latex')
legend('Extended path','SSJ', 'fontsize',FS,'interpreter','latex',...
    'Location','best')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'TransTP_r','epsc')

figure(17)
plot(time,[permZ.w(1)*ones(1,6) transZ.w], 'LineWidth',LW+1)
hold on;
plot(time,[permZ.w(1)*ones(1,6) transSSJ.w], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Wages','fontsize',FS,'interpreter','latex')
legend('Extended path','SSJ', 'fontsize',FS,'interpreter','latex',...
    'Location','best')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'TransTP_w','epsc')

figure(18)
plot(time,[permZ.Kh(1)*ones(1,6) transZ.Kh], 'LineWidth',LW+1)
hold on;
plot(time,[permZ.Kh(1)*ones(1,6) transSSJ.Kh], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Capital','fontsize',FS,'interpreter','latex')
legend('Extended path','SSJ', 'fontsize',FS,'interpreter','latex',...
    'Location','best')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'TransTP_Kh','epsc')

figure(19)
plot(time,[permZ.C(1)*ones(1,6) transZ.C], 'LineWidth',LW+1)
hold on;
plot(time,[permZ.C(1)*ones(1,6) transSSJ.C], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Consumption','fontsize',FS,'interpreter','latex')
legend('Extended path','SSJ', 'fontsize',FS,'interpreter','latex',...
    'Location','best')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'TransTP_C','epsc')

figure(20)
plot(time,[permZ.Y(1)*ones(1,6) transZ.Y], 'LineWidth',LW+1)
hold on;
plot(time,[permZ.Y(1)*ones(1,6) transSSJ.Y], 'LineWidth',LW+1)
xlabel('Time','fontsize',FS,'interpreter','latex')
ylabel('Output','fontsize',FS,'interpreter','latex')
legend('Extended path','SSJ', 'fontsize',FS,'interpreter','latex',...
    'Location','best')
xlim([-5 p.ntt])
grid on
ax = gca;
ax.FontSize = 16;
saveas(gcf,'TransTP_Y','epsc')
