clear all
load myFile_CN.txt
data.ydata = myFile_CN';

model.ssfun = @ADss;

% All parameters are constrained to be positive. The initial
% concentrations are also unknown and are treated as extra parameters.
% Sampling these parameters:
% name   start [min,max] N(mu,s^2)
params = {
    {'ru', 0.074, 0, 0.1, 0.074, 0.1}
    {'bu', 0.00008147, 0, 0.1, 0.00008147, 0.01}
    {'rv', 0.105, 0, 0.5, 0.105, 0.1}
    {'bv', 0.003514, 0, 0.1, 0.003514, 0.1}
    {'su', 0.188, 0, 1, 0.188, 0.1}
    {'au', 8.235, 0, 20, 8.235, 10}
    {'hu', 23.036, 0, 50, 23.036, 10}
    {'rw', 0.00004018, 0, 0.5, 0.00004018, 0.1}
    {'bw', 0.00439, 0, 0.1, 0.00439, 0.01}  % N(0.14, 0.2^2)1{th>0} prior
    {'cu', 0.0000656, 0, 0.1, 0.0000656, 0.01}
    {'cv', 0.00009813, 0, 0.1, 0.00009813, 0.01}
% initial values for the model states
    {'u0', 1514.308, 0, 1700, 1514.308, 500}
    {'v0', 8.914, 0, 45, 8.914, 10}
    {'w0', 3.723, 0, 40, 3.723, 10}
    };


% We assume having at least some prior information on the
% repeatability of the observation and assign rather non informational
% prior for the residual variances of the observed states. The default
% prior distribution is sigma2 ~ invchisq(S20,N0), the inverse chi
% squared distribution (see for example Gelman et al.). The 3
% components (_A_, _Z_, _P_) all have separate variances.
model.S20 = [500 25 50];
model.N0  = [100 10 15];

%%% 
% First generate an initial chain.
options.nsimu = 10000;
[results, chain, s2chain]= mcmcrun(model,data,params,options);


% Then re-run starting from the results of the previous run,
% this will take couple of minutes.
options.nsimu = 50000;
[results, chain, s2chain] = mcmcrun(model,data,params,options, results);

% % Chain plots should reveal that the chain has converged and we can
% % use the results for estimation and predictive inference.
% figure(2); clf
% mcmcplot(chain,[],results,'pairs');
% figure(3); clf
% mcmcplot(chain,[],results,'denspanel',2);
% 
% modelfun = @(d,th) ADfun(d(:,1),th(1:11),th(12:14));

data.xdata = [];
% We sample 500 parameter realizations from |chain| and |s2chain|
% and calculate the predictive plots.
nsample = 5000;
% out = mcmcpred(results,chain,s2chain,data.xdata,modelfun,nsample);
figure(1);
clf
time   = data.ydata(:,1);
dt = 0.01;
T = time(1):dt:time(end);

