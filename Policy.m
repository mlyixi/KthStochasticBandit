classdef Policy<handle   
    properties
        % ���ڸ����������������ͬ�������ﲻ������
    end
    
    methods
        function init(self, nbActions, horizon), end % game��ʼʱ��ʼ��
        function a = decision(self), end % ������һ��ѡ��
        function getReward(self, reward), end % ��ȡ����������
    end
    
end
