--Points script
local PointsPart = script.Parent
local TweenService = game:GetService("TweenService")
local debris = game:GetService("Debris")
local lights = workspace.Lights
local RS = game:GetService('ReplicatedStorage')
local debounce = false

--create a tween
local info = TweenInfo.new(
	2,					--Length
	Enum.EasingStyle.Circular, 		--Easing Style
	Enum.EasingDirection.InOut, 		--Easing Direction
	-1, 					--Times tween repeats
	true, 					--Should tween reverse?
	0.1					--Delay
)
local properties = 
	{
		Color = Color3.new(1, 0.35, 0.02); 		--Varies with what properties you want
		Size = Vector3.new(5,5,5);
		Transparency = 0.1
	}
local Tween = TweenService:Create(PointsPart, info, properties)
Tween:Play()

PointsPart.Touched:Connect(function(hit)
	if debounce then return end
	
	local character = hit.Parent
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")

	if humanoid then
		debounce = true
		local player = game.Players:GetPlayerFromCharacter(humanoid.Parent)
		local playerStats = player:FindFirstChild("leaderstats")
		
		local playerPoints = playerStats:FindFirstChild("Points")
		local playerHigh = playerStats:FindFirstChild("Highscore")
		
		playerPoints.Value = playerPoints.Value + 50
		if playerPoints.Value > playerHigh.Value then
			playerHigh.Value = playerPoints.Value
		end

		script.Sound:Play()
		Tween:Cancel()
		script.Parent.Transparency = 1

		local forcefield1 = Instance.new("ForceField")
		forcefield1.Parent = character
		local Torso = character:FindFirstChild("Torso")
		local fire = Instance.new("Fire")
		fire.Size = 7.5
		fire.Color = Color3.new(10,10,10)
		fire.Parent = Torso
		fire.Enabled = false
		for i, light in pairs(lights:GetChildren()) do
			light.BrickColor = BrickColor.new('White')
		end
		humanoid.WalkSpeed = 35
		
		debris:AddItem(forcefield1, 10)
		debris:AddItem(fire, 10)
		
		wait(10)
		
		for i, light in pairs(lights:GetChildren()) do
			light.BrickColor = BrickColor.new('Dark blue')
		end
		humanoid.WalkSpeed = 25
		
		PointsPart:Destroy()
	end
end)


