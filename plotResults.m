function plotResults(n, N,Kth, policies, fname) 
    l = length(policies);
    clf;
    
    % y轴值
    ar = -Inf;
    ad = -Inf;
    for i = 1:l
        % 加载保存的结果并计算损失
        load([fname '_n_' num2str(n) '_N_' num2str(N) '_Kth_' num2str(Kth) '_' class(policies{i})],...
            'n','N','Kth','tsave','cumReward','cumNbPlayed','mu','actions','regret');
        policyName = class(policies{i}); policyName = policyName(7:end);
        oneAction=actions(1, :);
        lastNbPlayed=round(mean(squeeze(cumNbPlayed(:,end,:))));
        
        % 画出损失
        risk1 = 25; % Plot quartiles (dark grey)
        risk2 = 5;   % upper 5 percents quantile (light grey)
        subplot(2,l,i);
        h = area(tsave, [prctile(regret, risk1);...
            prctile(regret, 100-risk1)- prctile(regret, risk1);...
            prctile(regret, 100-risk2)- prctile(regret, 100-risk1)]');
        set(h(1),'Visible', 'off');
        set(h(2),'FaceColor', [0.85 0.85 0.85]);
        set(h(3),'FaceColor', [0.95 0.95 0.95]);
        set(h,'edgecolor','white');
        hold on; 
        
        h = plot(tsave, mean(regret), 'k',...
            tsave,prctile(regret,risk1),'b',...
            tsave,prctile(regret,100-risk1),'g',...
            tsave,prctile(regret,100-risk2),'r');
        legend(h,'mean regret','25th percentile','75th percentile','95th percentile');
        set(h(1), 'LineWidth', 2);
        xlabel('time', 'FontSize', 8);
        if (i == 1), ylabel('regret'); end
        set(gca, 'FontSize', 8);
        tmp = axis; ar = max(ar, tmp(4));
        
        subplot(2,l,l+i)
        h=bar(lastNbPlayed,'FaceColor',[0.8,0.8,0.8]);
        xlabel('arm', 'FontSize', 8);
        if (i == 1), ylabel('average selected times'); end
        set(gca, 'FontSize', 8);
    end
    % 修正y轴
    for i = 1:l
      subplot(2,l,i);
      axis([0 tsave(end) 0 ar]);
    end
end