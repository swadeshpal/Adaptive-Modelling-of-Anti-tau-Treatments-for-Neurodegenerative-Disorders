function w_sol = solution_w(exp_t, theta_w, u, v)
    dt = 0.01;
    T = exp_t(1):dt:exp_t(end);
    
    rw = theta_w(1);
    bw = theta_w(2);
    cu = theta_w(3);
    cv = theta_w(4);
    w0 = theta_w(5);
    tw(1) = w0;
    for n=1:length(T)-1
        tw(n+1) = tw(n)+ dt*(rw*tw(n)-bw*tw(n)^2+cu*u(n)*tw(n)+cv*v(n)*tw(n));
    end
    w_sol = tw;
end