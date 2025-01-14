% 定义障碍物区域
function obstacleMap = defineObstacles()
    obstacleMap = []; % 初始化障碍物坐标列表

    % 添加树木区域
    tree_positions = [
        22, 20, 5, 6; % 树1
        36, 68, 5, 6; % 树2
        64, 47, 5, 6; % 树3
        92, 8, 5, 6;  % 树4
        75, 85, 5, 6  % 树5
    ];
    for i = 1:size(tree_positions, 1)
        x_min = tree_positions(i, 1);
        y_min = tree_positions(i, 2);
        x_max = x_min + tree_positions(i, 3);
        y_max = y_min + tree_positions(i, 4);
        obstacleMap = [obstacleMap; x_min, x_max, y_min, y_max];
    end

    % 添加石块区域
    stone_positions = [
        12, 17, 1, 7;
        43, 23, 1, 7;
        56, 56, 1, 7;
        43, 78, 1, 7;
        78, 26, 1, 7;
        25, 81, 1, 7;
        67, 67, 1, 7;
        62, 17, 1, 7;
        87, 75, 1, 7;
        5, 84, 1, 7
    ];
    for i = 1:size(stone_positions, 1)
        x_min = stone_positions(i, 1);
        y_min = stone_positions(i, 2);
        x_max = x_min + stone_positions(i, 3);
        y_max = y_min + stone_positions(i, 4);
        obstacleMap = [obstacleMap; x_min, x_max, y_min, y_max];
    end

    % 添加中央障碍物区域
    obstacleMap = [obstacleMap; 47, 47 + 6, 35, 35 + 30]; % 中央石块区域

    % 添加河流区域
    obstacleMap = [obstacleMap; 0, 100, 10, 20]; % 河流从 x=0 到 x=100, y=10 到 y=20

    % 添加炮台和防御装置区域
    obstacleMap = [obstacleMap; ...
        11.5, 17, 34.5, 37; ... % 左炮台
        83.5, 89, 34.5, 37];    % 右炮台

    % 添加城墙区域
    obstacleMap = [obstacleMap; ...
        5, 5 + 10, 30, 30 + 40; ... % 左侧城墙
        85, 85 + 10, 30, 30 + 40];  % 右侧城墙
end
