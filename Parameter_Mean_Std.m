clear all
load Bayesian_Result_AD.mat

nsample = 5000;
[mu, sigma] = MeanStd(chain,nsample);

% y = ADfun(time,mu(1:14));


