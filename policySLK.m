classdef policySLK < Policy
    % 回报归一化: [0,1]
    properties
        t % 第几次选择
        lastAction % 最后一次选择
        nbActions %臂数
        N % 每臂被选择的次数
        S % 每次选择后的累计回报
        
        c = 2 % UCB参数为c=2
    end
    
    methods
        function self = policySLK()
            self.t = 1;
        end
        % 第一步,初始化
        function init(self, nbActions, ~)
            self.nbActions=nbActions;
            self.N = zeros(1, nbActions);
            self.S = zeros(1, nbActions);
        end
        % 第二步,决策
        function action = decision(self, n, Kth)
            if any(self.N==0)
                action = find(self.N==0, 1); %开始时各臂都执行一次
            else
                ucb=self.S./self.N + sqrt(self.c*log(self.t)./self.N);
                [~,iBest]=sort(ucb,'descend');
                kucb=zeros(1,Kth);
                for i=1:Kth
                    k=iBest(i);
                    kucb(i)=self.S(k)./self.N(k) - sqrt(self.c*log(self.t)./self.N(k));
                end
                [~,iworst]=min(kucb);
                action=iBest(iworst);
            end
            self.lastAction = action;
        end
        % 第三步,计算回报
        function getReward(self, reward)
            self.N(self.lastAction) = self.N(self.lastAction) + 1; 
            self.S(self.lastAction) = self.S(self.lastAction)  + reward;
            self.t = self.t + 1;
        end        
    end

end
