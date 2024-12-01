-- FourStoryBuilding.ms
-- 基于实际建筑尺寸（单位：毫米）的四层建筑外立面生成器

fn createWindow width:300 height:300 frameWidth:10 position:[0,0,0] = (
    local windowGroup = undefined
    
    -- 创建一个组
    windowGroup = group "Window"
    
    -- 外框
    local frame = Box length:width width:frameWidth height:height
    frame.pos = position
    frame.material = Standard diffuse:(color 77 77 77)
    
    -- 玻璃
    local glass = Box length:(width-frameWidth*2) width:5 height:(height-frameWidth*2)
    glass.pos = [position.x + frameWidth, position.y + frameWidth/2, position.z + frameWidth]
    glass.material = Standard diffuse:(color 102 102 102) opacity:50
    
    -- 中间横梁
    local horizontal = Box length:(width-frameWidth*2) width:frameWidth height:frameWidth
    horizontal.pos = [position.x + frameWidth, position.y, position.z + height/2]
    horizontal.material = frame.material
    
    -- 中间竖梁
    local vertical = Box length:frameWidth width:frameWidth height:(height-frameWidth*2)
    vertical.pos = [position.x + width/2, position.y, position.z + frameWidth]
    vertical.material = frame.material
    
    -- 组合所有部件
    windowGroup.addNode frame
    windowGroup.addNode glass
    windowGroup.addNode horizontal
    windowGroup.addNode vertical
    
    windowGroup
)

fn createDoor width:300 height:335 frameWidth:10 position:[0,0,0] = (
    local doorGroup = undefined
    
    -- 创建一个组
    doorGroup = group "Door"
    
    -- 外框
    local frame = Box length:width width:frameWidth height:height
    frame.pos = position
    frame.material = Standard diffuse:(color 51 51 51)
    
    -- 门板
    local door = Box length:(width-frameWidth*2) width:5 height:(height-frameWidth*2)
    door.pos = [position.x + frameWidth, position.y + frameWidth/2, position.z + frameWidth]
    door.material = Standard diffuse:(color 77 77 77)
    
    -- 中缝
    local split = Box length:frameWidth width:frameWidth height:(height-frameWidth*2)
    split.pos = [position.x + width/2, position.y, position.z + frameWidth]
    split.material = frame.material
    
    -- 组合所有部件
    doorGroup.addNode frame
    doorGroup.addNode door
    doorGroup.addNode split
    
    doorGroup
)

fn createBalcony width:400 depth:80 height:95 position:[0,0,0] = (
    local balconyGroup = undefined
    
    -- 创建一个组
    balconyGroup = group "Balcony"
    
    -- 底板
    local base = Box length:width width:depth height:30
    base.pos = position
    base.material = Standard diffuse:(color 128 128 128)
    
    -- 左立柱
    local leftPost = Box length:15 width:15 height:height
    leftPost.pos = [position.x, position.y, position.z + 30]
    leftPost.material = Standard diffuse:(color 102 102 102)
    
    -- 右立柱
    local rightPost = Box length:15 width:15 height:height
    rightPost.pos = [position.x + width - 15, position.y, position.z + 30]
    rightPost.material = leftPost.material
    
    -- 顶部横栏
    local topRail = Box length:width width:15 height:15
    topRail.pos = [position.x, position.y, position.z + height + 15]
    topRail.material = leftPost.material
    
    -- 玻璃护栏
    local glass = Box length:(width-30) width:5 height:(height-30)
    glass.pos = [position.x + 15, position.y + 5, position.z + 45]
    glass.material = Standard diffuse:(color 128 128 128) opacity:30
    
    -- 装饰线条
    local decorLine1 = Box length:(width-30) width:5 height:5
    decorLine1.pos = [position.x + 15, position.y + 5, position.z + 60]
    decorLine1.material = leftPost.material
    
    local decorLine2 = Box length:(width-30) width:5 height:5
    decorLine2.pos = [position.x + 15, position.y + 5, position.z + 85]
    decorLine2.material = leftPost.material
    
    -- 组合所有部件
    balconyGroup.addNode base
    balconyGroup.addNode leftPost
    balconyGroup.addNode rightPost
    balconyGroup.addNode topRail
    balconyGroup.addNode glass
    balconyGroup.addNode decorLine1
    balconyGroup.addNode decorLine2
    
    balconyGroup
)

fn createBuilding = (
    -- 建筑尺寸
    local buildingWidth = 18000
    local buildingHeight = 13800
    local buildingDepth = 200  -- 墙体厚度
    
    -- 创建主体结构
    local mainWall = Box length:buildingWidth width:buildingDepth height:buildingHeight
    mainWall.pos = [0,0,0]
    mainWall.material = Standard diffuse:(color 255 179 128)
    
    -- 创建装饰框架
    local frame = Box length:(buildingWidth-100) width:50 height:(buildingHeight-100)
    frame.pos = [50,0,50]
    frame.material = Standard diffuse:(color 230 153 102)
    
    -- 创建楼层分隔线
    for i = 1 to 3 do (
        local floorLine = Box length:buildingWidth width:(buildingDepth+50) height:15
        floorLine.pos = [0,-25,(3500 + (i-1)*3300)]
        floorLine.material = frame.material
    )
    
    -- 创建窗户
    -- 一层窗户（左）
    createWindow width:300 height:250 frameWidth:10 position:[200,-10,1080]
    -- 一层门（中）
    createDoor width:300 height:335 frameWidth:10 position:[750,-10,1045]
    -- 一层窗户（右）
    createWindow width:300 height:250 frameWidth:10 position:[1300,-10,1080]
    
    -- 二至四层窗户
    for floor = 1 to 3 do (
        local z = 50 + (3-floor)*330
        createWindow width:300 height:300 frameWidth:10 position:[200,-10,z]
        createWindow width:300 height:300 frameWidth:10 position:[750,-10,z]
        createWindow width:300 height:300 frameWidth:10 position:[1300,-10,z]
    )
    
    -- 创建阳台
    for floor = 0 to 3 do (
        local z = 1045 - floor*350
        createBalcony width:400 depth:80 height:95 position:[700,-80,z]
    )
    
    -- 创建屋顶装饰
    local roofDecor = Box length:buildingWidth width:(buildingDepth+100) height:50
    roofDecor.pos = [0,-50,(buildingHeight-50)]
    roofDecor.material = Standard diffuse:(color 128 128 128)
    
    local roofTrim = Box length:(buildingWidth+50) width:(buildingDepth+150) height:8
    roofTrim.pos = [-25,-75,(buildingHeight-8)]
    roofTrim.material = Standard diffuse:(color 77 77 77)
)

-- 清除场景并创建建筑
delete objects
createBuilding()
