--Points script
local PointsPart = script.Parent 
local TweenService = game:GetService("TweenService")
local X = PointsPart.Position.X
local Z = PointsPart.Position.Z
local debounce = false

--create an infinite tween that moves pellets up and down
local info = TweenInfo.new(
	6,					--Length
	Enum.EasingStyle.Linear, 		--Easing Style
	Enum.EasingDirection.Out, 		--Easing Direction
	-1, 					--Times tween repeats
	true, 					--Should tween reverse?
	0.1					--Delay
)
local properties = {Position = Vector3.new(X, 4, Z)}
local Tween = TweenService:Create(PointsPart, info, properties)
Tween:Play()

--when the pellet is touched by a player, destroy the part and add 10 points 
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
		
		playerPoints.Value = playerPoints.Value + 10
		if playerPoints.Value > playerHigh.Value then
			playerHigh.Value = playerPoints.Value
		end
		
		script.PelletSound:Play()
		script.Parent.Transparency = 1

		wait(1)
		
		PointsPart:Destroy()
	end
end)



