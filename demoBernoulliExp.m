disp('--- Demo of Bernoulli x Exp rewards');
% 调用顺序为demo->experiment->game->policy
Kth=1; %k-th 佳臂
n = 5000; % n为一次实验的时间序列范围,
N = 20; %  N是实验次数
fname = 'results/BernoulliExp'; 
tsave = round(linspace(1,n,200));% 要采样的时间序列

% 奖励分布参数
muB = [0.5, 0.2, 0.8, 0.6, 0.9, 0.3,0.4,0.1,0.7]; %Bernoulli各臂空闲率均值
param = 1./[2 9 22 35 5 1 5 3 5]; % Exp各臂参数,确认各臂期望相差较大（0.1）
bound = 8;
muE = (1-exp(-param*bound))./param / bound;
mu = muB.*muE;

[rewards, k_1Best] = rewardsBernoulliExp(mu, muB, param, bound, n, Kth);

% 制定游戏和策略
game = Game(rewards, k_1Best); 
policies = {policyEGreedy(),policyKthUCB(),policySLK()}; 

% 实验
defaultStream = RandStream.getGlobalStream; %存储随机数流的状态
savedState = defaultStream.State;           %以便所有策略用的都是同一组随机数
for k = 1:length(policies)
    defaultStream.State = savedState;
    tic; experiment(game, n, N, mu, Kth, policies{k}, tsave, fname); toc 
end
% 画图，如不进行实验而显示上次结果可注释“实验”部分
plotResults(n, N, Kth, policies, fname);
