clear all
load Bayesian_Result_CN.mat

nsample = 5000;
[Y_Min, Y_Max] = MinMax(nsample, chain, myFile_CN);
sz = 8;
for i=1:3
    subplot(3,1,i)
    hold on
    scatter(time,myFile_CN(i+1,:),sz,'MarkerEdgeColor',[0 .5 .5],...
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
print -dpng Fig_BR1.png -r500
print -depsc Fig_BR1.eps -r500    
return
% for n=1:nsample
%     theta = chain(end-nsample+n,1:14);
%     y0 = chain(end-nsample+n,12:14);
%     time = myFile_CN(1,:)';
%     y = ADfun(time,theta(1:14));
%     X(n,:,1) = y(:,1);
%     X(n,:,2) = y(:,2);
%     X(n,:,3) = y(:,3);
%     for i=1:3
%         subplot(3,1,i)
%         hold on
%         plot(T,y(:,i),'LineWidth',0.01,'Color',[0.7 0.7 0.7]);
%         hold off
%     end
%     pause(0.0001)
% end

% [Y_Min, Y_Max] = MinMax(nsample, chain, myFile_CN);
% for i=1:3
%     subplot(3,1,i)
%     hold on
%     plot(T,Y_Min(:,i),'LineWidth',2,'Color',[1 0 0]);
%     plot(T,Y_Max(:,i),'LineWidth',2,'Color',[1 0 0]);
%     hold off
% end

Rx1 = [T(1,:), fliplr(T(1,:))];
inBetween = [Y_Min(:,1), fliplr(Y_Max(:,1))];
fill(Rx1, inBetween, 'g');
