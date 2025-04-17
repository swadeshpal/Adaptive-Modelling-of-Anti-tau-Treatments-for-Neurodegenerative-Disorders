function [] = Bayesian_Result_CN(Time,ind)
    load CN_Out.mat
    dt = 0.01;
    T = Time(1):dt:Time(end);  
    for n=2000:2500
        au = A(n,1);	
        cu = A(n,2);		
        cv = A(n,3);		
        hu = A(n,4);		
        bu = A(n,5);		
        bv = A(n,6);		
        bw = A(n,7);		
        ru = A(n,8);		
        rv = A(n,9);		
        rw = A(n,10);		
        sigma(n) = A(n,11);		
        su = A(n,12);		
        u0 = A(n,13);		
        v0 = A(n,14);		
        w0 = A(n,15);		
%         chain(n) = A(n,16);		
%         draw(n) = A(n,17);	
        
        theta = [au cu cv hu bu bv bw ru rv rw su u0 v0 w0];
        uvw_sol = solution_uvw(Time, theta);
        if ind == 1
            if uvw_sol(2,end)>20
                plot(T, uvw_sol(1,:), '-', 'Color', [0.8 0.4 0], 'LineWidth', 0.02)
            end
        end
        if ind == 2
            if uvw_sol(2,end)>20
                plot(T, uvw_sol(2,:), '-', 'Color', [0 0 0.8], 'LineWidth', 0.02)
            end
        end
        if ind == 3
            if uvw_sol(2,end)>20
                plot(T, uvw_sol(3,:), '-r', 'LineWidth', 0.02)
            end
        end
            
    end

%     m_au = mean(au);	
%     m_cu = mean(cu);		
%     m_cv = mean(cv);		
%     m_hu = mean(hu);		
%     m_iu = mean(iu);		
%     m_iv = mean(iv);		
%     m_iw = mean(iw);		
%     m_ru = mean(ru);		
%     m_rv = mean(rv);		
%     m_rw = mean(rw);		
%     m_su = mean(su);		
%     m_xto = mean(xto);		
%     m_yto = mean(yto);		
%     m_zto = mean(zto);		
% 
%     sd_au = std(au);	
%     sd_cu = std(cu);		
%     sd_cv = std(cv);		
%     sd_hu = std(hu);		
%     sd_iu = std(iu);		
%     sd_iv = std(iv);		
%     sd_iw = std(iw);		
%     sd_ru = std(ru);		
%     sd_rv = std(rv);		
%     sd_rw = std(rw);		
%     sd_su = std(su);		
%     sd_xto = std(xto);		
%     sd_yto = std(yto);		
%     sd_zto = std(zto);	
% 
%     mu = [m_au m_cu m_cv m_hu m_iu m_iv m_iw m_ru m_rv m_rw m_su m_xto m_yto m_zto];
%     sigma = [sd_au sd_cu sd_cv sd_hu sd_iu sd_iv sd_iw sd_ru sd_rv sd_rw sd_su sd_xto sd_yto sd_zto];
end