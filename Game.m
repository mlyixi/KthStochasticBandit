classdef Game<handle
    properties
        R % ����
        nbActions % ����
        N % ����ִ�д���
        k_1Best % k-1����ѱ�
    end
    
    methods
        % ��һ��,��ʼ��game
        function self = Game(rewards,k_1Best) 
            self.R = rewards;
            self.nbActions = size(rewards,1);
            self.k_1Best = k_1Best;
        end
        % �ڶ���, ִ��game
        function [reward, action] = play(self, policy, n, Kth)
            policy.init(self.nbActions,n);
            self.N=zeros(1,self.nbActions);
            reward = zeros(1,n);
            action = zeros(1,n);
            for t = 1:n
                action(t) = policy.decision(t,Kth);
                reward(t) = self.reward(action(t));
                % ע�⣬���Խ���ý��������ǲ���������������
                policy.getReward(reward(t));
                if any(self.k_1Best==action(t))
                    reward(t)=0;
                end
            end
        end
        % ��ȡ����
        function r = reward(self, a)
            self.N(a)=self.N(a)+1;
            r = self.R(a,self.N(a)); 
        end
    end    
end
