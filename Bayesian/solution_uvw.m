function uvw_sol = solution_uvw(exp_t, theta)
    dt = 0.01;
    T = exp_t(1):dt:exp_t(end);
    
    au = theta(1);
    cu = theta(2);
    cv = theta(3);
    hu = theta(4);
    bu = theta(5);
    bv = theta(6);
    bw = theta(7);
    ru = theta(8);
    rv = theta(9);
    rw = theta(10);
    su = theta(11);
    u0 = theta(12);
    v0 = theta(13);
    w0 = theta(14);
    
%     ru = 0.14004991948604584; 
%     bu = 0.00013106623373460025; 
%     rv = 0.0005300231860019267;
%     bv = 0.00020639185095205903;
%     su = 0.07752789556980133;
%     hu = 23.472871780395508;
%     au = 8.61433219909668;
%     rw = 0.00013348863285500556;
%     bw = 0.013825441710650921;
%     cu = 0.00013347271305974573;
%     cv = 0.0001286710612475872;
%     u0 = 1004.4829711914062;
%     v0 = 23.297739028930664;
%     w0 = 10.0;

    
    tu(1) = u0;
    tv(1) = v0;
    tw(1) = w0;
    for n=1:length(T)-1
        tu(n+1) = tu(n)+ dt*(ru*tu(n)-bu*tu(n)^2);
        tv(n+1) = tv(n)+ dt*(rv*tv(n)-bv*tv(n)^2+su*tu(n)*tv(n)/(1+au*hu*tu(n)));
        tw(n+1) = tw(n)+ dt*(rw*tw(n)-bw*tw(n)^2+cu*tu(n)*tw(n)+cv*tv(n)*tw(n));
    end
    uvw_sol(1,:) = tu;
    uvw_sol(2,:) = tv;
    uvw_sol(3,:) = tw;
end