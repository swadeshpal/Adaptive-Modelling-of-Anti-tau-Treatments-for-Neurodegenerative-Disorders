clear all
load LMCI_Out.mat

for n=1:1000
    au(n) = A(n,1);	
    cu(n) = A(n,2);		
    cv(n) = A(n,3);		
    hu(n) = A(n,4);		
    iu(n) = A(n,5);		
    iv(n) = A(n,6);		
    iw(n) = A(n,7);		
    ru(n) = A(n,8);		
    rv(n) = A(n,9);		
    rw(n) = A(n,10);		
    sigma(n) = A(n,11);		
    su(n) = A(n,12);		
    xto(n) = A(n,13);		
    yto(n) = A(n,14);		
    zto(n) = A(n,15);		
    chain(n) = A(n,16);		
    draw(n) = A(n,17);	
end

m_au = mean(au);	
m_cu = mean(cu);		
m_cv = mean(cv);		
m_hu = mean(hu);		
m_iu = mean(iu);		
m_iv = mean(iv);		
m_iw = mean(iw);		
m_ru = mean(ru);		
m_rv = mean(rv);		
m_rw = mean(rw);		
m_su = mean(su);		
m_xto = mean(xto);		
m_yto = mean(yto);		
m_zto = mean(zto);		

sd_au = std(au);	
sd_cu = std(cu);		
sd_cv = std(cv);		
sd_hu = std(hu);		
sd_iu = std(iu);		
sd_iv = std(iv);		
sd_iw = std(iw);		
sd_ru = std(ru);		
sd_rv = std(rv);		
sd_rw = std(rw);		
sd_su = std(su);		
sd_xto = std(xto);		
sd_yto = std(yto);		
sd_zto = std(zto);	

histogram(ru,200,'Normalization','pdf','facecolor','blue')
