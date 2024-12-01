-- 注意：此脚本生成2D立面轮廓线
-- 由于门的下边缘与墙体下边缘重合，如果需要进行3D建模（如挤出操作），
-- 建议手动调整门的下边缘位置，避免重合导致的拓扑问题。

-- 创建墙体外轮廓
fn createWallOutline height:2700.0 width:12000.0 = 
(
    -- 创建墙体形状
    local wallShape = line()
    wallShape.pos = [0,0,0]
    
    -- 添加墙体外轮廓（逆时针）
    addNewSpline wallShape
    addKnot wallShape 1 #corner #line [0,0,0]
    addKnot wallShape 1 #corner #line [width,0,0]
    addKnot wallShape 1 #corner #line [width,0,height]
    addKnot wallShape 1 #corner #line [0,0,height]
    close wallShape 1
    
    return wallShape
)

-- 添加门洞
fn addDoorOpening targetShape splineIndex:1 xPosition:2000.0 width:900.0 height:2100.0 = 
(
    -- 添加门洞轮廓（顺时针）
    addNewSpline targetShape
    addKnot targetShape splineIndex #corner #line [xPosition,0,0]
    addKnot targetShape splineIndex #corner #line [xPosition,0,height]
    addKnot targetShape splineIndex #corner #line [xPosition + width,0,height]
    addKnot targetShape splineIndex #corner #line [xPosition + width,0,0]
    close targetShape splineIndex
    
    updateShape targetShape
)

-- 添加窗洞
fn addWindowOpening targetShape splineIndex:1 xPosition:4000.0 width:900.0 height:1200.0 sillHeight:900.0 = 
(
    -- 添加窗洞轮廓（顺时针）
    addNewSpline targetShape
    addKnot targetShape splineIndex #corner #line [xPosition,0,sillHeight]
    addKnot targetShape splineIndex #corner #line [xPosition,0,sillHeight + height]
    addKnot targetShape splineIndex #corner #line [xPosition + width,0,sillHeight + height]
    addKnot targetShape splineIndex #corner #line [xPosition + width,0,sillHeight]
    close targetShape splineIndex
    
    updateShape targetShape
)

-- 创建完整立面
fn createFacade wallHeight:2700.0 wallWidth:12000.0 doorData:#() windowData:#() = 
(
    -- 切换到创建面板
    max create mode
    
    -- 创建墙体
    local wallShape = createWallOutline height:wallHeight width:wallWidth
    
    -- 添加门洞
    -- doorData格式：#([x, width, height], [x, width, height], ...)
    local splineIndex = 2
    for door in doorData do (
        addDoorOpening wallShape splineIndex:splineIndex xPosition:door[1] width:door[2] height:door[3]
        splineIndex += 1
    )
    
    -- 添加窗洞
    -- windowData格式：#([x, width, height, sillHeight], [x, width, height, sillHeight], ...)
    for window in windowData do (
        addWindowOpening wallShape splineIndex:splineIndex xPosition:window[1] width:window[2] height:window[3] sillHeight:window[4]
        splineIndex += 1
    )
)

-- 示例：创建带有2个门和3个窗的立面
fn createExampleFacade = 
(
    -- 定义门的数据：[x位置, 宽度, 高度]
    local doors = #(
        [2000.0, 900.0, 2100.0],  -- 第一个门
        [6000.0, 900.0, 2100.0]   -- 第二个门
    )
    
    -- 定义窗的数据：[x位置, 宽度, 高度, 窗台高度]
    local windows = #(
        [4000.0, 900.0, 1200.0, 900.0],   -- 第一个窗
        [8000.0, 900.0, 1200.0, 900.0],   -- 第二个窗
        [10000.0, 900.0, 1200.0, 900.0]   -- 第三个窗
    )
    
    -- 创建立面
    createFacade doorData:doors windowData:windows
)

-- 执行示例函数
createExampleFacade()
