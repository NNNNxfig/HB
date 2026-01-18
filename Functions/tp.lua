local function teleportOnClick(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        if mouse.Target then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
            end
        end
    end
end
