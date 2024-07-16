function productivityloss(v,f,f0,name1,name2)
Warm=[234, 84, 85]/255;
DarkBlue=[134 184 235]/255;
Green=[33, 158, 50]/255;
%---------------------------------------------------------------------------------------------------------------------------
zdefT=min((1-f.chiTss0)*mean(v.z),v.z);
zdefN=min((1-f.chiNss0)*mean(v.z),v.z);
zdefA=min((1-f0.chiTss0)*mean(v.z),v.z);
zLossT=(zdefT-v.z)./v.z;
zLossN=(zdefN-v.z)./v.z;
zLossA=(zdefA-v.z)./v.z;
%---------------------------------------------------------------------------------------------------------------------------
figure(1)
plot(v.z, zdefT,'LineWidth',3.5,'Color',Warm);
hold on
plot(v.z, zdefN,'LineWidth',3.5,'Color',DarkBlue);
plot(v.z, zdefA,'LineWidth',3.5,'Color',Green);
grid on;
c=gca;
c.FontSize=20; 
xlim([v.z(1) v.z(end)]);
xlabel('$z$','FontSize',20,'Interpreter','latex')
ylabel('$z^{i,d}(z)$','FontSize',20,'Interpreter','latex')
legend('Tradable','Nontradable','Symmetric','FontSize',18,'Location','Best','interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name1);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(2)
plot(v.z, zLossT,'LineWidth',3.5,'Color',Warm);
hold on
plot(v.z, zLossN,'LineWidth',3.5,'Color',DarkBlue);
plot(v.z, zLossA,'LineWidth',3.5,'Color',Green);
grid on;
c=gca;
c.FontSize=20; 
xlim([v.z(1) v.z(end)]);
xlabel('$z$','FontSize',20,'Interpreter','latex')
ylabel('$\frac{z^{i,d}(z)-z}{z}$','FontSize',20,'Interpreter','latex')
legend('Tradable','Nontradable','Symmetric','FontSize',18,'Location','Best','interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name2);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
close all;
end