local glitch = script.Parent
local part1 = glitch.shifter1
local part2 = glitch.shifter2
local part3 = glitch.shifter3
local part4 = glitch.shifter4
local part5 = glitch.shifter5
local RESET_SECONDS = 10

while true do
	light = workspace.Lights:FindFirstChild('Lights')

	if light.BrickColor == BrickColor.White() then
		--make glitching transparent
		if part1.Transparency == 0 then
			part1.Transparency = 1
			part2.Transparency = 1
			part3.Transparency = 1
			part4.Transparency = 1
			part5.Transparency = 1
		end
			
		glitch.body.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				if glitch:GetAttribute("IsTouched") then return end --If attribute is true, exit the function
				glitch:SetAttribute("IsTouched", true)  -- Set attribute to true

				local humanoid = hit.Parent:FindFirstChild("Humanoid") 	
				glitch.body.BrickColor = BrickColor.new('White')
					
				local player = game.Players:GetPlayerFromCharacter(humanoid.Parent)
				-- Gets the player's leaderboard. Needed to get items and money
				local playerStats = player:FindFirstChild("leaderstats")
				-- Gets the player's items and money
				--local playerTickets = playerStats:FindFirstChild("Tickets")
				local playerPoints = playerStats:FindFirstChild("Points")
				local playerHigh = playerStats:FindFirstChild("Highscore")
				playerPoints.Value = playerPoints.Value + 250
				
				if playerPoints.Value > playerHigh.Value then
					playerHigh.Value = playerPoints.Value
				end

				wait(RESET_SECONDS)  -- Wait for reset time duration
				glitch:SetAttribute("IsTouched", nil)  -- Remove attribute
			end
		end)
	else
		--damage function
		glitch.body.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				hit.Parent.Humanoid:TakeDamage(100)
			end
		end) 
		
		--make glitching visible
		if part1.Transparency == 1 then
			part1.Transparency = 0
			part2.Transparency = 0
			part3.Transparency = 0
			part4.Transparency = 0
			part5.Transparency = 0
		end
		
		glitch.body.BrickColor = BrickColor.new('Really black')	
	end
	wait(0.1)
end