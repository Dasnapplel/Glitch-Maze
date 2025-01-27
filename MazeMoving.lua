local enemy = script.Parent
local ts = game:GetService("TweenService")
local G = workspace["Maze Moving"]
local moveTime = 0

--array with all waypoints
local waypointArray = {G.Wp1, G.Wp2, G.Wp3, G.Wp4, G.Wp5, G.Wp6, G.Wp7, G.Wp8, G.Wp9, G.Wp10, G.Wp11, G.Wp12, G.Wp13, G.Wp14, G.Wp15, G.Wp16, G.Wp17, G.Wp18, G.Wp19, G.Wp20, G.Wp21, G.Wp22, G.Wp23, G.Wp24, G.Wp25, G.Wp26, G.Wp27, G.Wp28, G.Wp29, G.Wp30, G.Wp31, G.Wp32, G.Wp33, G.Wp34, G.Wp35, G.Wp36, G.Wp37, G.Wp38, G.Wp39, G.Wp40, G.Wp41, G.Wp42, G.Wp43, G.Wp44, G.Wp45, G.Wp46, G.Wp47, G.Wp48, G.Wp49, G.Wp50, G.Wp51, G.Wp52, G.Wp53, G.Wp54, G.Wp55, G.Wp56, G.Wp57, G.Wp58, G.Wp59, G.Wp60, G.Wp61, G.Wp62, G.Wp63, G.Wp64}

--array with paths for each waypoint
local neighborArray = {
	{2, 16, 17},
	{1, 3, 17, 21, 41, 42, 46, 47},
	{2, 4, 12, 21, 24, 25, 41, 42, 46, 47},
	{3, 5, 12, 24, 25},
	{4, 6},
	{5, 7},
	{6, 8, 15, 16},
	{7, 9, 15, 16},
	{8, 10},
	{9, 11},
	{3, 4, 10, 12, 24, 25},
	{3, 4, 11, 13, 24, 25},
	{12, 14, 28, 32, 53, 54, 58, 59},
	{13, 15, 32},
	{7, 8, 14, 16},
	{7, 8, 15, 1},
	{1, 2, 18},
	{17, 19},
	{18, 20},
	{19, 21, 22, 23},
	{2, 3, 20, 22, 23, 41, 42, 46, 47},
	{20, 21, 23, 33, 34, 35},
	{20, 21, 22, 24},
	{3, 4, 11, 12, 23, 25},
	{3, 4, 11, 12, 24, 26},
	{25, 27, 28, 29},
	{26, 28, 29, 38, 39, 40},
	{12, 13, 26, 27, 29, 53, 54, 58, 59},
	{26, 27, 28, 30},
	{29, 31},
	{30, 32},
	{13, 14, 31},
	{22, 34, 35, 40},
	{22, 33, 35, 41},
	{22, 33, 34, 36, 37, 38},
	{35, 37, 38, 52},
	{35, 36, 38, 64},
	{27, 35, 36, 37, 39, 40},
	{27, 38, 40, 53},
	{27, 33, 38, 39},
	{2, 3, 21, 34, 42, 46, 47},
	{2, 3, 21, 41, 43, 46, 47},
	{42, 44, 45},
	{43, 45, 47, 48, 50, 56, 59, 60, 61},
	{43, 44, 46, 49},
	{2, 3, 21, 41, 42, 45, 47, 49},
	{2, 3, 21, 41, 42, 44, 46, 48, 50, 56, 59, 60, 61},
	{44, 47, 50, 51, 56, 59, 60, 61},
	{45, 46, 50},
	{44, 47, 48, 49, 56, 59, 60, 61},
	{48, 52},
	{36, 51},
	{12, 13, 28, 39, 54, 58, 59},
	{12, 13, 28, 53, 55, 58, 59},
	{54, 56, 57},
	{44, 47, 48, 50, 55, 57, 59, 60, 61},
	{55, 56, 58, 62},
	{12, 13, 28, 53, 54, 57, 59, 62},
	{12, 13, 28, 44, 47, 48, 50, 53, 54, 56, 58, 60, 61},
	{44, 47, 48, 50, 56, 59, 61, 63},
	{44, 47, 48, 50, 56, 59, 60, 62},
	{57, 58, 61},
	{60, 64},
	{37, 63},
}

local waypoint = waypointArray[enemy.StartWp.Value] --starting position

repeat
	--Distance Finder and Time Calculator
	local function distTimeCalc(wpPos, enemyPos) 
		moveTime = math.abs(wpPos - enemyPos) / 25
	end
	
	if math.abs(enemy.WorldPivot.Position.X) - math.abs(waypoint.Position.X) == 0 then --if X value doesn't change, find change in Z
		distTimeCalc(waypoint.Position.Z, enemy.WorldPivot.Position.Z)
	elseif math.abs(enemy.WorldPivot.Position.Z) - math.abs(waypoint.Position.Z) == 0 then --if Z value doesn't change, find change in X
		distTimeCalc(waypoint.Position.X, enemy.WorldPivot.Position.X)
	end

	--tween the enemy to the next waypoint
	local function moveModel(model, goal)
		local ti = TweenInfo.new(moveTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
		local cf = Instance.new("CFrameValue")
		model.PrimaryPart = model:FindFirstChild("body")
		cf.Value = model:GetPrimaryPartCFrame()
		cf:GetPropertyChangedSignal("Value"):Connect(function()
			model:SetPrimaryPartCFrame(cf.Value)
		end)
		local tween = ts:Create(cf, ti, { Value = CFrame.new(goal.Position)})
		tween:Play()
		wait(moveTime)
	end
	moveModel(enemy, waypoint)
	
	--randomly get a new neighbor waypoint 
	for i = 1, 64 do
		if waypoint == waypointArray[i] then
			neighbors = neighborArray[i]
			randomPoint = neighbors[math.random(#neighbors)]
			waypoint = waypointArray[randomPoint]
			break
		end
	end
	
	wait(0.05)
until false

