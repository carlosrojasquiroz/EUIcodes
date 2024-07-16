clc;clear;
dynare Int.mod

%%
figure(1)
subplot(3,2,1)
plot(C_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(C_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
legend('Unanticipated','Anticipated (4)','Location','best','FontSize',18,'interpreter','latex')
title('C','FontSize',18)
%
subplot(3,2,2)
plot(C_star_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(C_star_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C^*','FontSize',18)
%
subplot(3,2,3)
plot(Ch_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Ch_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_H','FontSize',18)
%
subplot(3,2,4)
plot(Cf_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Cf_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_F','FontSize',18)
%
subplot(3,2,5)
plot(Ch_star_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Ch_star_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_H^*','FontSize',18)
%
subplot(3,2,6)
plot(Cf_star_epsilon_Yh(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Cf_star_epsilon_Yh_news(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_F^*','FontSize',18)
%%
figure(2)
subplot(3,2,1)
plot(C_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(C_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
legend('Domestic taste $(\bar{\omega})$','Foreign taste $(\bar{\omega}^*)$','Location','best','FontSize',18,'interpreter','latex')
title('C','FontSize',18)
%
subplot(3,2,2)
plot(C_star_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(C_star_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C^*','FontSize',18)
%
subplot(3,2,3)
plot(Ch_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Ch_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_H','FontSize',18)
%
subplot(3,2,4)
plot(Cf_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Cf_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_F','FontSize',18)
%
subplot(3,2,5)
plot(Ch_star_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Ch_star_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_H^*','FontSize',18)
%
subplot(3,2,6)
plot(Cf_star_epsilon_omega(1:20,1),'LineWidth',2.5);
grid on; hold on;
plot(Cf_star_epsilon_omega_star(1:20,1),'LineWidth',2.5);
xlim([1 20]);
title('C_F^*','FontSize',18)
