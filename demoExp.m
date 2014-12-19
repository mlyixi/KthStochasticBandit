disp('--- Demo of bounded Exp rewards');
% ����˳��Ϊdemo->experiment->game->policy
Kth=2; %k-th �ѱ�
n = 5000; % nΪһ��ʵ���ʱ�����з�Χ,
N = 20; %  N��ʵ�����
fname = 'results/Exp'; 
tsave = round(linspace(1,n,200));% Ҫ������ʱ������

% �����ֲ�����
param = 1./[2 9 22 35 5 1 5 3 5]; % Exp���۲���,ȷ�ϸ����������ϴ�0.1��
bound = 8;
mu = (1-exp(-param*bound))./param / bound;

[rewards, k_1Best] = rewardsExp(mu, param, bound, n, Kth);

% �ƶ���Ϸ�Ͳ���
game = Game(rewards, k_1Best); 
policies = {policyEGreedy(),policyKthUCB(),policySLK()}; 

% ʵ��
defaultStream = RandStream.getGlobalStream; %�洢���������״̬
savedState = defaultStream.State;           %�Ա����в����õĶ���ͬһ�������
for k = 1:length(policies)
    defaultStream.State = savedState;
    tic; experiment(game, n, N, mu, Kth, policies{k}, tsave, fname); toc 
end
% ��ͼ���粻����ʵ�����ʾ�ϴν����ע�͡�ʵ�顱����
plotResults(n, N, Kth, policies, fname);
