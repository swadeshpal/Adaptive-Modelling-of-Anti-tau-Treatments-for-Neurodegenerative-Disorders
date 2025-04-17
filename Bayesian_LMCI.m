clear all
load myFile_LMCI.txt
data.ydata = myFile_LMCI';

model.ssfun = @ADss;

% All parameters are constrained to be positive. The initial
% concentrations are also unknown and are treated as extra parameters.
% Sampling these parameters:
% name   start [min,max] N(mu,s^2)
params = {
    {'ru', 0.132, 0, 0.5, 0.132, 0.2}
    {'bu', 0.0001811, 0, 0.1, 0.0001811, 0.01}
    {'rv', 0.561, 0, 1, 0.561, 0.1}
    {'bv', 0.0178, 0, 0.1, 0.0178, 0.1}
    {'su', 0.0018, 0, 1, 0.0018, 0.1}
    {'au', 1.56, 0, 20, 1.56, 10}
    {'hu', 9.554, 0, 50, 9.554, 10}
    {'rw', 0.0932, 0, 0.5, 0.0932, 0.1}
    {'bw', 0.00461, 0, 0.1, 0.00461, 0.01}  % N(0.14, 0.2^2)1{th>0} prior
    {'cu', 0.0000102, 0, 0.1, 0.0000102, 0.01}
    {'cv', 0.0000443, 0, 0.1, 0.0000443, 0.01}
% initial values for the model states
    {'u0', 934.177, 0, 1700, 934.177, 500}
    {'v0', 33.347, 0, 100, 33.347, 20}
    {'w0', 17.144, 0, 60, 17.144, 20}
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

