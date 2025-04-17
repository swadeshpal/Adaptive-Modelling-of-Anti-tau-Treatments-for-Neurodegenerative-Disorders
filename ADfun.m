function y=ADfun(time,theta)
% model function

% [t,y] = ode15s(@ADsys,time,y0,theta);
% 
%     u(1) = y0(1);
%     v(1) = y0(2);
%     w(1) = y0(3);

    ru = theta(1);
    bu = theta(2);
    rv = theta(3);
    bv = theta(4);
    su = theta(5);
    au = theta(6);
    hu = theta(7);
    rw = theta(8);
    bw = theta(9);
    cu = theta(10);
    cv = theta(11);
    u(1) = theta(12);
    v(1) = theta(13);
    w(1) = theta(14);
    y(1,1) = u(1);
    y(1,2) = v(1);
    y(1,3) = w(1);

    dt = 0.01;
    T = time(end)-time(1);
    T_iter = T/dt;
    Time(1) = time(1);
    
    for m=1:T_iter
        Time(m+1) = Time(m)+dt;
        u(m+1) = u(m)+dt*(ru*u(m)-bu*u(m)^2);
        v(m+1) = v(m)+dt*(rv*v(m)-bv*v(m)^2+su*u(m)*v(m)/(au+hu*u(m)));
        w(m+1) = w(m)+dt*(rw*w(m)-bw*w(m)^2+cu*u(m)*w(m)+cv*v(m)*w(m));
        y(m+1,1) = u(m+1);
        y(m+1,2) = v(m+1);
        y(m+1,3) = w(m+1);
    end
    
%     for n=1:length(Time)+1
% %         for m=1:T_iter+1
% %             if abs(Time(m)-time(n))<0.1
%                 y(n,1) = u(n);
%                 y(n,2) = v(n);
%                 y(n,3) = w(n);
% %                 break
% %             end
% %         end
%     end
        

end
