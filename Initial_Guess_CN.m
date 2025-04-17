clear all
format long
load myFile_CN.txt

Time = myFile_CN(1,:);
ABeta = myFile_CN(2,:);
pTau = myFile_CN(3,:);
ADAS = myFile_CN(4,:);
dt = 0.01;
T = Time(1):dt:Time(end);  
Index = Ind_int(Time);

theta_u0 = [0.0001 0.0001 1200];
p_estimate_u = fminsearch(@(thetau) ODE_fit_u(thetau, Time, ABeta), theta_u0);
% disp(p_estimate_u)
u = solution_u(T, p_estimate_u);

subplot(3,1,1)
scatter(Time, ABeta, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
plot(T, u, '-r', 'LineWidth', 2)
box on
ylabel('ABeta','Interpreter', 'Latex','FontSize',14,'Color','k')
% xlabel('$Age$','Interpreter', 'Latex','FontSize',14,'Color','k')

theta_v0 = [0.15 0.01 0.1 20 20 60.0];
p_estimate_v = fminsearch(@(thetav) ODE_fit_v(thetav, Time, pTau, u), theta_v0);
v = solution_v(T, p_estimate_v, u);

subplot(3,1,2)
scatter(Time, pTau, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
plot(T, v, '-r', 'LineWidth', 2)
box on
ylabel('pTau','Interpreter', 'Latex','FontSize',14,'Color','k')
% xlabel('$Age$','Interpreter', 'Latex','FontSize',14,'Color','k')


theta_w0 = [0.0002 0.005 0.001 0.0001 10.0];
p_estimate_w = fminsearch(@(thetaw) ODE_fit_w(thetaw, Time, ADAS, u, v), theta_w0);
w = solution_w(T, p_estimate_w, u, v);

subplot(3,1,3)
scatter(Time, ADAS, 10, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
hold on
plot(T, w, '-r', 'LineWidth', 2)
box on
ylabel('ADAS','Interpreter', 'Latex','FontSize',14,'Color','k')
xlabel('$Age$','Interpreter', 'Latex','FontSize',14,'Color','k')

% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3 8])
% print -dpng Fig_I1.png -r500
% print -depsc Fig_I1.eps -r300

