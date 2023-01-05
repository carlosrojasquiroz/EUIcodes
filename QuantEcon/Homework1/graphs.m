function graphs(p,m,pe,ge)
%---------------------------------------------------------------------------------------------------------------------------
% This function creates graphs on the value and policy functions, and others. For
% displaying them, you should activate the option such that p.fig=1 (see
% parameters.m)
%---------------------------------------------------------------------------------------------------------------------------
if p.fig==1
    LW=1.5;
    FS=16;
    zlow=1;
    zhigh=2;
    a=gridspecA(p,p.intp);
    disT=sum(pe.dist);
%---------------------------------------------------------------------------------------------------------------------------
% Assets policy function
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(m.a_grid,pe.g_a(zlow,:),'LineWidth',LW)
    hold on;
    grid on;
    xlabel('$a$','fontsize',FS,'interpreter','latex')
    ylabel('$a^{\prime}=g_a(z,a)$','fontsize',FS,'interpreter','latex')
    title('Assets policy function')
    plot(m.a_grid,pe.g_a(zhigh,:), 'LineWidth',LW)
    plot(m.a_grid,m.a_grid, 'LineWidth',LW,'LineStyle','--')
    legend('$z_{low}$','$z_{high}$','$45^o \ line$','fontsize',FS,'interpreter','latex'...
        ,'Location','best')
    yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
    ax=gca;
    ax.FontSize=FS;
    saveas(gcf,'Assets','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Consumption policy function
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(m.a_grid,pe.g_c(zlow,:),'LineWidth',LW)
    hold on;
    grid on;
    xlabel('$a$','fontsize',FS,'interpreter','latex')
    ylabel('$c=g_c(z,a)$','fontsize',FS,'interpreter','latex')
    title('Consumption policy function')
    plot(m.a_grid,pe.g_c(zhigh,:), 'LineWidth',LW)
    legend('$z_{low}$','$z_{high}$', 'fontsize',FS,'interpreter','latex'...
        ,'Location','best')
    yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
    ax=gca;
    ax.FontSize=FS;
    saveas(gcf,'Consumption','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Value function
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(m.a_grid,pe.V(zlow,:),'LineWidth',LW)
    hold on;
    grid on;
    xlabel('$a$','fontsize',FS,'interpreter','latex')
    ylabel('$V(z,a)$','fontsize',FS,'interpreter','latex')
    title('Value function')
    plot(m.a_grid,pe.V(zhigh,:), 'LineWidth',LW)
    legend('$z_{low}$','$z_{high}$', 'fontsize',FS,'interpreter','latex'...
        ,'Location','best')
    yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
    ax=gca;
    ax.FontSize=FS;
    saveas(gcf,'Valuefunction','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Euler errors
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(a, log(abs(pe.EE(zlow,:))), 'LineWidth',LW)
    hold on;
    grid on;
    xlabel('$a$','fontsize',FS,'interpreter','latex')
    ylabel('$\log(|EE|)$','fontsize',FS,'interpreter','latex')
    title('Euler errors')
    plot(a, log(abs(pe.EE(zhigh,:))), 'LineWidth',LW)
    legend('$z_{low}$','$z_{high}$', 'fontsize',FS,'interpreter','latex'...
        ,'Location','best')
    yline(0,'LineStyle',':', 'LineWidth',LW,'HandleVisibility','off')
    ax=gca;
    ax.FontSize=FS;
    saveas(gcf,'Eulererrors','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Assets distribution
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(a,disT, 'LineWidth',LW+1)
    xlabel('Assets, $a$','fontsize',FS,'interpreter','latex')
    ylabel('Fraction of households','fontsize',FS,'interpreter','latex')
    grid on
    ax=gca;
    ax.FontSize =FS;
    saveas(gcf,'Histogram','epsc')
%---------------------------------------------------------------------------------------------------------------------------
% Market for capital
%---------------------------------------------------------------------------------------------------------------------------
    figure()
    plot(ge.Ks_curve,ge.r_market,'LineWidth',LW);
    hold on;
    grid on;
    plot(ge.Kd_curve,ge.r_market,'LineWidth',LW);
    xlim([2 10])
    ylim([0 0.1])
    xlabel('$K$','fontsize',FS,'interpreter','latex')
    ylabel('$r$','fontsize',FS,'interpreter','latex')
    title('Equilibrium in the market for capital')
    legend('$Supply$','$Demand$','fontsize',FS,'interpreter','latex'...
        ,'Location','best')
    ax=gca;
    ax.FontSize=FS; 
    [xi,yi] = polyxpoly(ge.Ks_curve,ge.r_market,ge.Kd_curve,ge.r_market);
    scatter(xi,yi,'filled','MarkerFaceColor','k','HandleVisibility','off')
    saveas(gcf,'MarketforK','epsc')   
end
%---------------------------------------------------------------------------------------------------------------------------