function [mu, sigma] = MeanStd(chain,nsample)
    Sample = chain(end-nsample:end,:);
    for n=1:length(Sample(1,:))
        mu(n) = mean(Sample(:,n));
        sigma(n) = std(Sample(:,n));
    end

end