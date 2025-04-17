clear all

load Control_t0_56.mat

subplot(1,2,1)
 legend()
  hold on
plot(t,x2,'-m','LineWidth',1.5,'DisplayName','$v$')
plot(t,x3,':r','LineWidth',1.5,'DisplayName','$w$')
set(gca,'FontSize',12)
xlabel('Age (years)', 'Interpreter','latex')
hl = legend('show');
set(hl, 'Interpreter','latex')
box on
text(56.03,48.5,'(a)','Interpreter', 'Latex','FontSize',14,'Color','k')
load Control_t0_56-90.mat

subplot(1,2,2)
scatter(t1,100.*v_PC,'*','DisplayName','% change in p-tau');
hl = legend('show');
set(hl, 'Interpreter','latex')
  hold on
% plot(t,x2,'-m','LineWidth',1.5,'DisplayName','v')
% plot(t,x3,':r','LineWidth',1.5,'DisplayName','w')
set(gca,'FontSize',12)
xlabel('$t_1$','Interpreter', 'Latex','FontSize',14,'Color','k')
% ylabel('$\%$ change in p-tau','Interpreter', 'Latex','FontSize',14,'Color','k')
text(58,54.9,'(b)','Interpreter', 'Latex','FontSize',14,'Color','k')
box on
ax = gca;
ax.YTick = [53 53.5 54 54.5 55];
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 5])
print -depsc Fig_O4.eps -r500
print -dpng Fig_O4.png -r500