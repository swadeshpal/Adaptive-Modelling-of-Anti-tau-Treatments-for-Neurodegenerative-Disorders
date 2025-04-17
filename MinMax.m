function [Y_Min, Y_Max] = MinMax(nsample, chain, myFile_CN)
    for n=1:nsample
        theta = chain(end-nsample+n,1:14);
        time = myFile_CN(1,:)';
        y = ADfun(time,theta(1:14));
        X(n,:,1) = y(:,1);
        X(n,:,2) = y(:,2);
        X(n,:,3) = y(:,3);
    end
    for j=1:length(X(1,:,1))
        Y_Min(j,1) = min(X(:,j,1));
        Y_Min(j,2) = min(X(:,j,2));
        Y_Min(j,3) = min(X(:,j,3));
        
        Y_Max(j,1) = max(X(:,j,1));
        Y_Max(j,2) = max(X(:,j,2));
        Y_Max(j,3) = max(X(:,j,3));
    end
end