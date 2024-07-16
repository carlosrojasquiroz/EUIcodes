function figureCyc(j,Periods,NonTradable,Tradable,nameTitle,nameFig)
figure(j)
plot(Periods,NonTradable,...
    '-o','MarkerSize',5,'MarkerEdgeColor',[119,158,203]/255,'MarkerFaceColor','white',...
    'LineWidth',3.5,'Color',[119,158,203]/255);
ax = gca;
ax.FontSize = 20;
grid on;
hold on;
plot(Periods,Tradable,...
    '-o','MarkerSize',5,'MarkerEdgeColor',[255,105,97]/255,'MarkerFaceColor','white',...
    'LineWidth',3.5,'Color',[255,105,97]/255);
xline(0,'LineWidth',2);
yline(0,'LineWidth',2);
xticks([-4 -3 -2 -1 0 1 2 3 4])
xlabel('Crisis year + T','FontSize',24);  
ylabel('log deviation from trend (%)','FontSize',24);
%title(nameTitle,'FontSize',18);
if j==1
    legend('Nontradable','Tradable','Location','best','FontSize',28,'interpreter','latex')
end
saveas(gcf,nameFig,'epsc')