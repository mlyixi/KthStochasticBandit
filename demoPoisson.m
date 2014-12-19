disp('--- Demo of bounded Poisson rewards');
% ����˳��Ϊdemo->experiment->game->policy
Kth=2; %k-th �ѱ�
n = 5000; % nΪһ��ʵ���ʱ�����з�Χ,
N = 20; %  N��ʵ�����
fname = 'results/Poisson'; 
tsave = round(linspace(1,n,200));% Ҫ������ʱ������

% �����ֲ�����
param = 1:9; % Poisson���۲���,ȷ�ϸ����������ϴ�0.1��
bound = 10;
mu = zeros(1,length(param));
for a = 1:length(param)
    p = exp(-param(a)) * param(a).^(0:(bound-1)) ./ factorial(0:(bound-1));
    p = [p, 1-sum(p)];
    mu(a) = p * (0:bound)' / bound;
end

[rewards, k_1Best] = rewardsPoisson(mu, param, bound, n, Kth);

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
