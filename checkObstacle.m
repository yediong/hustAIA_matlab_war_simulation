% 检查点是否在障碍物区域内
function isInObstacle = checkObstacle(x, y, obstacleMap)
    isInObstacle = false;
    for i = 1:size(obstacleMap, 1)
        x_min = obstacleMap(i, 1);
        x_max = obstacleMap(i, 2);
        y_min = obstacleMap(i, 3);
        y_max = obstacleMap(i, 4);
        if x >= x_min && x <= x_max && y >= y_min && y <= y_max
            isInObstacle = true;
            return;
        end
    end
end