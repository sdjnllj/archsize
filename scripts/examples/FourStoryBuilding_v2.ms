-- FourStoryBuilding_v2.ms
-- 基于实际建筑尺寸（单位：毫米）的四层建筑外立面生成器

fn createWindow pos width:3000 height:3000 frameWidth:100 = (
    local frame = Box lengthsegs:1 widthsegs:1 heightsegs:1
    frame.length = width
    frame.width = frameWidth
    frame.height = height
    frame.pos = pos
    frame.material = Standard diffuse:(color 77 77 77)
    frame.name = uniquename "WindowFrame"
    
    -- 玻璃
    local glass = Box lengthsegs:1 widthsegs:1 heightsegs:1
    glass.length = (width - frameWidth * 2)
    glass.width = 50
    glass.height = (height - frameWidth * 2)
    glass.pos = [pos.x + frameWidth, pos.y + frameWidth/2, pos.z + frameWidth]
    glass.material = Standard diffuse:(color 102 102 102) opacity:50
    glass.name = uniquename "WindowGlass"
    
    -- 中间横梁
    local horizontal = Box lengthsegs:1 widthsegs:1 heightsegs:1
    horizontal.length = (width - frameWidth * 2)
    horizontal.width = frameWidth
    horizontal.height = frameWidth
    horizontal.pos = [pos.x + frameWidth, pos.y, pos.z + height/2]
    horizontal.material = frame.material
    horizontal.name = uniquename "WindowHBeam"
    
    -- 中间竖梁
    local vertical = Box lengthsegs:1 widthsegs:1 heightsegs:1
    vertical.length = frameWidth
    vertical.width = frameWidth
    vertical.height = (height - frameWidth * 2)
    vertical.pos = [pos.x + width/2, pos.y, pos.z + frameWidth]
    vertical.material = frame.material
    vertical.name = uniquename "WindowVBeam"
    
    -- 返回所有对象
    #(frame, glass, horizontal, vertical)
)

fn createDoor pos width:3000 height:3350 frameWidth:100 = (
    -- 外框
    local frame = Box lengthsegs:1 widthsegs:1 heightsegs:1
    frame.length = width
    frame.width = frameWidth
    frame.height = height
    frame.pos = pos
    frame.material = Standard diffuse:(color 51 51 51)
    frame.name = uniquename "DoorFrame"
    
    -- 门板
    local door = Box lengthsegs:1 widthsegs:1 heightsegs:1
    door.length = (width - frameWidth * 2)
    door.width = 50
    door.height = (height - frameWidth * 2)
    door.pos = [pos.x + frameWidth, pos.y + frameWidth/2, pos.z + frameWidth]
    door.material = Standard diffuse:(color 77 77 77)
    door.name = uniquename "DoorPanel"
    
    -- 中缝
    local split = Box lengthsegs:1 widthsegs:1 heightsegs:1
    split.length = frameWidth
    split.width = frameWidth
    split.height = (height - frameWidth * 2)
    split.pos = [pos.x + width/2, pos.y, pos.z + frameWidth]
    split.material = frame.material
    split.name = uniquename "DoorSplit"
    
    -- 返回所有对象
    #(frame, door, split)
)

fn createBalcony pos width:4000 depth:800 height:950 = (
    -- 底板
    local base = Box lengthsegs:1 widthsegs:1 heightsegs:1
    base.length = width
    base.width = depth
    base.height = 300
    base.pos = pos
    base.material = Standard diffuse:(color 128 128 128)
    base.name = uniquename "BalconyBase"
    
    -- 左立柱
    local leftPost = Box lengthsegs:1 widthsegs:1 heightsegs:1
    leftPost.length = 150
    leftPost.width = 150
    leftPost.height = height
    leftPost.pos = [pos.x, pos.y, pos.z + 300]
    leftPost.material = Standard diffuse:(color 102 102 102)
    leftPost.name = uniquename "BalconyLPost"
    
    -- 右立柱
    local rightPost = Box lengthsegs:1 widthsegs:1 heightsegs:1
    rightPost.length = 150
    rightPost.width = 150
    rightPost.height = height
    rightPost.pos = [pos.x + width - 150, pos.y, pos.z + 300]
    rightPost.material = leftPost.material
    rightPost.name = uniquename "BalconyRPost"
    
    -- 顶部横栏
    local topRail = Box lengthsegs:1 widthsegs:1 heightsegs:1
    topRail.length = width
    topRail.width = 150
    topRail.height = 150
    topRail.pos = [pos.x, pos.y, pos.z + height + 150]
    topRail.material = leftPost.material
    topRail.name = uniquename "BalconyRail"
    
    -- 玻璃护栏
    local glass = Box lengthsegs:1 widthsegs:1 heightsegs:1
    glass.length = (width - 300)
    glass.width = 50
    glass.height = (height - 300)
    glass.pos = [pos.x + 150, pos.y + 50, pos.z + 450]
    glass.material = Standard diffuse:(color 128 128 128) opacity:30
    glass.name = uniquename "BalconyGlass"
    
    -- 装饰线条
    local decorLine1 = Box lengthsegs:1 widthsegs:1 heightsegs:1
    decorLine1.length = (width - 300)
    decorLine1.width = 50
    decorLine1.height = 50
    decorLine1.pos = [pos.x + 150, pos.y + 50, pos.z + 600]
    decorLine1.material = leftPost.material
    decorLine1.name = uniquename "BalconyLine1"
    
    local decorLine2 = Box lengthsegs:1 widthsegs:1 heightsegs:1
    decorLine2.length = (width - 300)
    decorLine2.width = 50
    decorLine2.height = 50
    decorLine2.pos = [pos.x + 150, pos.y + 50, pos.z + 850]
    decorLine2.material = leftPost.material
    decorLine2.name = uniquename "BalconyLine2"
    
    -- 返回所有对象
    #(base, leftPost, rightPost, topRail, glass, decorLine1, decorLine2)
)

fn createBuilding = (
    -- 建筑尺寸
    local buildingWidth = 18000.0
    local buildingHeight = 13800.0
    local buildingDepth = 200.0  -- 墙体厚度
    
    -- 创建主体结构
    local mainWall = Box lengthsegs:1 widthsegs:1 heightsegs:1
    mainWall.length = buildingWidth
    mainWall.width = buildingDepth
    mainWall.height = buildingHeight
    mainWall.pos = [0,0,0]
    mainWall.material = Standard diffuse:(color 255 179 128)
    mainWall.name = "MainWall"
    
    -- 创建装饰框架
    local frame = Box lengthsegs:1 widthsegs:1 heightsegs:1
    frame.length = (buildingWidth-100)
    frame.width = 50
    frame.height = (buildingHeight-100)
    frame.pos = [50,0,50]
    frame.material = Standard diffuse:(color 230 153 102)
    frame.name = "MainFrame"
    
    -- 创建楼层分隔线
    local floorLines = for i = 1 to 3 collect
    (
        local floorLine = Box lengthsegs:1 widthsegs:1 heightsegs:1
        floorLine.length = buildingWidth
        floorLine.width = (buildingDepth+50)
        floorLine.height = 15
        floorLine.pos = [0,-25,(3500 + (i-1)*3300)]
        floorLine.material = frame.material
        floorLine.name = uniquename "FloorLine"
        floorLine
    )
    
    -- 创建窗户
    -- 一层窗户和门
    local firstFloorElements = #()
    append firstFloorElements (createWindow [200,-10,1080] width:3000 height:2500)  -- 左窗
    append firstFloorElements (createDoor [750,-10,1045] width:3000 height:3350)    -- 中门
    append firstFloorElements (createWindow [1300,-10,1080] width:3000 height:2500) -- 右窗
    
    -- 二至四层窗户
    local upperFloorElements = for floor = 1 to 3 collect
    (
        local z = 50 + (3-floor)*330
        local floorElements = #()
        append floorElements (createWindow [200,-10,z] width:3000 height:3000)
        append floorElements (createWindow [750,-10,z] width:3000 height:3000)
        append floorElements (createWindow [1300,-10,z] width:3000 height:3000)
        floorElements
    )
    
    -- 创建阳台
    local balconies = for floor = 0 to 3 collect
    (
        local z = 1045 - floor*350
        createBalcony [700,-80,z] width:4000 depth:800 height:950
    )
    
    -- 创建屋顶装饰
    local roofDecor = Box lengthsegs:1 widthsegs:1 heightsegs:1
    roofDecor.length = buildingWidth
    roofDecor.width = (buildingDepth+100)
    roofDecor.height = 50
    roofDecor.pos = [0,-50,(buildingHeight-50)]
    roofDecor.material = Standard diffuse:(color 128 128 128)
    roofDecor.name = "RoofDecor"
    
    local roofTrim = Box lengthsegs:1 widthsegs:1 heightsegs:1
    roofTrim.length = (buildingWidth+50)
    roofTrim.width = (buildingDepth+150)
    roofTrim.height = 8
    roofTrim.pos = [-25,-75,(buildingHeight-8)]
    roofTrim.material = Standard diffuse:(color 77 77 77)
    roofTrim.name = "RoofTrim"
)

-- 清除场景并创建建筑
delete objects
createBuilding()
