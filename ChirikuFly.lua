-- Gọi script kiểm tra key từ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/Getkey/refs/heads/main/Getkey.lua"))()

-- Sau khi kiểm tra key xong và key hợp lệ, tiếp tục phần code bay
local correctKey = "ChirikuNigga" -- Đây là key đúng bạn muốn sử dụng

-- Tạo một function để bay
local function enableFly()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local flying = false
    local bodyVelocity

    -- Bật/tắt bay
    local function toggleFly()
        if flying then
            bodyVelocity:Destroy()
            flying = false
        else
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)
            bodyVelocity.Parent = char.HumanoidRootPart
            flying = true
        end
    end

    -- Bật/tắt bay khi nhấn phím Space
    local UIS = game:GetService("UserInputService")
    UIS.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space then
            toggleFly()
        end
    end)
end

-- Kiểm tra key sau khi load xong
if getKeyResult == "correct_key" then  -- Kiểm tra xem key có đúng hay không (đây là ví dụ, bạn sẽ dùng hệ thống của script Getkey.lua)
    -- Sau khi key đúng, bật fly
    enableFly()
else
    -- Nếu key sai, không làm gì
end
