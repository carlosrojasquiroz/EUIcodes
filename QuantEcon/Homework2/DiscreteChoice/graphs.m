function graphs(p,m,s1,s2)
%---------------------------------------------------------------------------------------------------------------------------
% This function creates graphs on the value and policy functions. For
% displaying them, you should activate the option such that p.fig=1 (see
% parameters.m)
%---------------------------------------------------------------------------------------------------------------------------
LW=2.5;
FS=16;
idx_oo=zeros(1,p.naa);
for d_2=2:p.naa
    idx_oo(1,d_2)=s1.g_n(d_2)-s1.g_n(d_2-1);
end
xi=find(idx_oo<0);
if p.fig==1
% Value function
    figure()
        plot(m.a_grid, s1.V,'LineWidth',LW)
        hold on;
        grid on;
        plot(m.a_grid, s2.V,'LineWidth',LW)
        xlabel('$a$','fontsize',FS,'interpreter','latex')
        ylabel('$V(a)$','fontsize',FS,'interpreter','latex')
        title('Value function') 
        scatter(m.a_grid(xi),s1.V(xi),'k','HandleVisibility','off','SizeData',50)
        yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
        legend('Discrete choice','DC + EV shocks','fontsize',FS,'interpreter','latex','Location','best')
        xlim([m.a_grid(xi)-0.5 m.a_grid(xi)+0.5])
        ylim([-16 -15])
        ax=gca;
        ax.FontSize=16;
    saveas(gcf,'VFun','epsc')
% Assets policy function
    figure()
        plot(m.a_grid, s1.g_a,'LineWidth',LW)
        hold on;
        grid on;
        plot(m.a_grid, s2.g_a,'LineWidth',LW)
        xlabel('$a$','fontsize',FS,'interpreter','latex')
        ylabel('$a^{\prime}(a)$','fontsize',FS,'interpreter','latex')
        title('Assets policy function')
        yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
        legend('Discrete choice','DC + EV shocks','fontsize',FS,'interpreter','latex','Location','best')
        xlim([p.Amin p.Amax])
        ymin=min(s1.g_a);
        ymax=max(s1.g_a);
        ylim([ymin ymax])
        ax = gca;
        ax.FontSize = 16;
    saveas(gcf,'A_PolFun','epsc')
% Consumption policy function
    figure()
        plot(m.a_grid, s1.g_c,'LineWidth',LW)
        hold on;
        grid on;
        plot(m.a_grid, s2.g_c,'LineWidth',LW)
        xlabel('$a$','fontsize',FS,'interpreter','latex')
        ylabel('$c(a)$','fontsize',FS,'interpreter','latex')
        title('Consumption policy function')
        yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
        legend('Discrete choice','DC + EV shocks','fontsize',FS,'interpreter','latex','Location','best')
        xlim([p.Amin p.Amax])
        ymin=min(s1.g_c);
        ymax=max(s1.g_c);
        ylim([ymin ymax])
        ax = gca;
        ax.FontSize = 16;
    saveas(gcf,'C_PolFun','epsc')
% Labor policy function
    figure()
        plot(m.a_grid, s1.g_n,'LineWidth',LW)
        hold on;
        grid on;
        plot(m.a_grid, s2.g_n,'LineWidth',LW)
        xlabel('$a$','fontsize',FS,'interpreter','latex')
        ylabel('$n(a)$','fontsize',FS,'interpreter','latex')
        title('Labor policy function')
        yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
        legend('Discrete choice','DC + EV shocks','fontsize',FS,'interpreter','latex','Location','best')
        xlim([p.Amin p.Amax])
        ylim([0 1])
        ax = gca;
        ax.FontSize = 16;
    saveas(gcf,'L_PolFun','epsc')
end
%---------------------------------------------------------------------------------------------------------------------------