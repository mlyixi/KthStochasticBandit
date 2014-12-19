function [rewards, k_1Best] = rewardsExp( mu, param, bound, n, Kth )
    [~,I]=sort(mu,'descend');
    k_1Best=I(1:Kth-1);
    rewards = -(1./param'*ones(1,n)) .* log(rand(length(mu), n));
    rewards = min(rewards, bound)/bound;
end

