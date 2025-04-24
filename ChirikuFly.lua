-- Gọi script kiểm tra key từ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/Getkey/refs/heads/main/Getkey.lua"))()

-- Sau khi kiểm tra key xong và key hợp lệ, tiếp tục phần code bay
local correctKey = "ChirikuNigga" -- Đây là key đúng bạn muốn sử dụng

-- Tạo UI bay
local function createFlyUI()
    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "FlyUI"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Text = "FLY SYSTEM"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 24
    title.Position = UDim2.new(0.5, 0, 0, 5)
    title.AnchorPoint = Vector2.new(0.5, 0)

    local flyButton = Instance.new("TextButton", frame)
    flyButton.Text = "Toggle Fly"
    flyButton.Size = UDim2.new(0, 200, 0, 50)
    flyButton.Position = UDim2.new(0.5, -100, 0.5, -25)
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyButton.Font = Enum.Font.SourceSansBold
    flyButton.TextSize = 20
    Instance.new("UICorner", flyButton)

    -- Hover effect
    flyButton.MouseEnter:Connect(function()
        flyButton.BackgroundTransparency = 0.1
    end)
    flyButton.MouseLeave:Connect(function()
        flyButton.BackgroundTransparency = 0
    end)

    -- Bật/tắt bay khi nhấn nút Fly
    local flying = false
    local bodyVelocity, bodyGyro
    flyButton.MouseButton1Click:Connect(function()
        if flying then
            -- Tắt bay, hủy các đối tượng di chuyển
            bodyVelocity:Destroy()
            bodyGyro:Destroy()
            flying = false
        else
            -- Bắt đầu bay, tạo các đối tượng điều khiển bay
            local char = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
            
            -- Tạo BodyVelocity để điều khiển chuyển động bay
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = humanoidRootPart

            -- Tạo BodyGyro để giữ thăng bằng trong không gian 3D
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            bodyGyro.Parent = humanoidRootPart

            -- Cập nhật chuyển động bay dựa vào các phím WASD hoặc di chuyển chuột
            game:GetService("RunService").RenderStepped:Connect(function(_, dt)
                if flying then
                    local moveDirection = Vector3.new(0, 0, 0)

                    -- Điều khiển bằng các phím WASD
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + humanoidRootPart.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - humanoidRootPart.CFrame.LookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - humanoidRootPart.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + humanoidRootPart.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end

                    -- Áp dụng lực di chuyển
                    bodyVelocity.Velocity = moveDirection * 50
                    bodyGyro.CFrame = humanoidRootPart.CFrame
                end
            end)
            flying = true
        end
    end)
end

-- Kiểm tra key sau khi load xong
if getKeyResult == "correct_key" then  -- Kiểm tra xem key có đúng hay không (đây là ví dụ, bạn sẽ dùng hệ thống của script Getkey.lua)
    -- Sau khi key đúng, tạo UI bay
    createFlyUI()
else
    -- Nếu key sai, không làm gì
end
