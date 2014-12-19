disp('--- Demo of Bernoulli rewards');
% ����˳��Ϊdemo->experiment->game->policy
Kth=2; %k-th �ѱ�
n = 5000; % nΪһ��ʵ���ʱ�����з�Χ,
N = 20; %  N��ʵ�����
fname = 'results/Bernoulli'; 
tsave = round(linspace(1,n,200));% Ҫ������ʱ������

% �����ֲ�����
mu = [0.5, 0.2, 0.8, 0.6, 0.9, 0.3,0.4,0.1,0.7]; %Bernoulli���ۿ����ʾ�ֵ
[rewards, k_1Best] = rewardsBernoulli(mu, n, Kth);

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
