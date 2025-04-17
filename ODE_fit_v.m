function err = ODE_fit_v(theta_v, exp_t, v, u)  %%%%%% Must have theta first

    TI = Ind_int(exp_t);

    tv = solution_v(exp_t, theta_v, u);
    err = 0;
    for n=1:length(TI)
        err = err + (tv(TI(n))-v(n))^2;
    end
    
end