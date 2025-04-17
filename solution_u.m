function u_sol = solution_u(exp_t, theta_u)
    dt = 0.01;
    T = exp_t(1):dt:exp_t(end);
    
    ru = theta_u(1);
    bu = theta_u(2);
    u0 = theta_u(3);
    tu(1) = u0;
    for n=1:length(T)-1
        tu(n+1) = tu(n)+ dt*(ru*tu(n)-bu*tu(n)^2);
    end
    u_sol = tu;
end