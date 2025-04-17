% clear all
% 
% load PINN_CN_out_theta.txt
% load PINN_LMCI_out_theta.txt
% load PINN_AD_out_theta.txt
% 
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

for n=1:500000
    iter(n) = n;
    L_CN_Bv(n) = L_CN_B(end);
    L_LMCI_Bv(n) = L_LMCI_B(end);
    L_AD_Bv(n) = L_AD_B(end);
end
% subplot(1,2,1)
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

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 4])
print -dpng Fig_F1.png -r500
print -depsc Fig_F1.eps -r500