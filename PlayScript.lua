--wait for the game to load so that the variables work
repeat
	wait()
until game:IsLoaded()

local camera = workspace.CurrentCamera
local button = script.Parent
local player = game.Players.LocalPlayer
local char = player.Character
local hum = char.Humanoid

camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = workspace.StartCam.CFrame

--player can't move before starting the game
hum.WalkSpeed = 0
hum.JumpHeight = 0

--play button starts game by
--removing menu gui, setting camera back to normal, and giving the player movement
button.Activated:Connect(function()
	camera.CameraType = Enum.CameraType.Custom
	button.Parent.Visible = false
	
	hum.WalkSpeed = 25
	hum.JumpHeight = 7
end)