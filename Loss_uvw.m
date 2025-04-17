function loss = Loss_uvw(ydata, u, v, w)  %%%%%% Must have theta first
    time = ydata(:,1);
    TI = Ind_int(time);

    loss = 0;
    for n=1:length(TI)
        loss = loss + (u(TI(n))-ydata(n,2))^2;
%         loss = loss + (v(TI(n))-ydata(n,3))^2;
%         loss = loss + (w(TI(n))-ydata(n,4))^2;
    end
    
end