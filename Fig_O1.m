clear all

% MODEL PARAMETERS
load Bayesian_Result_AD_Plot.mat
[mu, sigma] = MeanStd(chain,nsample);
save("Mu_AD.mat","mu","time")

clear all
load Mu_AD.mat
y_sol = ADfun(time,mu(1:14));
dt = 0.01;
Time = time(1):dt:time(end);



Delta = 0.000001;    % Accepted tollerance
t0    = 56;          % Initial treatment time
tf    = t0+0.462;        % Final time
N_T   = 462;        % Number of nodes
% t0    = 60;          % Initial treatment time
% tf    = t0+5;        % Final time
% N_T   = 5000;        % Number of nodes
t     = linspace(t0, tf, N_T+1);  % Time variable where linspace creates M+1 ...equally spaced nodes between t0 and tf, including t0 and tf.
h     = t(2)-t(1);       % Spacing between nodes



test  = -1;         % Test variable; as long as variable is negative ...the while loops keeps repeating

% WEIGHT FACTORS
alpha1 = 1;             % Weight on threatened population
alpha2 = 1;             % Weigth on deceased population
eps0 = 1;
gamma = 1;
u1_mx = 1.779;

% INITIAL CONDITIONS MODEL
x1    = zeros(1, N_T+1);  % Susceptible
x2    = zeros(1, N_T+1);  % Infected - undetected
x3    = zeros(1, N_T+1);  % Infected - detected

for n=1:length(Time)
    if abs(Time(n)-t0)<0.00001
        x1(1) = y_sol(n,1);
        x2(1) = y_sol(n,2);
        x3(1) = y_sol(n,3); 
        break;
    end
end

% return

% INITIAL GUESS FOR OPTIMAL CONTROL INPUT
u1 = zeros(1, N_T+1);     % Control input
for n=1:N_T+1
    EPS(n) = eps0*exp(-gamma*(t(n)-t0));
end

% INITIAL CONDITIONS ADOINT SYSTEM
L1 = zeros(1, N_T+1);
L2 = zeros(1, N_T+1);
L3 = zeros(1, N_T+1);

L1(N_T+1) = 0;
L2(N_T+1) = alpha1;
L3(N_T+1) = alpha2;

  % FORWARD-BACKWARD SWEEP METHOD
  loopcnt = 0; % Count number of loops

 
  while(test < 0)
      loopcnt = loopcnt + 1;
      oldu1 = u1;

      oldx1 = x1;
      oldx2 = x2;
      oldx3 = x3;

      oldL1 = L1;
      oldL2 = L2;
      oldL3 = L3;

      % SYSTEM DYNAMICS
      for i = 1:N_T
          
          m11     = mu(1)*x1(i)- mu(2)*x1(i)^2;
          m12     = mu(3)*x2(i)-mu(4)*x2(i)^2+mu(5)*x1(i)*x2(i)/(mu(6)+mu(7)*x1(i))-u1(i)*x2(i);
          m13     = mu(8)*x3(i)-mu(9)*x3(i)^2+mu(10)*x1(i)*x3(i)+mu(11)*x2(i)*x3(i);
          
          x1(i+1) = x1(i) + h*m11;
          x2(i+1) = x2(i) + h*m12;
          x3(i+1) = x3(i) + h*m13;

      end
      
      % ADJOINT SYSTEM
      for i = 1:N_T % From initial to final value
          j       = N_T + 2 - i;    % From final value to initial value
          n11     = -L1(j)*(mu(1)*x1(j)- 2*mu(2)*x1(j))-L2(j)*(mu(6)*mu(5)*x1(j)*x2(j)/(mu(6)+mu(7)*x1(i))^2)-L3(j)*mu(10)*x3(j);
          n12     = -eps0*exp(-gamma*(t(j)-t0))*u1(j)-L2(j)*(mu(3)-2*mu(4)*x2(j)+mu(5)*x1(j)/(mu(6)+mu(7)*x1(j))-u1(j));
          n13     = -1-L3(j)*(mu(8)-2*mu(9)*x3(j)+mu(10)*x1(j)+mu(11)*x2(j));
          

          L1(j-1) = L1(j) - h*n11;
          L2(j-1) = L2(j) - h*n12;
          L3(j-1) = L3(j) - h*n13;

      end
      
      % OPTIMALITY CONDITIONS
      U1 = min(u1_mx, max(0, 0.5*L2.*x2./EPS));
      u1 = 0.01.*U1 + 0.99.*oldu1;

      
%       % COST FUNCTION
%       J     = c1./2*sum(x4.^2)*h + b1./2*sum(u1.^2)*h + b2./2*sum(u2.^2)*h + b3./2*sum(u3.^2)*h + c2*max(x6);
%       Cost1 = c1./2.*cumsum(x4.^2)*h;                 % Total cost of threatened population
%       Cost2 = b1./2.*cumsum(u1.^2)*h;                 % Total cost of control input u1
%       Cost3 = b2./2.*cumsum(u2.^2)*h;                 % Total cost of control input u2
%       Cost4 = b2./2.*cumsum(u3.^2)*h;                 % Total cost of control input u3
%       Cost5 = c2.*x6;                                 % Total cost of deceased population
%       J2    = Cost1 + Cost2 + Cost3 + Cost4 + Cost5;  % Cost at each time for ...plotting graphs
      % CHECK CONVERGENCE TO STOP SWEEP METHOD
      temp1  = Delta*sum(abs(u1)) - sum(abs(oldu1 - u1));

      temp2  = Delta*sum(abs(x1)) - sum(abs(oldx1 - x1));
      temp3  = Delta*sum(abs(x2)) - sum(abs(oldx2 - x2));
      temp4  = Delta*sum(abs(x3)) - sum(abs(oldx3 - x3));

      temp11 = Delta*sum(abs(L1)) - sum(abs(oldL1 - L1));
      temp12 = Delta*sum(abs(L2)) - sum(abs(oldL2 - L2));
      temp13 = Delta*sum(abs(L3)) - sum(abs(oldL3 - L3));

      test = min([temp1 temp2 temp3 temp4 temp11 temp12 temp13]);
  end
  % disp(['number of loops: ' num2str(loopcnt)]);
  
  % disp(['Cost function: ' num2str(J)]);
  
  % disp(['Portion deceased: ' num2str(max(x6))]);
  
  legend()
  hold on
% plot(t,x1,'-b','LineWidth',1.5)
plot(t,x2,'-m','LineWidth',1.5,'DisplayName','v')
plot(t,x3,':r','LineWidth',1.5,'DisplayName','w')
set(gca,'FontSize',12)
xlabel('time (years)')
plot(Time(41:188), y_sol(41:188,2))
plot(Time(41:188), y_sol(41:188,3))
box on
%  (x2(1)-x2(end))/x2(1)
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 6])
% print -depsc Fig_O2.eps -r500
% print -dpng Fig_O2.png -r500
%  plot(Time, y_sol(:,1))
% plot(Time, y_sol(:,2))
% plot(Time, y_sol(:,3))
