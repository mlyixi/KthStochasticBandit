disp('--- Demo of bounded Poisson rewards');
% 调用顺序为demo->experiment->game->policy
Kth=2; %k-th 佳臂
n = 5000; % n为一次实验的时间序列范围,
N = 20; %  N是实验次数
fname = 'results/Poisson'; 
tsave = round(linspace(1,n,200));% 要采样的时间序列

% 奖励分布参数
param = 1:9; % Poisson各臂参数,确认各臂期望相差较大（0.1）
bound = 10;
mu = zeros(1,length(param));
for a = 1:length(param)
    p = exp(-param(a)) * param(a).^(0:(bound-1)) ./ factorial(0:(bound-1));
    p = [p, 1-sum(p)];
    mu(a) = p * (0:bound)' / bound;
end

[rewards, k_1Best] = rewardsPoisson(mu, param, bound, n, Kth);

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
