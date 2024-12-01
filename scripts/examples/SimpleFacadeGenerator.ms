-- 注意：此脚本生成2D立面轮廓线
-- 由于门的下边缘与墙体下边缘重合，如果需要进行3D建模（如挤出操作），
-- 建议手动调整门的下边缘位置，避免重合导致的拓扑问题。

fn createSimpleFacade = 
(
    -- 定义尺寸（单位：毫米）
    wallHeight = 2700.0    -- 墙高：2700mm
    wallWidth = 12000.0    -- 墙宽：12000mm
    doorHeight = 2100.0    -- 门高：2100mm
    doorWidth = 900.0      -- 门宽：900mm
    windowHeight = 1200.0  -- 窗高：1200mm
    windowWidth = 900.0    -- 窗宽：900mm
    windowSillHeight = 900.0  -- 窗台高：900mm
    
    -- 切换到创建面板
    max create mode
    
    -- 创建墙体形状（包含外轮廓和内轮廓）
    wallShape = line()
    wallShape.pos = [0,0,0]
    
    -- 添加墙体外轮廓（第一个样条线，逆时针）
    addNewSpline wallShape
    addKnot wallShape 1 #corner #line [0,0,0]
    addKnot wallShape 1 #corner #line [wallWidth,0,0]
    addKnot wallShape 1 #corner #line [wallWidth,0,wallHeight]
    addKnot wallShape 1 #corner #line [0,0,wallHeight]
    close wallShape 1
    
    -- 添加第一个门的轮廓（第二个样条线，顺时针）
    doorX = 2000.0  -- 第一个门距离左边2000mm
    addNewSpline wallShape
    addKnot wallShape 2 #corner #line [doorX,0,0]
    addKnot wallShape 2 #corner #line [doorX,0,doorHeight]
    addKnot wallShape 2 #corner #line [doorX + doorWidth,0,doorHeight]
    addKnot wallShape 2 #corner #line [doorX + doorWidth,0,0]
    close wallShape 2
    
    -- 添加第二个门的轮廓（第三个样条线，顺时针）
    door2X = 6000.0  -- 第二个门距离左边6000mm
    addNewSpline wallShape
    addKnot wallShape 3 #corner #line [door2X,0,0]
    addKnot wallShape 3 #corner #line [door2X,0,doorHeight]
    addKnot wallShape 3 #corner #line [door2X + doorWidth,0,doorHeight]
    addKnot wallShape 3 #corner #line [door2X + doorWidth,0,0]
    close wallShape 3
    
    -- 添加第一个窗户的轮廓（第四个样条线，顺时针）
    windowX = 4000.0  -- 第一个窗距离左边4000mm
    addNewSpline wallShape
    addKnot wallShape 4 #corner #line [windowX,0,windowSillHeight]
    addKnot wallShape 4 #corner #line [windowX,0,windowSillHeight + windowHeight]
    addKnot wallShape 4 #corner #line [windowX + windowWidth,0,windowSillHeight + windowHeight]
    addKnot wallShape 4 #corner #line [windowX + windowWidth,0,windowSillHeight]
    close wallShape 4
    
    -- 添加第二个窗户的轮廓（第五个样条线，顺时针）
    window2X = 8000.0  -- 第二个窗距离左边8000mm
    addNewSpline wallShape
    addKnot wallShape 5 #corner #line [window2X,0,windowSillHeight]
    addKnot wallShape 5 #corner #line [window2X,0,windowSillHeight + windowHeight]
    addKnot wallShape 5 #corner #line [window2X + windowWidth,0,windowSillHeight + windowHeight]
    addKnot wallShape 5 #corner #line [window2X + windowWidth,0,windowSillHeight]
    close wallShape 5
    
    -- 添加第三个窗户的轮廓（第六个样条线，顺时针）
    window3X = 10000.0  -- 第三个窗距离左边10000mm
    addNewSpline wallShape
    addKnot wallShape 6 #corner #line [window3X,0,windowSillHeight]
    addKnot wallShape 6 #corner #line [window3X,0,windowSillHeight + windowHeight]
    addKnot wallShape 6 #corner #line [window3X + windowWidth,0,windowSillHeight + windowHeight]
    addKnot wallShape 6 #corner #line [window3X + windowWidth,0,windowSillHeight]
    close wallShape 6
    
    -- 更新形状
    updateShape wallShape
)

-- 执行函数
createSimpleFacade()
