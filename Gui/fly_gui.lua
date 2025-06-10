local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.ResetOnSpawn = false

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 200, 0, 50)
label.Position = UDim2.new(0, 10, 0, 10)
label.Text = "Press T to Fly"
label.Parent = ScreenGui

ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
