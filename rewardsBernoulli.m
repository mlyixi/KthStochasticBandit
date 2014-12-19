function [rewards, k_1Best] = rewardsBernoulli( mu, n, Kth)
    [~,I]=sort(mu,'descend');
    k_1Best=I(1:Kth-1);
    rewards=rand(length(mu), n) < mu'*ones(1,n);
end

