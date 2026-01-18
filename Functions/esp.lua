-- Простой ESP для команд
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function simpleTeamESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- Удаляем старый ESP
            local oldHighlight = player.Character:FindFirstChild("SimpleESP")
            if oldHighlight then
                oldHighlight:Destroy()
            end
            
            -- Определяем цвет
            local color = Color3.fromRGB(255, 255, 0) -- Желтый по умолчанию
            
            if LocalPlayer.Team and player.Team then
                if player.Team == LocalPlayer.Team then
                    color = Color3.fromRGB(0, 255, 0) -- Зеленый
                else
                    color = Color3.fromRGB(255, 0, 0) -- Красный
                end
            end
            
            -- Создаем подсветку
            local highlight = Instance.new("Highlight")
            highlight.Name = "SimpleESP"
            highlight.FillColor = color
            highlight.FillTransparency = 0.8
            highlight.OutlineColor = color
            highlight.OutlineTransparency = 0.3
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee = player.Character
            highlight.Parent = player.Character
            
            -- Делаем видимым сквозь стены
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        end
    end
end

-- Обновление каждые 2 секунды
while true do
    simpleTeamESP()
    wait(2)
end
