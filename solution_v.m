function v_sol = solution_v(exp_t, theta_v, u)
    dt = 0.01;
    T = exp_t(1):dt:exp_t(end);
    
    rv = theta_v(1);
    bv = theta_v(2);
    su = theta_v(3);
    au = theta_v(4);
    hu = theta_v(5);
    v0 = theta_v(6);
    tv(1) = v0;
    for n=1:length(T)-1
        tv(n+1) = tv(n)+ dt*(rv*tv(n)-bv*tv(n)^2+su*u(n)*tv(n)/(1+au*hu*u(n)));
    end
    v_sol = tv;
end