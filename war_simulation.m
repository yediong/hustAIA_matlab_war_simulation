function war_simulation()
    clc; %清除命令
    
    % 初始化全局变量
    simulation_running = false; % 仿真运行标志

    % 初始化界面
    f = figure('Name', '战争模型', 'NumberTitle', 'off', 'Position', [100, 100, 1000, 600], 'Color', [0.8, 0.9, 1]);

    space = 0;
    space1 = 25;

    % 绘图
    uicontrol('Style', 'text', 'Position', [95, 550, 100, 30], 'String', '甲方', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    uicontrol('Style', 'text', 'Position', [95, 270, 100, 30], 'String', '乙方', 'FontSize', 12, 'ForegroundColor', [1,0,0]);


    % 参数输入部分（设置默认值）
    warTypeInput = uicontrol('Style', 'popupmenu', 'Position', [890, 550, 80, 25], 'String', {'正规战', '游击战', '混合战'}, 'Value', 2, 'FontSize', 12); % 默认值为游击战

    uicontrol('Style', 'text', 'Position', [10+space1, 510-space, 100, 25], 'String', '兵力(人)', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    x0_input = uicontrol('Style', 'edit', 'Position', [120+space1, 510, 100, 25], 'String', '2000', 'FontSize', 12); 

    uicontrol('Style', 'text', 'Position', [10+space1, 230-space, 100, 25], 'String', '兵力(人)', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    y0_input = uicontrol('Style', 'edit', 'Position', [120+space1, 230, 100, 25], 'String', '1300', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 475-space, 100, 25], 'String', '增援率u', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    u_input = uicontrol('Style', 'edit', 'Position', [120+space1, 475, 100, 25], 'String', '0.01', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 195-space, 100, 25], 'String', '增援率v', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    v_input = uicontrol('Style', 'edit', 'Position', [120+space1, 195, 100, 25], 'String', '0.02', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 440-space, 100, 25], 'String', '非战斗减员率α', 'FontSize', 11, 'ForegroundColor', [0,0,1]);
    alpha_input = uicontrol('Style', 'edit', 'Position', [120+space1, 440, 100, 25], 'String', '0.01', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 160-space, 100, 25], 'String', '非战斗减员率β', 'FontSize', 11, 'ForegroundColor', [1,0,0]);
    beta_input = uicontrol('Style', 'edit', 'Position', [120+space1, 160, 100, 25], 'String', '0.01', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 405-space, 100, 25], 'String', '射击率r_x', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    r_x_input = uicontrol('Style', 'edit', 'Position', [120+space1, 405, 100, 25], 'String', '0.8', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 125-space, 100, 25], 'String', '射击率r_y', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    r_y_input = uicontrol('Style', 'edit', 'Position', [120+space1, 125, 100, 25], 'String', '0.7', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 370-space, 100, 25], 'String', '命中率p_x', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    p_x_input = uicontrol('Style', 'edit', 'Position', [120+space1, 370, 100, 25], 'String', '0.2', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 90-space, 100, 25], 'String', '命中率p_y', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    p_y_input = uicontrol('Style', 'edit', 'Position', [120+space1, 90, 100, 25], 'String', '0.5', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 335-space, 100, 25], 'String', '活动面积s_x', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    s_x_input = uicontrol('Style', 'edit', 'Position', [120+space1, 335, 100, 25], 'String', '60', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [10+space1, 55-space, 100, 25], 'String', '活动面积s_y', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    s_y_input = uicontrol('Style', 'edit', 'Position', [120+space1, 55, 100, 25], 'String', '80', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [650, 550, 103, 24], 'String', '持续时间(h)', 'FontSize', 12, 'ForegroundColor', [0,0,0]);
    t_set_input = uicontrol('Style', 'edit', 'Position', [760, 550, 100, 24], 'String', '100', 'FontSize', 12);

    uicontrol('Style', 'text', 'Position', [650, 550-30, 103, 24], 'String', '混合战比例', 'FontSize', 12, 'ForegroundColor', [0,0,0]);
    theta_input = uicontrol('Style', 'edit', 'Position', [760, 550-30, 100, 24], 'String', '0.5', 'FontSize', 12);

    uicontrol('Style', 'pushbutton', 'Position', [872, 492, 100, 35], 'String', '随机参数', 'Callback', @randomizeParameters, 'FontSize', 14);

    uicontrol('Style', 'pushbutton', 'Position', [860, 440, 120, 45], 'String', '开始模拟', 'Callback', @start_simulation, 'FontSize', 16);


    % 参数显示部分
    uicontrol('Style', 'text', 'Position', [660, 480, 83, 24], 'String', '甲方人数：', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    uicontrol('Style', 'text', 'Position', [660, 450, 83, 24], 'String', '乙方人数：', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    uicontrol('Style', 'text', 'Position', [660, 420, 83, 24], 'String', '时间(h)：', 'FontSize', 12, 'ForegroundColor', [0,0,0]);
    uicontrol('Style', 'text', 'Position', [745, 480, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
    uicontrol('Style', 'text', 'Position', [745, 450, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
    uicontrol('Style', 'text', 'Position', [745, 420, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [0,0,0]);


    %% 画战场

    % 创建背景层
    ax1 = axes(f, 'Position', [0.3, 0.1, 0.65, 0.45]); % 战场模拟
    axis(ax1, [0 100 0 100]);
    hold(ax1, 'on'); 
    title(ax1, '战场模拟');
    
    % 草地背景
    rectangle('Position', [0, 0, 100, 100], 'FaceColor', [0.4, 0.8, 0.3], 'EdgeColor', 'k'); 

    % 添加左右分界线
    line(ax1, [50 50], [0 100], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 0.5);
    

    % 左侧阵地：城墙、炮台
    rectangle(ax1, 'Position', [5, 30, 10, 40], 'FaceColor', [0.6, 0.8, 0.6], 'EdgeColor', 'k'); % 左侧城墙

    % 炮台底座
    fill(ax1, [11.5, 12.5, 16, 17], [34.5, 37, 37, 34.5], [0.3, 0.3, 0.3], 'EdgeColor', 'k'); % 梯形底座
    rectangle(ax1, 'Position', [12, 35, 4, 2], 'Curvature', [1, 1], 'FaceColor', [0.4, 0.4, 0.4], 'EdgeColor', 'k'); % 圆形平台
    
    % 炮管底部连接
    fill(ax1, [13.5, 14, 14.5, 14], [36, 37, 36, 35], [0.5, 0.5, 0.5], 'EdgeColor', 'k'); % 炮管支架
    
    % 炮身
    rectangle(ax1, 'Position', [13.8, 37.5, 2.5, 0.5], 'FaceColor', [0.6, 0.6, 0.6], 'EdgeColor', 'k'); % 炮身主干
    plot(ax1, [14, 16], [37.75, 37.75], 'k-', 'LineWidth', 1); % 炮身装饰线
    rectangle(ax1, 'Position', [16.3, 37.6, 0.4, 0.4], 'Curvature', [1, 1], 'FaceColor', [0.2, 0.2, 0.2], 'EdgeColor', 'k'); % 炮口
    
    % 炮台支撑结构
    line(ax1, [12, 16], [35, 34.5], 'Color', 'k', 'LineWidth', 2); % 左侧支撑
    line(ax1, [14, 15], [35, 34.5], 'Color', 'k', 'LineWidth', 2); % 右侧支撑


    % 右侧阵地：城墙、炮台
    rectangle(ax1, 'Position', [85, 30, 10, 40], 'FaceColor', [0.8, 0.6, 0.6], 'EdgeColor', 'k'); % 右侧城墙    
    
    % 炮台底座
    fill(ax1, [83.5, 84.5, 88, 89], [34.5, 37, 37, 34.5], [0.3, 0.3, 0.3], 'EdgeColor', 'k'); % 梯形底座
    rectangle(ax1, 'Position', [84, 35, 4, 2], 'Curvature', [1, 1], 'FaceColor', [0.4, 0.4, 0.4], 'EdgeColor', 'k'); % 圆形平台
    
    % 炮管底部连接
    fill(ax1, [86.5, 86, 85.5, 86], [36, 37, 36, 35], [0.5, 0.5, 0.5], 'EdgeColor', 'k'); % 炮管支架（方向反向）
    
    % 炮身
    rectangle(ax1, 'Position', [84.8, 37.5, 2.5, 0.5], 'FaceColor', [0.6, 0.6, 0.6], 'EdgeColor', 'k'); % 炮身主干
    plot(ax1, [84, 86], [37.75, 37.75], 'k-', 'LineWidth', 1); % 炮身装饰线
    rectangle(ax1, 'Position', [83.3, 37.6, 0.4, 0.4], 'Curvature', [1, 1], 'FaceColor', [0.2, 0.2, 0.2], 'EdgeColor', 'k'); % 炮口
    
    % 炮台支撑结构
    line(ax1, [84, 88], [35, 34.5], 'Color', 'k', 'LineWidth', 2); % 左侧支撑
    line(ax1, [86, 87], [35, 34.5], 'Color', 'k', 'LineWidth', 2); % 右侧支撑

    
    % 中央石块
    rectangle(ax1, 'Position', [47, 35, 6, 30], 'FaceColor', [0.7, 0.7, 0.7], 'EdgeColor', 'k');
    
    % 添加石块（灰色方块）
    rectangle(ax1, 'Position', [12, 17, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [43, 23, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [56, 56, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [43, 78, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [78, 26, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [25, 81, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [67, 67, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [62, 17, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [87, 75, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');
    rectangle(ax1, 'Position', [5, 84, 1, 7], 'Curvature', [0.2, 0.2], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');

    % 添加树木（绿色小圆形）
    drawTree(ax1, 24.5, 16, 1, 4, 22, 20, 5, 6);
    drawTree(ax1, 38.5, 64, 1, 4, 36, 68, 5, 6);
    drawTree(ax1, 66.5, 43, 1, 4, 64, 47, 5, 6);
    drawTree(ax1, 94.5, 4, 1, 4, 92, 8, 5, 6);
    drawTree(ax1, 77.5, 81, 1, 4, 75, 85, 5, 6);
        
    % 添加草丛
    grass_positions = [...
        10, 15;  
        20, 35;  
        30, 25;  
        40, 50;  
        50, 10;  
        60, 30;  
        70, 20;  
        80, 40;  
        90, 15;  
        25, 60   
    ];
    
    % 绘制绿色草丛
    for i = 1:size(grass_positions, 1)
        plot(ax1, grass_positions(i, 1), grass_positions(i, 2), 'g*'); 
    end

    % 左侧城墙上增加防御装置
    for i = 1:4
        x = 5 + i * 2;
        y = 65 + mod(i, 2) * 5;
        plot(ax1, [x, x+3], [y, y-5], 'k-', 'LineWidth', 2);
    end
    
    % 右侧城墙上增加防御装置
    for i = 1:4
        x = 85 + i * 2;
        y = 65 + mod(i, 2) * 5;
        plot(ax1, [x, x-3], [y, y-5], 'k-', 'LineWidth', 2);
    end
    
    % 绘制弯曲的河流
    river_x = [0, 20, 40, 60, 80, 100];
    river_y = [10, 15, 10, 15, 10, 20];
    fill(ax1, river_x, river_y, [0.2, 0.5, 0.9], 'EdgeColor', 'none');
    
    % 添加桥梁
    plot(ax1, [48, 52], [15, 12], 'k-', 'LineWidth', 5);
    
    hold(ax1, 'off');

    %% 兵力曲线初始化
    ax2 = axes(f, 'Position', [0.3, 0.65, 0.3, 0.3]); % 兵力变化
    xlabel(ax2, '时间');
    ylabel(ax2, '兵力');
    title(ax2, '兵力变化曲线');


    %% 创建动态层，每帧刷新
    ax3 = axes(f, 'Position', [0.3, 0.1, 0.65, 0.45]); % 动态层
    axis(ax3, [0 100 0 100]);
    hold(ax3, 'on');
    ax3.Color = 'none'; % 动态层透明，显示底层背景
    ax3.XColor = 'none'; % 隐藏动态层的坐标轴
    ax3.YColor = 'none';
    
    % 一键清屏按钮
    uicontrol('Style', 'pushbutton', 'Position', [872, 397, 100, 35], 'String', '一键清屏', 'Callback', @(src, event) clean_ax(ax2,ax3), 'FontSize', 14);

    %% 仿真启动函数
    function start_simulation(~,~)
        simulation_running = true; % 标志仿真是否正在运行

        % 获取输入数据
        selectedIndex = warTypeInput.Value;  % 获取选中的索引
        warType = warTypeInput.String{selectedIndex};  % 根据索引获取对应的战斗类型
        x0 = str2double(x0_input.String); % 甲方初始兵力
        y0 = str2double(y0_input.String); % 乙方初始兵力
        u = str2double(u_input.String); % 甲方增援率u
        v = str2double(v_input.String); % 乙方增援率v
        alpha = str2double(alpha_input.String); % 甲方非战斗减员率α
        beta = str2double(beta_input.String); % 乙方非战斗减员率β
        r_x = str2double(r_x_input.String); % 甲方射击率r_x
        r_y = str2double(r_y_input.String); % 乙方射击率r_y
        p_x = str2double(p_x_input.String); % 甲方命中率p_x
        p_y = str2double(p_y_input.String); % 乙方命中率p_y      
        s_x = str2double(s_x_input.String); % 甲方有效活动面积s_x
        s_y = str2double(s_y_input.String); % 乙方有效活动面积s_y  
        t_set = str2double(t_set_input.String); % 战争持续时间t_set
        theta = str2double(theta_input.String); % 混合战中的正规战占比
        t_span = [0, t_set];  % 时间范围
        
        % 清除原有图像
        cla(ax3); % 清除士兵位置图像
        cla(ax2); % 清除兵力变化图像

        % 清除上一轮获胜方
        uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '        ', 'FontSize', 20, 'ForegroundColor',[1,0,0],'BackgroundColor', [0.8,0.9,1]);

        %% 输入范围限制，error弹窗设置
        if x0 <= 0
            errordlg('甲方初始兵力必须大于0！', '错误');
            return;  % 退出仿真
        elseif x0 > 10000000
            errordlg('甲方初始兵力不得大于一千万！', '错误');
            return;  % 退出仿真
        elseif y0 <= 0
            errordlg('乙方初始兵力必须大于0！', '错误');
            return;  % 退出仿真
        elseif y0 > 10000000
            errordlg('乙方初始兵力不得大于一千万！', '错误');
            return;  % 退出仿真
        elseif u < 0
            errordlg('甲方增援率不得小于0！', '错误');
            return;  % 退出仿真
        elseif u > 1
            errordlg('甲方增援率不得大于1！', '错误');
            return;  % 退出仿真    
        elseif v < 0
            errordlg('乙方增援率不得小于0！', '错误');
            return;  % 退出仿真
        elseif v > 1
            errordlg('乙方增援率不得大于1！', '错误');
            return;  % 退出仿真  
        elseif alpha < 0
            errordlg('甲方非战斗减员率α不得小于0！', '错误');
            return;  % 退出仿真
        elseif beta < 0
            errordlg('乙方非战斗减员率β不得小于0！', '错误');
            return;  % 退出仿真
        elseif r_x < 0
            errordlg('甲方射击率不得小于0！', '错误');
            return;  % 退出仿真
        elseif r_x > 1
            errordlg('甲方射击率不得大于1！', '错误');
            return;  % 退出仿真
        elseif r_y < 0
            errordlg('乙方射击率不得小于0！', '错误');
            return;  % 退出仿真
        elseif r_y > 1
            errordlg('乙方射击率不得大于1！', '错误');
            return;  % 退出仿真
        elseif p_x < 0
            errordlg('甲方命中率不得小于0！', '错误');
            return;  % 退出仿真
        elseif p_x > 1
            errordlg('甲方命中率不得大于1！', '错误');
            return;  % 退出仿真   
        elseif p_y < 0
            errordlg('乙方命中率不得小于0！', '错误');
            return;  % 退出仿真
        elseif p_y > 1
            errordlg('乙方命中率不得大于1！', '错误');
            return;  % 退出仿真  
        elseif s_x <= 0
            errordlg('甲方有效活动面积不得小于等于0！', '错误');
            return;  % 退出仿真
        elseif s_y <= 0
            errordlg('乙方有效活动面积不得小于等于0！', '错误');
            return;  % 退出仿真
        end


        %% 调用ode求解器函数
        [x_t,y_t,t] = solveODE(x0, y0, u, v, r_x, r_y, p_x, p_y, s_x, s_y, alpha, beta, t_span, warType, theta);

        % 定义障碍物区域
        obstacleMap = defineObstacles();
        
        % 初始化士兵位置
        soldiers_A = generateSoldiers(x0, 0, 50, 0, 100, obstacleMap); % 甲方士兵
        soldiers_B = generateSoldiers(y0, 50, 100, 0, 100, obstacleMap); % 乙方士兵

        % 初始化士兵人数
        uicontrol('Style', 'text', 'Position', [745, 480, 95, 24], 'String', x0, 'FontSize', 12, 'ForegroundColor', [0,0,1]);
        uicontrol('Style', 'text', 'Position', [745, 450, 95, 24], 'String', y0, 'FontSize', 12, 'ForegroundColor', [1,0,0]);
        uicontrol('Style', 'text', 'Position', [745, 420, 95, 24], 'String', '0', 'FontSize', 12, 'ForegroundColor', [0,0,0]);

        % 创建士兵图形
        h_A = plot(ax3, soldiers_A(:,1), soldiers_A(:,2), '.b');
        hold(ax3, 'on');
        h_B = plot(ax3, soldiers_B(:,1), soldiers_B(:,2), '.r');
        axis(ax3, [0 100 0 100]);
        title(ax3, '战场模拟');

        % 兵力变化曲线
        h_plot_NA = plot(ax2, t, x_t, 'b-', 'LineWidth', 2);
        hold(ax2, 'on');
        h_plot_NB = plot(ax2, t, y_t, 'r-', 'LineWidth', 2);
        yline(ax2, 0, 'k--', 'LineWidth', 1);
        xlabel(ax2, '时间');
        ylabel(ax2, '兵力');
        title(ax2, '兵力变化曲线');

        pause(0.1);  % 控制动画帧率

        %% 动画过程
        for i = 2:length(t)
            % 检查主窗口是否存在、是否一键清屏
            if ~isvalid(f) || ~simulation_running  
                break;  % 退出仿真循环
            end

            % 更新士兵数量，取整
            x_t(i) = floor(x_t(i));
            y_t(i) = floor(y_t(i));

            % 更新甲方士兵数量
            if x_t(i) > size(soldiers_A, 1)
                % 士兵数量增加，追加新士兵
                num_new_soldiers = x_t(i) - size(soldiers_A, 1); % 需要新增的士兵数量
                new_soldiers_A = generateValidPositions(num_new_soldiers, 0, 50, 0, 100, obstacleMap); % 生成合法位置的新增士兵
                soldiers_A = [soldiers_A; new_soldiers_A];
            else
                % 士兵数量减少，裁剪多余士兵
                soldiers_A = soldiers_A(1:x_t(i), :);
            end
            
            % 更新乙方士兵数量
            if y_t(i) > size(soldiers_B, 1)
                % 士兵数量增加，追加新士兵
                num_new_soldiers = y_t(i) - size(soldiers_B, 1); % 需要新增的士兵数量
                new_soldiers_B = generateValidPositions(num_new_soldiers, 50, 100, 0, 100, obstacleMap); % 生成合法位置的新增士兵
                soldiers_B = [soldiers_B; new_soldiers_B];
            else
                % 士兵数量减少，裁剪多余士兵
                soldiers_B = soldiers_B(1:y_t(i), :);
            end

            % 确保士兵数量不为负
            if x_t(i) < 0
                x_t(i) = 0;
            elseif y_t(i) < 0
                y_t(i) = 0;
            end

            % 更新甲方士兵位置
            soldiers_A = updateSoldierPositions(soldiers_A, 0, 50, 0, 100, obstacleMap);
        
            % 更新乙方士兵位置
            soldiers_B = updateSoldierPositions(soldiers_B, 50, 100, 0, 100, obstacleMap);

            % 保持士兵在边界内
            soldiers_A(:,1) = max(soldiers_A(:,1), 0);
            soldiers_A(:,2) = max(soldiers_A(:,2), 0);
            soldiers_B(:,1) = min(soldiers_B(:,1), 100);
            soldiers_B(:,2) = min(soldiers_B(:,2), 100);

            % 更新图形
            if simulation_running
                set(h_A, 'XData', soldiers_A(:,1), 'YData', soldiers_A(:,2));
                set(h_B, 'XData', soldiers_B(:,1), 'YData', soldiers_B(:,2));
                set(h_plot_NA, 'YData', x_t);
                set(h_plot_NB, 'YData', y_t);
            else
                break;
            end

            % 刷新实时人数和持续时间
            uicontrol('Style', 'text', 'Position', [745, 480, 95, 24], 'String', x_t(i), 'FontSize', 12, 'ForegroundColor', [0,0,1]);
            uicontrol('Style', 'text', 'Position', [745, 450, 95, 24], 'String', y_t(i), 'FontSize', 12, 'ForegroundColor', [1,0,0]);
            uicontrol('Style', 'text', 'Position', [745, 420, 95, 24], 'String', t(i), 'FontSize', 12, 'ForegroundColor', [0,0,0]);

            drawnow;

            pause(0.1);  % 控制动画帧率

            %% 仿真结束条件，输出获胜方
            % 第一种情形，未到达设定时间，某方被全歼
            if x_t(i) == 0 && y_t(i) > 0
                uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '乙方获胜！', 'FontSize', 24, 'ForegroundColor',[1,0,0],'BackgroundColor', [0.8,0.9,1]);
                simulation_running = false;
                break;
            elseif y_t(i) == 0 && x_t(i) > 0
                uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '甲方获胜！', 'FontSize', 24, 'ForegroundColor',[0,0,1],'BackgroundColor', [0.8,0.9,1]);
                simulation_running = false;
                break;
            elseif x_t(i) == 0 && y_t(i) == 0
                uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '无人生还！', 'FontSize', 24, 'ForegroundColor',[0,0,0],'BackgroundColor', [0.8,0.9,1]);
                simulation_running = false;
                break;
            end

            % 第二种情形，已到达设定时间
            if t(i) >= t_set
                if x_t(i) > y_t(i)
                    uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '甲方获胜！', 'FontSize', 24, 'ForegroundColor',[0,0,1],'BackgroundColor', [0.8,0.9,1]);
                    simulation_running = false;
                    break;
                elseif x_t(i) < y_t(i)
                    uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '乙方获胜！', 'FontSize', 24, 'ForegroundColor',[1,0,0],'BackgroundColor', [0.8,0.9,1]);
                    simulation_running = false;
                    break;
                else
                    uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '势均力敌！', 'FontSize', 24, 'ForegroundColor',[0,0,0],'BackgroundColor', [0.8,0.9,1]);
                    simulation_running = false;
                    break;
                end
            end
        end
    end

    %% 一键清屏回调函数
    function clean_ax(ax2,ax3)
        % 停止仿真
        simulation_running = false;

        % 清除动态层中的所有内容
        cla(ax3); 
        cla(ax2);

        % 刷新数据
        uicontrol('Style', 'text', 'Position', [705, 347, 200, 50], 'String', '        ', 'FontSize', 20, 'ForegroundColor',[1,0,0],'BackgroundColor', [0.8,0.9,1]);
        uicontrol('Style', 'text', 'Position', [745, 480, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [0,0,1]);
        uicontrol('Style', 'text', 'Position', [745, 450, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [1,0,0]);
        uicontrol('Style', 'text', 'Position', [745, 420, 95, 24], 'String', '      ', 'FontSize', 12, 'ForegroundColor', [0,0,0]);
        return;
    end


    %% 随机参数回调函数
    function randomizeParameters(~, ~)
        % 随机生成参数值，并更新控件内容
        x0_input.String = num2str(randi([1000, 50000]));         % 兵力(甲方)
        y0_input.String = num2str(randi([1000, 50000]));         % 兵力(乙方)
        u_input.String = num2str(randRange(0.01, 0.15));         % 增援率u
        v_input.String = num2str(randRange(0.01, 0.15));         % 增援率v
        alpha_input.String = num2str(randRange(0.01, 0.08));   % 非战斗减员率α
        beta_input.String = num2str(randRange(0.01, 0.08));    % 非战斗减员率β
        r_x_input.String = num2str(randRange(0.5, 0.8));       % 射击率r_x
        r_y_input.String = num2str(randRange(0.5, 0.8));       % 射击率r_y
        p_x_input.String = num2str(randRange(0.2, 0.6));        % 命中率p_x
        p_y_input.String = num2str(randRange(0.2, 0.6));        % 命中率p_y
        s_x_input.String = num2str(randi([10, 100]));           % 活动面积s_x
        s_y_input.String = num2str(randi([10, 100]));           % 活动面积s_y
        t_set_input.String = num2str(randi([50, 120]));          % 持续时间(h)
        theta_input.String = num2str(randRange(0.3, 0.8));      % 混合战比例(θ)
    end
    
    % 生成指定范围内的随机数
    function value = randRange(minValue, maxValue)
        value = minValue + (maxValue - minValue) * rand();
    end

end