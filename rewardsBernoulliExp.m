function [rewards, k_1Best] = rewardsBernoulliExp( mu, muB, param, bound, n, Kth )
    [~,I]=sort(mu,'descend');
    k_1Best=I(1:Kth-1);
    RE = -(1./param'*ones(1,n)) .* log(rand(length(muB), n));
    RE = min(RE, bound)/bound;
    RB = rand(length(muB),n)<muB'*ones(1,n);
    rewards = RE.*RB;
end

