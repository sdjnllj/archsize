-- 基础绘图工具库
struct FacadeUtils
(
    -- 创建新的线条对象
    fn createNewLine = 
    (
        local lineObj = line()
        lineObj.pos = [0,0,0]
        return lineObj
    ),
    
    -- 添加直线轮廓
    fn addPolyline obj points closed:true clockwise:false = 
    (
        local splineIndex = numSplines obj + 1
        addNewSpline obj
        
        -- 如果需要顺时针方向，反转点序列
        if clockwise do points = for i = points.count to 1 by -1 collect points[i]
        
        -- 添加所有点
        for pt in points do (
            addKnot obj splineIndex #corner #line pt
        )
        
        -- 如果需要闭合
        if closed do close obj splineIndex
        
        updateShape obj
        return splineIndex
    ),
    
    -- 创建矩形轮廓
    fn createRectangle width:1000.0 height:1000.0 pos:[0,0,0] clockwise:false = 
    (
        local rect = #(
            pos,
            [pos.x + width, pos.y, pos.z],
            [pos.x + width, pos.y, pos.z + height],
            [pos.x, pos.y, pos.z + height]
        )
        return rect
    ),
    
    -- 创建在XZ平面上的2D点
    fn createPoint x:0.0 z:0.0 = 
    (
        return [x, 0, z]
    ),
    
    -- 计算两点之间的距离
    fn distanceBetween p1 p2 = 
    (
        return distance p1 p2
    ),
    
    -- 检查点是否在矩形内
    fn isPointInRectangle pt rect = 
    (
        local x = pt.x
        local z = pt.z
        local minX = rect[1].x
        local maxX = rect[2].x
        local minZ = rect[1].z
        local maxZ = rect[3].z
        
        return x >= minX and x <= maxX and z >= minZ and z <= maxZ
    )
)

-- 创建全局工具实例
if FacadeUtils_Instance == undefined do (
    global FacadeUtils_Instance = FacadeUtils()
)
