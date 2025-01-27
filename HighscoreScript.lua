local RS = game:GetService("ReplicatedStorage")

--Get Highscore from leaderboard_Save script through a RemoteEvent
--Change text to 'Highscore: (number)'
RS.Highscore.OnClientEvent:Connect(function(highscore)
	script.Parent.Text = "Highscore: "..highscore
end)