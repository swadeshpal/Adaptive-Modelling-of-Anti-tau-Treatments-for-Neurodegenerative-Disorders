function TI = Ind_int(exp_t)
%     t = exp_t(1);
%     tp = exp_t(1);
%     Is = 1;
%     Index = 1;
%     for n=2:length(exp_t)
%         if tp<exp_t(n)
%             Is = Is+1;
%             t = [t exp_t(n)];
%             tp = exp_t(n);
%         end
%         Index = [Index Is];
%     end
    dt = 0.01;
    T = exp_t(1):dt:exp_t(end); 
    TI = [];
    for m=1:length(exp_t)
        for n=1:length(T)
            if abs(T(n)-exp_t(m))<0.001
                TI = [TI n];
                break;
            end
        end
    end
end