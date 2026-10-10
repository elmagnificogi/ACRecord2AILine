-- 配置参数
local MAX_FORCE = 7000
local MESH_COUNT = 10

-- 轮胎网格存储
local tyreMeshes = {
	LF = {},  -- 左前
	RF = {},  -- 右前
	LR = {},  -- 左后
	RR = {}   -- 右后
}

-- 初始化轮胎网格
local function initTyreMeshes()
	-- LF轮胎：0-9编号
	for i = 0, 9 do
		local meshName = 'TyreLF' .. i
		local mesh = ac.findMeshes(meshName)
		if mesh then
			tyreMeshes.LF[i] = mesh
		end
	end
	
	-- RF轮胎：0-9编号
	for i = 0, 9 do
		local meshName = 'TyreRF' .. i
		local mesh = ac.findMeshes(meshName)
		if mesh then
			tyreMeshes.RF[i] = mesh
		end
	end
	
	-- LR轮胎：0-8编号 + 无后缀主网格
	for i = 0, 8 do
		local meshName = 'TyreLR' .. i
		local mesh = ac.findMeshes(meshName)
		if mesh then
			tyreMeshes.LR[i] = mesh
		end
	end
	-- LR主网格（无编号后缀）
	local lrMainMesh = ac.findMeshes('TyreLR')
	if lrMainMesh then
		tyreMeshes.LR[9] = lrMainMesh
	end
	
	-- RR轮胎：0-9编号
	for i = 0, 9 do
		local meshName = 'TyreRR' .. i
		local mesh = ac.findMeshes(meshName)
		if mesh then
			tyreMeshes.RR[i] = mesh
		end
	end
end

-- 计算轮胎受力
local function calculateTyreForce(wheel)
	return (wheel.fx * wheel.fx + wheel.fy * wheel.fy)^0.5
end

-- 更新单个轮胎网格显示
local function updateTyreMeshes(position, activeMeshCount)
	local meshArray = tyreMeshes[position]
	
	for i = 0, MESH_COUNT - 1 do
		if meshArray[i] then
			meshArray[i]:setVisible(i < activeMeshCount)
		end
	end
end

-- 处理单个轮胎
local function processTyre(wheel, position)
	local force = calculateTyreForce(wheel)
	local activeMeshes = math.floor((force / MAX_FORCE) * MESH_COUNT)
	activeMeshes = math.min(activeMeshes, MESH_COUNT)
	
	updateTyreMeshes(position, activeMeshes)
	
	-- 调试信息
	ac.debug(position .. '_force', force)
	ac.debug(position .. '_active_meshes', activeMeshes)
	
	return {
		fx = wheel.fx,
		fy = wheel.fy,
		load = wheel.load,
		loadK = wheel.loadK,
		force = force,
		activeMeshes = activeMeshes
	}
end

-- 初始化
initTyreMeshes()

function script.update(dt)
	local carinfo = ac.getCar(0)
	local wheels = carinfo.wheels
	
	-- 轮胎索引映射：游戏索引 -> 位置名称
	local wheelMapping = {
		[0] = 'LF',  -- 左前
		[1] = 'RF',  -- 右前
		[2] = 'LR',  -- 左后
		[3] = 'RR'   -- 右后
	}
	
	-- 处理所有轮胎
	local tyreData = {}
	for wheelIndex = 0, 3 do
		local position = wheelMapping[wheelIndex]
		local wheel = wheels[wheelIndex]
		tyreData[position] = processTyre(wheel, position)
	end
	
	-- 额外的调试信息（可选）
	ac.debug('carinfo', carinfo)
end