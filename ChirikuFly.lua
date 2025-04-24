local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local flying = false
local speed = 350
local bodyGyro, bodyVelocity

-- Tạo UI với nút điều khiển trên mobile
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo nút toggle cho bay
local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 100, 0, 100)
toggleButton.Position = UDim2.new(0.9, -50, 0.9, -50)  -- Vị trí nút toggle
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://6031090507"  -- ID hình ảnh bật bay
toggleButton.Parent = screenGui

-- Gửi thông báo khi execute script lần đầu
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Fly Movement",
    Text = "By: Chiriku Roblox",
    Duration = 5
})

-- Chức năng bắt đầu bay
local function startFlying()
    flying = true
    bodyGyro = Instance.new("BodyGyro")
    bodyVelocity = Instance.new("BodyVelocity")
    
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.CFrame = player.Character.HumanoidRootPart.CFrame
    bodyGyro.Parent = player.Character.HumanoidRootPart

    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Velocity = Vector3.new(0, speed, 0)
    bodyVelocity.Parent = player.Character.HumanoidRootPart

    -- Điều chỉnh hướng bay
    local position = player.Character.HumanoidRootPart.Position
    local targetPos = mouse.Hit.p
    game:GetService("RunService").Heartbeat:Connect(function()
        if flying then
            local direction = (targetPos - position).unit
            bodyVelocity.Velocity = direction * speed
        end
    end)
end

-- Chức năng dừng bay
local function stopFlying()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

-- Toggle bay khi nhấn vào ImageButton
toggleButton.MouseButton1Click:Connect(function()
    if flying then
        stopFlying()
        toggleButton.Image = "rbxassetid://6031090515"  -- ID hình ảnh tắt bay
    else
        startFlying()
        toggleButton.Image = "rbxassetid://6031090507"  -- ID hình ảnh bật bay
    end
end)
