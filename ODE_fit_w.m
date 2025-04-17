function err = ODE_fit_w(theta_w, exp_t, w, u, v)  %%%%%% Must have theta first

    TI = Ind_int(exp_t);

    tw = solution_w(exp_t, theta_w, u, v);
    err = 0;
    for n=1:length(TI)
        err = err + (tw(TI(n))-w(n))^2;
    end
    
end