function ss = ADss(theta,data)
% algae sum-of-squares function

    time   = data.ydata(:,1);
    ydata  = data.ydata(:,2:end);

    % 3 last parameters are the initial states
    % y0 = theta(end-2:end);
    TI = Ind_int(time);

    y_sol = ADfun(time,theta);
    
    for n=1:length(TI)
        ymodel(n,1) = y_sol(TI(1,n),1);
        ymodel(n,2) = y_sol(TI(1,n),2);
        ymodel(n,3) = y_sol(TI(1,n),3);
    end

    ss = sum((ymodel - ydata).^2)/length(TI);
return