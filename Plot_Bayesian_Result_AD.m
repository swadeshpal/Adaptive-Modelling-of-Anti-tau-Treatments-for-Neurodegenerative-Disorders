clear all
load Bayesian_Result_AD.mat

nsample = 5000;
[Y_Min, Y_Max] = MinMax(nsample, chain, myFile_AD);
time   = data.ydata(:,1);
dt = 0.01;
T = time(1):dt:time(end);

sz = 8;
for i=1:3
    subplot(3,1,i)
    hold on
    scatter(time,myFile_AD(i+1,:),sz,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1);
    hold off
end

for i=1:3
    subplot(3,1,i)
    hold on
    T1 = T(1,:);
    Rx = Y_Min(:,i);
    Rx = Rx';
    Ry = Y_Max(:,i);
    Ry = Ry';
    Rx1 = [T1, fliplr(T1)];
    inBetween = [Rx, fliplr(Ry)];
    p = fill(Rx1, inBetween,'m','FaceAlpha',0.1);
    p.LineStyle = "none";
    plot(T,Y_Min(:,i),'LineWidth',1,'Color',[0.5 0.2 0.55]);
    plot(T,Y_Max(:,i),'LineWidth',1,'Color',[0.5 0.2 0.55]);
    box on
    if i == 1  
        ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
    end
    if i == 2  
        ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
    end
    if i == 3  
        ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
    end
    hold off
end

xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 8])
print -dpng Fig_BR3.png -r500
print -depsc Fig_BR3.eps -r500    