classdef Game<handle
    properties
        R % 奖励
        nbActions % 臂数
        N % 各臂执行次数
        k_1Best % k-1个最佳臂
    end
    
    methods
        % 第一步,初始化game
        function self = Game(rewards,k_1Best) 
            self.R = rewards;
            self.nbActions = size(rewards,1);
            self.k_1Best = k_1Best;
        end
        % 第二步, 执行game
        function [reward, action] = play(self, policy, n, Kth)
            policy.init(self.nbActions,n);
            self.N=zeros(1,self.nbActions);
            reward = zeros(1,n);
            action = zeros(1,n);
            for t = 1:n
                action(t) = policy.decision(t,Kth);
                reward(t) = self.reward(action(t));
                % 注意，策略将获得奖励，但是不计算在总收益内
                policy.getReward(reward(t));
                if any(self.k_1Best==action(t))
                    reward(t)=0;
                end
            end
        end
        % 获取奖励
        function r = reward(self, a)
            self.N(a)=self.N(a)+1;
            r = self.R(a,self.N(a)); 
        end
    end    
end
