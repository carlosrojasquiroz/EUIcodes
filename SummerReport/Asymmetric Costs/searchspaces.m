function searchspaces(smm,ii,name1,name2)
%---------------------------------------------------------------------------------------------------------------------------
figure(1)
surf(smm.Jgs0)
grid on;
c=gca;
c.FontSize=15; 
xlabel('$\chi^T$','FontSize',20,'Interpreter','latex')
ylabel('$\chi^N$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name1);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(2)
surf(ii.Jgs0)
grid on;
c=gca;
c.FontSize=15; 
xlabel('$\chi^T$','FontSize',20,'Interpreter','latex')
ylabel('$\chi^N$','FontSize',20,'Interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/OtherTry', name2);
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
close all;
end
