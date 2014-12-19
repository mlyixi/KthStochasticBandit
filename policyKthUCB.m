classdef policyKthUCB < Policy
    % �ر���һ��: [0,1]
    properties
        t % �ڼ���ѡ��
        lastAction % ���һ��ѡ��
        nbActions %����
        N % ÿ�۱�ѡ��Ĵ���
        S % ÿ��ѡ�����ۼƻر�
        
        b=50 % e-greedy����beta
        c = 2 % UCB����Ϊc=2
    end
    
    methods
        function self = policyKthUCB()
            self.t = 1;
        end
        % ��һ��,��ʼ��
        function init(self, nbActions, ~)
            self.nbActions=nbActions;
            self.N = zeros(1, nbActions);
            self.S = zeros(1, nbActions);
        end
        % �ڶ���,����
        function action = decision(self, n, Kth)
            if any(self.N==0)
                action = find(self.N==0, 1); %��ʼʱ���۶�ִ��һ��
            else
                ucb=self.S./self.N + sqrt(self.c*log(self.t)./self.N);
                [~,iBest]=sort(ucb,'descend');
                kucb=zeros(1,Kth);
                for i=1:Kth
                    k=iBest(i);
                    kucb(i)=self.S(k)./self.N(k);
                end
                [~,iworst]=min(kucb);
                en=min(1,self.b*Kth/n);
                if rand(1)<=en
                    action=iBest(randi(Kth));
                else
                    action=iBest(iworst);
                end
            end
            self.lastAction = action;
        end
        % ������,����ر�
        function getReward(self, reward)
            self.N(self.lastAction) = self.N(self.lastAction) + 1; 
            self.S(self.lastAction) = self.S(self.lastAction)  + reward;
            self.t = self.t + 1;
        end        
    end

end
