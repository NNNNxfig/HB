local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local flying = false
local direction = Vector3.zero
local flySpeed = 200
local teleportStep = 10

local function disableAnimations()
	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = true
	end
	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end
end

local function freezeOrientation()
	hrp.CFrame = CFrame.new(hrp.Position)
end

local inputStates = {
	W = false,
	A = false,
	S = false,
	D = false
}

local function updateDirection()
	direction = Vector3.zero
	if inputStates.W then direction = direction + Vector3.new(0, 0, -1) end
	if inputStates.S then direction = direction + Vector3.new(0, 0, 1) end
	if inputStates.A then direction = direction + Vector3.new(-1, 0, 0) end
	if inputStates.D then direction = direction + Vector3.new(1, 0, 0) end
	if direction.Magnitude > 0 then
		direction = direction.Unit
	end
end

local function enableFlight()
	flying = true
	humanoid.PlatformStand = true
	disableAnimations()
end

local function disableFlight()
	flying = false
	humanoid.PlatformStand = false
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	local key = input.KeyCode
	if key == Enum.KeyCode.T then
		if flying then disableFlight() else enableFlight() end
	end
	if not flying then return end
	if inputStates[key.Name] ~= nil then
		inputStates[key.Name] = true
		updateDirection()
	elseif key == Enum.KeyCode.E then
		hrp.CFrame = hrp.CFrame + Vector3.new(0, teleportStep, 0)
	elseif key == Enum.KeyCode.Q then
		hrp.CFrame = hrp.CFrame - Vector3.new(0, teleportStep, 0)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	local key = input.KeyCode
	if inputStates[key.Name] ~= nil then
		inputStates[key.Name] = false
		updateDirection()
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and hrp then
		local cam = workspace.CurrentCamera
		local moveVec = cam.CFrame:VectorToWorldSpace(direction)
		hrp.Velocity = moveVec * flySpeed
		freezeOrientation()
	end
end)

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = character:WaitForChild("Humanoid")
	hrp = character:WaitForChild("HumanoidRootPart")
	if flying then
		enableFlight()
	end
end)
