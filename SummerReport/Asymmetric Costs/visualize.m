function visualize(time,irf,stdev,name,nF)
LI=irf-1.96*stdev;
LI2=irf-1.645*stdev;
LS=irf+1.96*stdev;
LS2=irf+1.645*stdev;
Warm=[234, 84, 85]/255;
LightBlue=[192 228 255]/255;
DarkBlue=[134 184 235]/255;
[~,Nc]=size(irf);
Nhorz=(Nc-1)/2;
%--------------------------------------------------------------------------------------------------------------------------
% Chart
%--------------------------------------------------------------------------------------------------------------------------
figure(nF)
a=plot(time,irf,'-o','LineWidth',3.5,'Color',Warm);
hold on;
b=line(xlim,[0,0],'Color', 'k', 'LineWidth', 2);
if nF<=2
ylim([-25 15]);
end
xline(0,'Color', 'k', 'LineWidth', 2);
c=gca;
c.FontSize=20; 
x2=[time, fliplr(time)];
inBetween=[LI, fliplr(LS)];
inBetween2=[LI2, fliplr(LS2)];
d=fill(x2, inBetween,LightBlue,'HandleVisibility','off','LineStyle','none');
e=fill(x2, inBetween2,DarkBlue,'HandleVisibility','off','LineStyle','none');
xlabel('Crisis year + T','FontSize',20)
ylabel('log deviation from trend (%)','FontSize',20)
uistack(d,'top')
uistack(e,'top')
uistack(a,'top')
uistack(b,'top')
xticks(-Nhorz:1:Nhorz)
grid on;
%saveas(gcf,name,'epsc')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Figures', name);
ax=gcf;
exportgraphics(ax, filename);