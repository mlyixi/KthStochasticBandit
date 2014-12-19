classdef Policy<handle   
    properties
        % 由于各策略所需参数都不同，故这里不作定义
    end
    
    methods
        function init(self, nbActions, horizon), end % game开始时初始化
        function a = decision(self), end % 作出下一次选择
        function getReward(self, reward), end % 获取奖励并更新
    end
    
end
