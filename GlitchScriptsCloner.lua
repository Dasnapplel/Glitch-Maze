local glitch1 = script.Parent.KillerGlitchBlue
local glitch2 = script.Parent.KillerGlitchRed
local glitch3 = script.Parent.KillerGlitchGreen
local glitch4 = script.Parent.KillerGlitchPurple
local randy = script.Parent.Randy

local glitchArray = {glitch1, glitch2, glitch3, glitch4}

for i, glitch in pairs(glitchArray) do
	local mazemoving = script.MazeMoving:Clone()
	mazemoving.Parent = glitch
	mazemoving.Enabled = true
	
	local damage = script.GlitchDamageScript:Clone()
	damage.Parent = glitch
	damage.Enabled = true
end

local mazemoving = script.MazeMoving:Clone()
mazemoving.Parent = randy
mazemoving.Enabled = true

script:Destroy()
