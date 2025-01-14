% 更新士兵位置，避免移动到障碍物区域
function soldiers = updateSoldierPositions(soldiers, x_min, x_max, y_min, y_max, obstacleMap)
    for i = 1:size(soldiers, 1)
        max_attempts = 100; % 最大尝试次数
        attempts = 0;
        % 尝试生成新的位置，直到不与障碍物区域重叠
        while attempts < max_attempts   
            new_x = soldiers(i, 1) + (rand() * 2 - 1); % 随机移动 -1 到 1
            new_y = soldiers(i, 2) + (rand() * 2 - 1); % 随机移动 -1 到 1
            
            % 限制士兵在指定范围内
            new_x = min(max(new_x, x_min), x_max);
            new_y = min(max(new_y, y_min), y_max);

            % 检查是否与障碍物重叠
            if ~checkObstacle(new_x, new_y, obstacleMap)
                % 更新士兵位置
                soldiers(i, 1) = new_x;
                soldiers(i, 2) = new_y;
                break;
            end
            attempts = attempts + 1;
        end
    end
end
