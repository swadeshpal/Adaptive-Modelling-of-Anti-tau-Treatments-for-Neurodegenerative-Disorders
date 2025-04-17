function err = ODE_fit_u(theta_u, exp_t, u)  %%%%%% Must have theta first

    TI = Ind_int(exp_t);

    tu = solution_u(exp_t, theta_u);
    err = 0;
    for n=1:length(TI)
        err = err + (tu(TI(n))-u(n))^2;
    end
    
end