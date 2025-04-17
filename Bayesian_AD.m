clear all
load myFile_AD.txt
data.ydata = myFile_AD';

model.ssfun = @ADss;

% All parameters are constrained to be positive. The initial
% concentrations are also unknown and are treated as extra parameters.
% Sampling these parameters:
% name   start [min,max] N(mu,s^2)
params = {
    {'ru', 0.0181, 0, 0.5, 0.0181, 0.2}
    {'bu', 0.000001, 0, 0.1, 0.000001, 0.1}
    {'rv', 0.0022, 0, 1, 0.0022, 0.5}
    {'bv', 0.00045, 0, 0.1, 0.00045, 0.5}
    {'su', 0.95, 0, 2, 0.95, 0.1}
    {'au', 4.397, 0, 20, 4.397, 10}
    {'hu', 47.65, 0, 100, 47.65, 10}
    {'rw', 0.00001224, 0, 0.5, 0.00001224, 0.1}
    {'bw', 0.03, 0, 0.1, 0.03, 0.01}  
    {'cu', 0.0007047, 0, 0.1, 0.0007047, 0.01}
    {'cv', 0.0143, 0, 0.1, 0.0143, 0.01}
% initial values for the model states
    {'u0', 472.06, 0, 1700, 472.06, 500}
    {'v0', 45.39, 0, 100, 45.39, 20}
    {'w0', 24.22, 0, 60, 24.22, 20}
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

% data.xdata = [];
% We sample 500 parameter realizations from |chain| and |s2chain|
% and calculate the predictive plots.
% nsample = 5000;