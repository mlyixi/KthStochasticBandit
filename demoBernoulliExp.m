disp('--- Demo of Bernoulli x Exp rewards');
% ����˳��Ϊdemo->experiment->game->policy
Kth=1; %k-th �ѱ�
n = 5000; % nΪһ��ʵ���ʱ�����з�Χ,
N = 20; %  N��ʵ�����
fname = 'results/BernoulliExp'; 
tsave = round(linspace(1,n,200));% Ҫ������ʱ������

% �����ֲ�����
muB = [0.5, 0.2, 0.8, 0.6, 0.9, 0.3,0.4,0.1,0.7]; %Bernoulli���ۿ����ʾ�ֵ
param = 1./[2 9 22 35 5 1 5 3 5]; % Exp���۲���,ȷ�ϸ����������ϴ�0.1��
bound = 8;
muE = (1-exp(-param*bound))./param / bound;
mu = muB.*muE;

[rewards, k_1Best] = rewardsBernoulliExp(mu, muB, param, bound, n, Kth);

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
