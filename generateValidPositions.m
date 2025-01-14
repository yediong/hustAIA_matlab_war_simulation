% 生成增援士兵位置，避免移动到障碍物区域
function valid_positions = generateValidPositions(num_soldiers, x_min, x_max, y_min, y_max, obstacleMap)
    valid_positions = zeros(num_soldiers, 2); % 初始化存储合法位置的矩阵
    for i = 1:num_soldiers
        max_attempts = 100; % 最大尝试次数
        attempts = 0;
        while attempts < max_attempts
            % 随机生成一个位置
            x = x_min + rand() * (x_max - x_min);
            y = y_min + rand() * (y_max - y_min);
            
            % 检查是否与障碍物区域冲突
            if ~checkObstacle(x, y, obstacleMap)
                valid_positions(i, :) = [x, y]; % 如果合法，则记录位置
                break; % 退出循环
            end
            attempts = attempts + 1;
        end
    end
end
