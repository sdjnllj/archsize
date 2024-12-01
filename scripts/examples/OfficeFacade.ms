-- 办公建筑立面生成脚本
-- 尺寸单位：毫米

fn createOfficeFacade = 
(
    -- 建筑主要尺寸
    local totalHeight = 24000.0    -- 总高度
    local totalWidth = 25000.0     -- 总宽度
    local firstFloorHeight = 4800.0 -- 首层高度
    local typicalFloorHeight = 3800.0 -- 标准层高
    local windowWidth = 2400.0     -- 窗户宽度
    local windowHeight = 2400.0    -- 窗户高度
    local windowHSpacing = 2800.0  -- 窗户水平间距（中心线到中心线）
    
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
    
    -- 创建窗户开洞
    local splineIndex = 2
    local windowStartX = 2000.0  -- 第一列窗户距离左边的距离
    
    -- 计算窗户位置的垂直偏移
    local verticalOffsets = #(
        firstFloorHeight + 700.0,  -- 首层窗户位置（加上窗台高度）
        firstFloorHeight + typicalFloorHeight + 700.0,
        firstFloorHeight + (typicalFloorHeight * 2) + 700.0,
        firstFloorHeight + (typicalFloorHeight * 3) + 700.0,
        firstFloorHeight + (typicalFloorHeight * 4) + 700.0
    )
    
    -- 创建5x4的窗户网格
    for row = 1 to 5 do (
        local windowBottomZ = verticalOffsets[row]
        
        -- 每层4个窗户
        for col = 1 to 4 do (
            local windowX = windowStartX + ((col-1) * windowHSpacing)
            
            -- 添加窗户开洞（顺时针）
            addNewSpline wallShape
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottomZ]
            addKnot wallShape splineIndex #corner #line [windowX,0,windowBottomZ + windowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + windowWidth,0,windowBottomZ + windowHeight]
            addKnot wallShape splineIndex #corner #line [windowX + windowWidth,0,windowBottomZ]
            close wallShape splineIndex
            
            splineIndex += 1
        )
    )
    
    -- 更新形状
    updateShape wallShape
)

-- 执行函数
createOfficeFacade()
