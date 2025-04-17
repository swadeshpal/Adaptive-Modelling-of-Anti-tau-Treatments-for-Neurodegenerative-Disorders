% clear all
% 
% cd PINN
% load PINN_CN_out_theta.txt
% load PINN_LMCI_out_theta.txt
% load PINN_AD_out_theta.txt
% cd ../
% 
% Iter_CN = PINN_CN_out_theta(:,1);
% Loss_CN = PINN_CN_out_theta(:,2);
% Iter_LMCI = PINN_LMCI_out_theta(:,1);
% Loss_LMCI = PINN_LMCI_out_theta(:,2);
% Iter_AD = PINN_AD_out_theta(:,1);
% Loss_AD = PINN_AD_out_theta(:,2);
% 
% load MSE_Loss_CN.mat
% L_CN_B = loss;
% 
% load MSE_Loss_LMCI.mat
% L_LMCI_B = loss;
% 
% load MSE_Loss_AD.mat
% L_AD_B = loss;
% 
% for n=1:500000
%     iter(n) = n;
%     L_CN_Bv(n) = L_CN_B(end);
%     L_LMCI_Bv(n) = L_LMCI_B(end);
%     L_AD_Bv(n) = L_AD_B(end);
% end

hold on
plot(Iter_CN(2:end),Loss_CN(2:end),'-b','LineWidth',1.2)
plot(Iter_LMCI(2:end),Loss_LMCI(2:end),'-m','LineWidth',1.2)
plot(Iter_AD(2:end),Loss_AD(2:end),'-r','LineWidth',1.2)
% legend('CN','LMCI','AD')
xlim([0 500000])
% xlabel('Training number','Interpreter', 'Latex','FontSize',18,'Color','k')
% ylabel('MSE loss','Interpreter', 'Latex','FontSize',18,'Color','k')

box on


% subplot(1,2,2)
hold on
plot(iter,L_CN_Bv,':b','LineWidth',1.2)
plot(iter,L_LMCI_Bv,':m','LineWidth',1.2)
plot(iter,L_AD_Bv,':r','LineWidth',1.2)
legend('PINN-CN','PINN-LMCI','PINN-AD','Bayesian-CN','Bayesian-LMCI','Bayesian-AD')
xlim([0 500000])
xlabel('Training number','Interpreter', 'Latex','FontSize',18,'Color','k')
ylabel('MSE loss','Interpreter', 'Latex','FontSize',18,'Color','k')

box on

rectangle('Position',[480000 0 100000 300000],'EdgeColor','k','LineWidth',1.5)
p1 = [480000 0];
p2 = [200000 500000];
plot([ p1(1) p2(1)], [p1(2) p2(2)], '--k','HandleVisibility','off');

p1 = [500000 300000];
p2 = [470000 500000];
plot([ p1(1) p2(1)], [p1(2) p2(2)], '--k','HandleVisibility','off');
 
ax3 = axes('Position',[.438 .246 .417 .3]);
box on;

hold on
plot(Iter_CN(480000:500000),Loss_CN(480000:500000),'-b','LineWidth',1.2)
plot(Iter_LMCI(480000:500000),Loss_LMCI(480000:500000),'-m','LineWidth',1.2)
plot(Iter_AD(480000:500000),Loss_AD(480000:500000),'-r','LineWidth',1.2)

plot(iter(480000:500000),L_CN_Bv(480000:500000),':b','LineWidth',1.2)
plot(iter(480000:500000),L_LMCI_Bv(480000:500000),':m','LineWidth',1.2)
plot(iter(480000:500000),L_AD_Bv(480000:500000),':r','LineWidth',1.2)

xlim([480000 500000])
ylim([50000 170000])
ax = gca;
ax.XTick=[480000 490000 500000];
% ax.YTick=[0 0.2 0.4 0.6 0.8];

set(gca,'xaxisLocation','top')
set(gca,'yaxisLocation','left')


set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 4.2])
print -dpng Fig_F1.png -r500
print -depsc Fig_F1.eps -r500