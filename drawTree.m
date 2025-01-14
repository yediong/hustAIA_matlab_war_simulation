function drawTree(ax, trunkX, trunkY, trunkWidth, trunkHeight, foliageX, foliageY, foliageWidth, foliageHeight)
    % 树干
    rectangle(ax, 'Position', [trunkX, trunkY, trunkWidth * 0.5, trunkHeight], ... 
        'Curvature', [0, 0], 'FaceColor', [0.65, 0.16, 0.16], 'EdgeColor', 'k'); % 棕色树干
    
    % 树叶层1（底层）
    rectangle(ax, 'Position', [foliageX, foliageY, foliageWidth, foliageHeight], ...
        'Curvature', [1, 1], 'FaceColor', [0.1, 0.6, 0.2], 'EdgeColor', 'k'); % 浅绿色底层
    
    % 树叶层2（中层）
    rectangle(ax, 'Position', [foliageX + foliageWidth * 0.1, foliageY + foliageHeight * 0.1, foliageWidth * 0.8, foliageHeight * 0.8], ...
        'Curvature', [1, 1], 'FaceColor', [0.2, 0.8, 0.2], 'EdgeColor', 'k'); % 深绿色中层
    
    % 树叶层3（顶部小圆）
    rectangle(ax, 'Position', [foliageX + foliageWidth * 0.3, foliageY + foliageHeight * 0.3, foliageWidth * 0.4, foliageHeight * 0.4], ...
        'Curvature', [1, 1], 'FaceColor', [0.15, 0.75, 0.2], 'EdgeColor', 'k'); % 更深绿色顶层
end