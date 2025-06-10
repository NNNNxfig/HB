return function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera

    local adornments = {}

    local function createESP(player)
        if player == localPlayer then return end
        local character = player.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = hrp
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Size = Vector3.new(4, 5, 1.5)
        box.Transparency = 0.5
        box.Color3 = Color3.new(1, 0, 0) -- красный
        box.Parent = hrp

        adornments[player] = box
    end

    local function removeESP(player)
        local adorn = adornments[player]
        if adorn then
            adorn:Destroy()
            adornments[player] = nil
        end
    end

    local function onCharacterAdded(player, character)
        repeat wait() until character:FindFirstChild("HumanoidRootPart")
        wait(0.1)
        createESP(player)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            player.CharacterAdded:Connect(function(char)
                onCharacterAdded(player, char)
            end)
            if player.Character then
                onCharacterAdded(player, player.Character)
            end
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            onCharacterAdded(player, char)
        end)
    end)

    Players.PlayerRemoving:Connect(function(player)
        removeESP(player)
    end)
end
