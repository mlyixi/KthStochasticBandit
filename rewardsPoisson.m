function [rewards, k_1Best] = rewardsPoisson( mu, param, bound, n, Kth )
    [~,I]=sort(mu,'descend');
    k_1Best=I(1:Kth-1);
    rewards=zeros(length(mu),n);
    for a=1:length(mu)
        rewards(a, :) = poissrnd(param(a), 1, n);
    end
    rewards = min(rewards, bound)/bound;
end

