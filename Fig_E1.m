clear all

load Bayesian_Result_LMCI.mat
load myFile_LMCI.txt
data.ydata = myFile_LMCI';
nsample = 50000;

for n=1:nsample
    theta = chain(end-nsample+n,:);
    
    loss(n) = sum(ADss(theta,data));
end

return
cd PINN
load PINN_AD_out_theta.txt
cd ../
nsample = 100000;
load myFile_AD.txt
data.ydata = myFile_AD';
Data = PINN_AD_out_theta(end-nsample:end,3:end);
 for n=1:nsample
    theta(1) = Data(n,1);
    theta(2) = Data(n,2);
    theta(3) = Data(n,3);
    theta(4) = Data(n,4);
    theta(5) = Data(n,5);
    theta(7) = Data(n,6);
    theta(6) = Data(n,7);
    theta(8) = Data(n,8);
    theta(9) = Data(n,9);
    theta(10) = Data(n,10);
    theta(11) = Data(n,11);
    theta(12) = Data(n,12);
    theta(13) = Data(n,13);
    theta(14) = Data(n,14);
    
    loss(n) = sum(ADss(theta,data));
end