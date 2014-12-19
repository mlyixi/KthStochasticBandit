function experiment(game, n, N, mu, Kth, policy, tsave, fname)
    if nargin<5, tsave = 1:n; end % 参数个数少于5个时默认采样时间序列间隔为1
    if nargin<6, fname = 'results/exp'; end % 参数个数少于6个时默认存储文件名
    K = length(tsave); % K为采样长度
    
    [~,I] = sort(mu,'descend');
    iBest=I(Kth);
    
    % 初始化累计回报序列: N x K 次采样
    cumReward = zeros(N, K);
    % 每次采样的各臂被选次数序列:N x K x nbActions
    nbActions=length(mu);
    cumNbPlayed = zeros(N, K, nbActions);
    % 每次采样所选臂序列： N x K 次采样
    actions = zeros(N,K);
    
    for j = 1:N
        % 进行game
        [reward, action] = game.play(policy, n, Kth);
        % 统计
        cr = cumsum(reward); % 计算前tsave次采样的累计回报
        cumReward(j, :) = cr(tsave);
        actions(j, : )=action(tsave);
        %计算前tsave次采样中,各臂被选中的次数
        for a = 1:nbActions
            ca = cumsum(action == a); 
            cumNbPlayed(j, :, a) = ca(tsave);
        end
        
        %每50次或最后一次保存变量
        if (j == N)
            fprintf('Round: %d', j);
            regret = (mu(iBest(1))*ones(N,1)*tsave)-cumReward; % 随机式bandit计算方法
            % 保存到文件
            save([fname '_n_' num2str(n) '_N_' num2str(N) '_Kth_' num2str(Kth) '_' class(policy)],...
              'mu', 'n', 'N','Kth', 'tsave', 'cumReward', 'cumNbPlayed','actions','regret');
        end
    end
    fprintf('\n');   
end
