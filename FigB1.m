clear all
load myFile_CN.txt;
CN_Data = myFile_CN';
L_CN = length(CN_Data(:,1));
Age_CN = CN_Data(:,1);
ABeta_CN = CN_Data(:,2);
pTau_CN = CN_Data(:,3);
ADAS_CN = CN_Data(:,4);

load myFile_LMCI.txt;
LMCI_Data = myFile_LMCI';
L_LMCI = length(LMCI_Data(:,1));
Age_LMCI = LMCI_Data(:,1);
ABeta_LMCI = LMCI_Data(:,2);
pTau_LMCI = LMCI_Data(:,3);
ADAS_LMCI = LMCI_Data(:,4);

load myFile_AD.txt;
AD_Data = myFile_AD';
L_AD = length(AD_Data(:,1));
Age_AD = AD_Data(:,1);
ABeta_AD = AD_Data(:,2);
pTau_AD = AD_Data(:,3);
ADAS_AD = AD_Data(:,4);

Age = [Age_CN;Age_LMCI;Age_AD];
ABeta = [ABeta_CN;ABeta_LMCI;ABeta_AD];
pTau = [pTau_CN;pTau_LMCI;pTau_AD];
ADAS = [ADAS_CN;ADAS_LMCI;ADAS_AD];

g1 = repmat({'CN'},L_CN,1);
g2 = repmat({'LMCI'},L_LMCI,1);
g3 = repmat({'AD'},L_AD,1);
g = [g1;g2;g3];

subplot(1,4,1)
boxplot(Age,g);
title('Age','Interpreter', 'Latex','FontSize',14,'Color','k')

subplot(1,4,2)
boxplot(ABeta,g);
title('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')

subplot(1,4,3)
boxplot(pTau,g);
title('p-Tau','Interpreter', 'Latex','FontSize',14,'Color','k')

subplot(1,4,4)
boxplot(ADAS,g);
title('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')

% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 5])
% print -dpng Fig_B1.png -r500
% print -depsc Fig_B1.eps -r300
% 




