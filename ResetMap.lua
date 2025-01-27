local pelletsFolder = workspace.PelletsFolder
local pellets = pelletsFolder.Pellets
local powPellets = pelletsFolder.PowerPellets

--replace workspace pellet folders with new ones
local function resetMap()
	if workspace:FindFirstChild('PelletsFolder') then
		workspace.PelletsFolder:Destroy()
	end
	local copyPel = game.ServerStorage.PelletsFolder:Clone()
	copyPel.Parent = workspace
	
	pelletsFolder = copyPel
	pellets = pelletsFolder.Pellets
	powPellets = pelletsFolder.PowerPellets
end

--reset map when player enters the game
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		resetMap()
		print('map reset')
	end)
end)

repeat
	wait()
until game:IsLoaded()


--every time a pellet or power pellet is removed from the game, 
--check if there are any left. If not, reset the map.
pellets.ChildRemoved:Connect(function()
	if not pellets:FindFirstChild("Pellet") and not powPellets:FindFirstChild("PowerPellet") then
		resetMap()
	end
	wait(0.1)
end)

powPellets.ChildRemoved:Connect(function()
	if not pellets:FindFirstChild("Pellet") and not powPellets:FindFirstChild("PowerPellet") then
		resetMap()
	end
	wait(0.1)
end)

