clear all

load Bayesian_Result_CN.mat

nsample = 5000;

par_ru = chain(end-nsample:end,1);
par_bu = chain(end-nsample:end,2); 

par_rv = chain(end-nsample:end,3);
par_bv = chain(end-nsample:end,4); 

par_rw = chain(end-nsample:end,8);
par_bw = chain(end-nsample:end,9); 


for n=1:length(par_ru)
    par_Ku(n) = par_ru(n)/par_bu(n);
    par_Kv(n) = par_rv(n)/par_bv(n);
end

subplot(1,4,1)
scatter(par_ru, par_bu,5)
ylabel('$b_{u}$','Interpreter', 'Latex','FontSize',18,'Color','k')
xlabel('$r_{u}$','Interpreter', 'Latex','FontSize',18,'Color','k')
text(0.087,0.000025, '(a)','FontSize',18)
box on

subplot(1,4,2)
scatter(par_ru, par_Ku,5)
ylabel('$r_{u}/b_{u}$','Interpreter', 'Latex','FontSize',18,'Color','k')
xlabel('$r_{u}$','Interpreter', 'Latex','FontSize',18,'Color','k')

text(0.087,525, '(b)','FontSize',18)
box on

subplot(1,4,3)
scatter(par_rv, par_bv,5)
ylabel('$b_{v}$','Interpreter', 'Latex','FontSize',18,'Color','k')
xlabel('$r_{v}$','Interpreter', 'Latex','FontSize',18,'Color','k')
text(0.22,0.0005, '(c)','FontSize',18)
box on

subplot(1,4,4)
scatter(par_rv, par_Kv,5)
ylabel('$r_{v}/b_{v}$','Interpreter', 'Latex','FontSize',18,'Color','k')
xlabel('$r_{v}$','Interpreter', 'Latex','FontSize',18,'Color','k')
ylim([10 65])
text(0.22,12.7, '(d)','FontSize',18)
box on

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 20 5])
print -dpng Fig_D1.png -r500
print -depsc Fig_D1.eps -r300