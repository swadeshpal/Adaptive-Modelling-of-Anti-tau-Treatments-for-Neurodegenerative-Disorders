clear all
format long
load myFile_AD.txt



Time = myFile_AD(1,:);
ABeta = myFile_AD(2,:);
pTau = myFile_AD(3,:);
ADAS = myFile_AD(4,:);
dt = 0.01;
T = Time(1):dt:Time(end);  
Index = Ind_int(Time);

lb_u0 = [0.00001 0.000001 100];
ub_u0 = [1 1 1500];
theta_u0 = [0.0001 0.01 1200];
p_estimate_u = fmincon(@(thetau) ODE_fit_u(thetau, Time, ABeta), theta_u0, [], [], [], [], lb_u0, ub_u0);
% disp(p_estimate_u)
u = solution_u(T, p_estimate_u);

figure(1)
scatter(Time, ABeta, '*b');
hold on
plot(T, u, '-r', 'LineWidth', 2)

lb_v0 = [0.0015 0.0001 0.001 1 1 2.0];
ub_v0 = [1 1 1 50 50 60.0];

theta_v0 = [0.15 0.01 0.1 5 10 40.0];
p_estimate_v = fmincon(@(thetav) ODE_fit_v(thetav, Time, pTau, u), theta_v0, [], [], [], [], lb_v0, ub_v0);
v = solution_v(T, p_estimate_v, u);

figure(2)
scatter(Time, pTau, '*b');
hold on
plot(T, v, '-r', 'LineWidth', 2)

lb_w0 = [0.000001 0.000005 0.00001 0.000001 1.0];
ub_w0 = [1 1 1 1 50.0];

theta_w0 = [0.02 0.05 0.01 0.001 20.0];
p_estimate_w = fmincon(@(thetaw) ODE_fit_w(thetaw, Time, ADAS, u, v), theta_w0, [], [], [], [], lb_w0, ub_w0);
w = solution_w(T, p_estimate_w, u, v);

figure(3)
scatter(Time, ADAS, '*b');
hold on
plot(T, w, '-r', 'LineWidth', 2)