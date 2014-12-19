function experiment(game, n, N, mu, Kth, policy, tsave, fname)
    if nargin<5, tsave = 1:n; end % ������������5��ʱĬ�ϲ���ʱ�����м��Ϊ1
    if nargin<6, fname = 'results/exp'; end % ������������6��ʱĬ�ϴ洢�ļ���
    K = length(tsave); % KΪ��������
    
    [~,I] = sort(mu,'descend');
    iBest=I(Kth);
    
    % ��ʼ���ۼƻر�����: N x K �β���
    cumReward = zeros(N, K);
    % ÿ�β����ĸ��۱�ѡ��������:N x K x nbActions
    nbActions=length(mu);
    cumNbPlayed = zeros(N, K, nbActions);
    % ÿ�β�����ѡ�����У� N x K �β���
    actions = zeros(N,K);
    
    for j = 1:N
        % ����game
        [reward, action] = game.play(policy, n, Kth);
        % ͳ��
        cr = cumsum(reward); % ����ǰtsave�β������ۼƻر�
        cumReward(j, :) = cr(tsave);
        actions(j, : )=action(tsave);
        %����ǰtsave�β�����,���۱�ѡ�еĴ���
        for a = 1:nbActions
            ca = cumsum(action == a); 
            cumNbPlayed(j, :, a) = ca(tsave);
        end
        
        %ÿ50�λ����һ�α������
        if (j == N)
            fprintf('Round: %d', j);
            regret = (mu(iBest(1))*ones(N,1)*tsave)-cumReward; % ���ʽbandit���㷽��
            % ���浽�ļ�
            save([fname '_n_' num2str(n) '_N_' num2str(N) '_Kth_' num2str(Kth) '_' class(policy)],...
              'mu', 'n', 'N','Kth', 'tsave', 'cumReward', 'cumNbPlayed','actions','regret');
        end
    end
    fprintf('\n');   
end
