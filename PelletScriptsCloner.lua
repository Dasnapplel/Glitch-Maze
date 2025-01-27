local pelletsFolder = script.Parent.Pellets
local powerFolder = script.Parent.PowerPellets

--copy and paste respective pellet script into every pellet
local function scriptCloner(folder, scriptToClone)	
	for i, pellet in ipairs(folder:GetChildren()) do
		local Clone = scriptToClone:Clone()
		Clone.Parent = pellet
		Clone.Enabled = true
	end
end

scriptCloner(pelletsFolder, script.PelletScript)
scriptCloner(powerFolder, script.PowerPelletScript)

script:Destroy()
