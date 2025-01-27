--Get data store
local DataStoreService = game:GetService("DataStoreService")
local PlayerSave = DataStoreService:GetDataStore("PlayerSave")
local RS = game:GetService("ReplicatedStorage")

--When the player enters the game, 
--create a leaderboard with their points and highscore
--and load their highscore onto the leaderboard.
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local MazePoints = Instance.new("IntValue")
	MazePoints.Name = "Points"
	MazePoints.Parent = leaderstats

	local MazeHighscore = Instance.new("IntValue")
	MazeHighscore.Name = "Highscore"
	MazeHighscore.Parent = leaderstats

	local Mazehighdata
	local success, errormessage = pcall(function()
		Mazehighdata = PlayerSave:GetAsync(player.UserId.."-MazeHighscore")
	end)

	if success then
		MazeHighscore.Value = Mazehighdata
	else
		print("error while saving data")
		warn(errormessage)
	end
	
	--everytime the character loads in, their points value resets,
	--and the highscore is sent to the title screen (HighscoreScript)
	player.CharacterAdded:Connect(function(char)
		print('CharacterLoaded')
		RS.Highscore:FireClient(player, MazeHighscore.Value)
		MazePoints.Value = 0
	end)
	
end)

--When the player leaves, save their highscore.
game.Players.PlayerRemoving:Connect(function(player)
	
	local success, errormessage = pcall(function()
		PlayerSave:SetAsync(player.UserId.."-MazeHighscore",player.leaderstats.Highscore.Value)
	end)

	if success then
		print("Player Data successfully saved!")
	else
		print("There was an error while saving data")
		warn(errormessage)
	end
end)
