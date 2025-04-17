clear all

load myFile_CN.txt

Time = myFile_CN(1,:);
ABeta = myFile_CN(2,:);
pTau = myFile_CN(3,:);
ADAS = myFile_CN(4,:);
dt = 0.01;
T = Time(1):dt:Time(end);  
Index = Ind_int(Time);


subplot(3,3,1)
scatter(Time, ABeta, 10, 'MarkerEdgeColor',[0.2 0.5 .99], 'MarkerFaceColor',[0 0.5 .99]);
hold on
cd Bayesian/
Bayesian_Result_CN(Time,1);
cd ..

% uvw_sol = solution_uvw(Time, mu);
% 
% plot(T, uvw_sol(1,:), '-', 'Color', [0.8 0.4 0], 'LineWidth', 2)
box on
ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
title('CN','Interpreter', 'Latex','FontSize',14,'Color','k')
text(89.5,1800,'(a)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])


% return

subplot(3,3,4)
scatter(Time, pTau, 10, 'MarkerEdgeColor',[0.8 0.2 .8], 'MarkerFaceColor',[0.8 0 .8]);
hold on
% plot(T, uvw_sol(2,:), '-', 'Color', [0 0 0.8], 'LineWidth', 2)
cd Bayesian/
Bayesian_Result_CN(Time,2);
cd ..
box on
ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
text(89.1,90,'(b)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 100])

subplot(3,3,7)
scatter(Time, ADAS, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
% plot(T, uvw_sol(3,:), '-r', 'LineWidth', 2)
cd Bayesian/
Bayesian_Result_CN(Time,3);
cd ..
box on
ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
text(89.5,72,'(c)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 80])

return
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 8])
% print -dpng Fig_I1.png -r500
% % print -depsc Fig_I1.eps -r300
clear all

load Initial_Guess_LMCI.mat

subplot(3,3,2)
scatter(Time, ABeta, 10, 'MarkerEdgeColor',[0.2 0.5 .99], 'MarkerFaceColor',[0 0.5 .99]);
hold on
plot(T, u, '-', 'Color', [0.8 0.4 0], 'LineWidth', 2)
box on
% ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
title('LMCI','Interpreter', 'Latex','FontSize',14,'Color','k')
text(87.7,1800,'(d)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])

subplot(3,3,5)
scatter(Time, pTau, 10, 'MarkerEdgeColor',[0.8 0.2 .8], 'MarkerFaceColor',[0.8 0 .8]);
hold on
plot(T, v, '-', 'Color', [0 0 0.8], 'LineWidth', 2)
box on
% ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
text(88,90,'(e)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 100])

subplot(3,3,8)
scatter(Time, ADAS, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
plot(T, w, '-r', 'LineWidth', 2)
box on
% ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
text(88,72,'(f)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 80])


clear all

load Initial_Guess_AD.mat

subplot(3,3,3)
scatter(Time, ABeta, 10, 'MarkerEdgeColor',[0.2 0.5 .99], 'MarkerFaceColor',[0 0.5 .99]);
hold on
plot(T, u, '-', 'Color', [0.8 0.4 0], 'LineWidth', 2)
box on
% ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
title('AD','Interpreter', 'Latex','FontSize',14,'Color','k')
text(88.2,1800,'(g)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])

subplot(3,3,6)
scatter(Time, pTau, 10, 'MarkerEdgeColor',[0.8 0.2 .8], 'MarkerFaceColor',[0.8 0 .8]);
hold on
plot(T, v, '-', 'Color', [0 0 0.8], 'LineWidth', 2)
box on
% ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
text(88.1,90,'(h)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 100])


subplot(3,3,9)
scatter(Time, ADAS, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
plot(T, w, '-r', 'LineWidth', 2)
box on
% ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
text(88.8,72,'(i)','Interpreter', 'Latex','FontSize',14,'Color','k')
xlim([Time(1) Time(end)])
ylim([0 80])


set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 8])
print -dpng Fig_BS2.png -r500
print -depsc Fig_BS2.eps -r500

