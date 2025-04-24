-- Key System
loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/Getkey/refs/heads/main/Getkey.lua"))(function()
    -- Nếu key đúng, chạy script fly movement bên dưới:

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Char = Player.Character or Player.CharacterAdded:Wait()
    local HRP = Char:WaitForChild("HumanoidRootPart")
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("RunService")

    -- UI Toggle Button
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "FlyToggleUI"

    local Button = Instance.new("ImageButton", ScreenGui)
    Button.Size = UDim2.new(0, 50, 0, 50)
    Button.Position = UDim2.new(0, 10, 0, 10)
    Button.BackgroundTransparency = 1
    Button.Image = "rbxassetid://119198835819797"

    -- Variables
    local flying = false
    local speed = 120
    local control = {F = 0, B = 0, L = 0, R = 0, Y = 0}

    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)

    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.P = 1e4

    -- Fly function
    local function Fly()
        if flying then return end
        flying = true
        bodyGyro.CFrame = HRP.CFrame
        bodyGyro.Parent = HRP
        bodyVel.Parent = HRP

        RS:BindToRenderStep("FlyLoop", Enum.RenderPriority.Character.Value, function()
            if not flying then return end
            Char:FindFirstChildOfClass("Humanoid").PlatformStand = true
            local cam = workspace.CurrentCamera
            local move = Vector3.new(control.L + control.R, control.Y, control.F + control.B)
            move = cam.CFrame:VectorToWorldSpace(move)
            bodyVel.Velocity = move.Unit * speed
            bodyGyro.CFrame = cam.CFrame
        end)
    end

    local function StopFly()
        flying = false
        Char:FindFirstChildOfClass("Humanoid").PlatformStand = false
        RS:UnbindFromRenderStep("FlyLoop")
        bodyGyro:Destroy()
        bodyVel:Destroy()
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.P = 1e4
    end

    -- Toggle button click
    Button.MouseButton1Click:Connect(function()
        if flying then StopFly() else Fly() end
    end)

    -- Key movement
    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        local k = input.KeyCode
        if k == Enum.KeyCode.W then control.F = -1 end
        if k == Enum.KeyCode.S then control.B = 1 end
        if k == Enum.KeyCode.A then control.L = -1 end
        if k == Enum.KeyCode.D then control.R = 1 end
        if k == Enum.KeyCode.Space then control.Y = 1 end
        if k == Enum.KeyCode.LeftShift then control.Y = -1 end
    end)

    UIS.InputEnded:Connect(function(input)
        local k = input.KeyCode
        if k == Enum.KeyCode.W then control.F = 0 end
        if k == Enum.KeyCode.S then control.B = 0 end
        if k == Enum.KeyCode.A then control.L = 0 end
        if k == Enum.KeyCode.D then control.R = 0 end
        if k == Enum.KeyCode.Space or k == Enum.KeyCode.LeftShift then control.Y = 0 end
    end)

    -- Auto start on mobile
    if UIS.TouchEnabled and not UIS.KeyboardEnabled then
        wait(1)
        Fly()
    end
end)
