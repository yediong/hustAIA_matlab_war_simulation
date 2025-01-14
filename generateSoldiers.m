% 士兵初始化部分，确保位置不重叠
function soldiers = generateSoldiers(numSoldiers, x_min, x_max, y_min, y_max, obstacleMap)
    soldiers = zeros(numSoldiers, 2);
    for i = 1:numSoldiers
        [x, y] = generateValidPosition(x_min, x_max, y_min, y_max, obstacleMap);
        soldiers(i, :) = [x, y];
    end
end

% 生成不与障碍物重叠的随机点
function [x, y] = generateValidPosition(x_min, x_max, y_min, y_max, obstacleMap)
    while true
        x = rand() * (x_max - x_min) + x_min; % 在范围内随机生成x
        y = rand() * (y_max - y_min) + y_min; % 在范围内随机生成y
        if ~checkObstacle(x, y, obstacleMap)
            break;
        end
    end
end