-- 简单四层建筑立面生成脚本
-- 尺寸单位：毫米

fn createSimpleFourStory = 
(
    -- 建筑主要尺寸
    local totalWidth = 12000.0    -- 总宽度
    local totalHeight = 12600.0   -- 总高度
    local firstFloorHeight = 3600.0  -- 首层高度
    local typicalFloorHeight = 3000.0 -- 标准层高
    
    -- 窗户和门的尺寸
    local standardWindowWidth = 1800.0  -- 标准窗宽
    local standardWindowHeight = 1500.0 -- 标准窗高
    local firstFloorWindowHeight = 2100.0 -- 首层窗高
    local doorWidth = 1800.0      -- 门宽
    local doorHeight = 2400.0     -- 门高
    
    -- 阳台尺寸
    local balconyWidth = 2000.0
    local balconyHeight = 1000.0
    
    -- 切换到创建面板
    max create mode
    
    -- 创建墙体外轮廓
    local wallShape = line()
    wallShape.pos = [0,0,0]
    
    -- 添加墙体外轮廓（逆时针）
    addNewSpline wallShape
    addKnot wallShape 1 #corner #line [0,0,0]
    addKnot wallShape 1 #corner #line [totalWidth,0,0]
    addKnot wallShape 1 #corner #line [totalWidth,0,totalHeight]
    addKnot wallShape 1 #corner #line [0,0,totalHeight]
    close wallShape 1
    
    -- 窗户水平位置计算
    local leftWindowX = 1500.0  -- 左侧窗户起始位置
    local windowSpacing = 3600.0 -- 窗户间距
    
    -- 创建窗户开洞
    local splineIndex = 2
    
    -- 首层窗户和门（3个开洞）
    for i = 1 to 3 do
    (
        local windowX = leftWindowX + ((i-1) * windowSpacing)
        local windowBottom = 900.0  -- 首层窗台高度
        
        -- 中间位置是门
        if i == 2 then
        (
            -- 添加门开洞（顺时针）
            addNewSpline wallShape
            addKnot wallShape splineIndex #corner #line [windowX,0,0]  -- 门从地面开始
            addKnot wallShape splineIndex #corner #line [windowX,0,doorHeight]
            addKnot wallShape splineIndex #corner #line [windowX + doorWidth,0,doorHeight]
            addKnot wallShape splineIndex #corner #line [windowX + doorWidth,0,0]
            close wallShape splineIndex
            splineIndex += 1
        )
        else
        (
            -- 添加窗户开洞（顺时针）
            addNewSpline wallShape
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottom]
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottom + firstFloorWindowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + standardWindowWidth,0,windowBottom + firstFloorWindowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + standardWindowWidth,0,windowBottom]
            close wallShape splineIndex
            splineIndex += 1
        )
    )
    
    -- 标准层窗户（3层，每层3个）
    for floor = 1 to 3 do
    (
        local floorBottom = firstFloorHeight + ((floor-1) * typicalFloorHeight)
        
        -- 每层3个窗户
        for i = 1 to 3 do
        (
            local windowX = leftWindowX + ((i-1) * windowSpacing)
            local windowBottom = floorBottom + 900.0  -- 窗台高度
            
            -- 中间位置添加阳台
            if i == 2 then
            (
                -- 添加阳台开洞（顺时针）
                local balconyX = windowX - ((balconyWidth - standardWindowWidth) / 2)
                local balconyBottom = floorBottom + 50.0  -- 阳台底部位置
                
                addNewSpline wallShape
                addKnot wallShape splineIndex #corner #line [balconyX,0,balconyBottom]
                addKnot wallShape splineIndex #corner #line [balconyX,0,balconyBottom + balconyHeight]
                addKnot wallShape splineIndex #corner #line [balconyX + balconyWidth,0,balconyBottom + balconyHeight]
                addKnot wallShape splineIndex #corner #line [balconyX + balconyWidth,0,balconyBottom]
                close wallShape splineIndex
                splineIndex += 1
            )
            
            -- 添加窗户开洞（顺时针）
            addNewSpline wallShape
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottom]
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottom + standardWindowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + standardWindowWidth,0,windowBottom + standardWindowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + standardWindowWidth,0,windowBottom]
            close wallShape splineIndex
            splineIndex += 1
        )
    )
    
    -- 更新形状
    updateShape wallShape
)

-- 执行函数
createSimpleFourStory()
