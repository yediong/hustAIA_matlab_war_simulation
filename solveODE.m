function [x,y,t]=solveODE(x0, y0, u, v, r_x, r_y, p_x, p_y, s_x, s_y, alpha, beta, t_span, warType, theta)
    % 输入参数：
    % x0, y0: 初始条件
    % u, v: 常数项
    % r_x, r_y: 系统参数
    % p_x, p_y: 系统参数
    % alpha, beta: 系统参数
    % t_span: 时间范围，形式为 [t_start, t_end]
    % warType：战争类型

    % 定义常微分方程组
    % 根据战斗类型更新兵力
    if strcmp(warType, '正规战')
        ode = @(t, z) [
            u * z(2) - r_y * p_y * z(2) - alpha * z(1);  % dx/dt
            v * z(1) - r_x * p_x * z(1) - beta * z(2)   % dy/dt
        ];

    elseif strcmp(warType, '游击战')
        % 子弹命中率和敌方有效活动面积、敌方人数成正比
        p_x = s_y/(s_x + s_y);
        p_y = s_x/(s_x + s_y);

        ode = @(t, z) [
            u * z(2) - r_y * p_y * z(2) * z(1)/(z(1) + z(2)) - alpha * z(1);  % dx/dt
            v * z(1) - r_x * p_x * z(1) * z(2)/(z(1) + z(2)) - beta * z(2)   % dy/dt
        ];

    elseif strcmp(warType, '混合战')
        ode = @(t, z) [
            theta * (u * z(2) - r_y * p_y * z(2) - alpha * z(1)) + (1 - theta) * (u * z(2) - r_y * s_x/(s_x + s_y) * z(2) * z(1)/(z(1) + z(2)) - alpha * z(1));  % dx/dt
            theta * (v * z(1) - r_x * p_x * z(1) - beta * z(2)) + (1 - theta) * (v * z(1) - r_x * s_y/(s_x + s_y) * z(1) * z(2)/(z(1) + z(2)) - beta * z(2))   % dy/dt
        ];
    end

    % 使用 ode45 求解常微分方程
    [t, sol] = ode45(ode, t_span, [x0; y0]);

    % 检查是否有 x 或 y 小于 0，并在小于等于 0 时截断
    stop_idx = find(sol(:, 1) < 1 | sol(:, 2) < 1, 1); % 查找第一个x或y<0的时间点

    if ~isempty(stop_idx)
        % 截断时间点
        t_stop = t(stop_idx);
        fprintf('x(t) 或 y(t) 在 t = %.4f 时刻达到 0，曲线已截断。\n', t_stop);
        
        % 截取解和时间
        t = t(1:stop_idx);
        sol = sol(1:stop_idx, :);
    else
        % 如果没有 x 或 y 变为 0，输出正常的结束时间
        t_stop = t(end);
    end

    % 提取解
    x = sol(:, 1);
    y = sol(:, 2);
    
    % % 绘制结果（x和y在同一张图上）
    % figure;
    % plot(t, x, 'b-', 'LineWidth', 2); % x(t) 用蓝色线表示
    % hold on; % 保持当前图形，继续绘制
    % plot(t, y, 'r-', 'LineWidth', 2); % y(t) 用红色线表示
    % hold off; % 释放图形
    % 
    % % 添加图例和标题
    % title('x(t) and y(t) with constraints (x >= 0, y >= 0)');
    % xlabel('Time (t)');
    % ylabel('Values of x(t) and y(t)');
    % legend('x(t)', 'y(t)');
    % grid on;
end
