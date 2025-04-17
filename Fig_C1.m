clear all

load Bayesian_Result_CN_Plot.mat

for i=1:3
    subplot(3,3,3*(i-1)+1)
    hold on
    if i==1
        scatter(time,myFile_CN(i+1,:), 10, 'MarkerEdgeColor',[0 0.4 0.9], 'MarkerFaceColor',[0 0.5 1]);
        ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
        title('CN','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(90.5,1800,'(a)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==2
        scatter(time,myFile_CN(i+1,:), 10, 'MarkerEdgeColor',[0.7 0 0.7], 'MarkerFaceColor',[0.8 0 .8]);
        ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(90.1,90,'(b)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==3
        scatter(time,myFile_CN(i+1,:), 10, 'MarkerEdgeColor',[0 .6 .6], 'MarkerFaceColor',[0 .7 .7]);
        ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(90.5,72,'(c)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    hold off
end
[mu, sigma] = MeanStd(chain,nsample);
y_sol = ADfun(time,mu(1:14));

for i=1:3
    subplot(3,3,3*(i-1)+1)
    hold on
    T1 = T(1,:);
    Rx = Y_Min(:,i);
    Rx = Rx';
    Ry = Y_Max(:,i);
    Ry = Ry';
    Rx1 = [T1, fliplr(T1)];
    inBetween = [Rx, fliplr(Ry)];
    if i == 1
        p = fill(Rx1, inBetween,'m','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','m');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','m');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','m');
    end
    if i == 2
        p = fill(Rx1, inBetween,'b','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','b');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','b');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','b');
        ylim([0 100])
    end
    if i == 3
        p = fill(Rx1, inBetween,'k','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','k');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','k');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','k');
        ylim([0 80])
    end
    box on
    hold off
end

% return
clear all
load Bayesian_Result_LMCI_Plot.mat
[mu, sigma] = MeanStd(chain,nsample);
y_sol = ADfun(time,mu(1:14));

for i=1:3
    subplot(3,3,3*(i-1)+2)
    hold on
    if i==1
        scatter(time,myFile_LMCI(i+1,:), 10, 'MarkerEdgeColor',[0 0.4 0.9], 'MarkerFaceColor',[0 0.5 1]);
%         ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
        title('LMCI','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(88.7,1800,'(d)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==2
        scatter(time,myFile_LMCI(i+1,:), 10, 'MarkerEdgeColor',[0.7 0 0.7], 'MarkerFaceColor',[0.8 0 .8]);
%         ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(89,90,'(e)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==3
        scatter(time,myFile_LMCI(i+1,:), 10, 'MarkerEdgeColor',[0 .6 .6], 'MarkerFaceColor',[0 .7 .7]);
%         ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(89,72,'(f)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    hold off
end

for i=1:3
    subplot(3,3,3*(i-1)+2)
    hold on
    T1 = T(1,:);
    Rx = Y_Min(:,i);
    Rx = Rx';
    Ry = Y_Max(:,i);
    Ry = Ry';
    Rx1 = [T1, fliplr(T1)];
    inBetween = [Rx, fliplr(Ry)];
    if i == 1
        p = fill(Rx1, inBetween,'m','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','m');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','m');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','m');
    end
    if i == 2
        p = fill(Rx1, inBetween,'b','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','b');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','b');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','b');
        ylim([0 100])
    end
    if i == 3
        p = fill(Rx1, inBetween,'k','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','k');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','k');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','k');
        ylim([0 80])
    end
    box on
    hold off
end

clear all
load Bayesian_Result_AD_Plot.mat
[mu, sigma] = MeanStd(chain,nsample);
y_sol = ADfun(time,mu(1:14));


for i=1:3
    subplot(3,3,3*(i-1)+3)
    hold on
    if i==1
        scatter(time,myFile_AD(i+1,:), 10, 'MarkerEdgeColor',[0 0.4 0.9], 'MarkerFaceColor',[0 0.5 1]);
%         ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
        title('AD','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(89.2,1800,'(g)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==2
        scatter(time,myFile_AD(i+1,:), 10, 'MarkerEdgeColor',[0.7 0 0.7], 'MarkerFaceColor',[0.8 0 .8]);
%         ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(89.1,90,'(h)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    if i==3
        scatter(time,myFile_AD(i+1,:), 10, 'MarkerEdgeColor',[0 .6 .6], 'MarkerFaceColor',[0 .7 .7]);
%         ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlabel('Age','Interpreter', 'Latex','FontSize',14,'Color','k')
        text(89.8,72,'(i)','Interpreter', 'Latex','FontSize',14,'Color','k')
        xlim([time(1)-1 time(end)+1])
    end
    hold off
end

for i=1:3
    subplot(3,3,3*(i-1)+3)
    hold on
    T1 = T(1,:);
    Rx = Y_Min(:,i);
    Rx = Rx';
    Ry = Y_Max(:,i);
    Ry = Ry';
    Rx1 = [T1, fliplr(T1)];
    inBetween = [Rx, fliplr(Ry)];
    if i == 1
        p = fill(Rx1, inBetween,'m','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','m');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','m');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','m');
    end
    if i == 2
        p = fill(Rx1, inBetween,'b','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','b');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','b');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','b');
        ylim([0 100])
    end
    if i == 3
        p = fill(Rx1, inBetween,'k','FaceAlpha',0.2);
        p.LineStyle = "none";
        plot(T,Y_Min(:,i),'LineWidth',0.5,'Color','k');
        plot(T,y_sol(:,i),'LineWidth',2,'Color','k');
        plot(T,Y_Max(:,i),'LineWidth',0.5,'Color','k');
        ylim([0 80])
    end
    box on
    hold off
end

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 8])
print -depsc Fig_C1.eps -r500
print -dpng Fig_C1.png -r500