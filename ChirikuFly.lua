--===[ Get Key System (from URL) ]===--
loadstring(game:HttpGet("https://raw.githubusercontent.com/Chiriku2013/Getkey/refs/heads/main/Getkey.lua"))()

--===[ Fly Script ]===--
-- Khi key nhập đúng, bật thông báo và script bay
game.StarterGui:SetCore("SendNotification", {
    Title = "Chiriku Fly",
    Text = "By: Chiriku Roblox",
    Duration = 5
})

-- Settings
getgenv().FlySpeed = 100 -- Tốc độ bay có thể chỉnh

-- UI Toggle
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
ScreenGui.Name = "FlyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Position = UDim2.new(0, 20, 0, 100)
ToggleButton.Text = "Fly: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Parent = ScreenGui

-- Fly logic
local flying = false
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local cam = workspace.CurrentCamera
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local velocity = Instance.new("BodyVelocity")
velocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
velocity.P = 1e5
velocity.Name = "FlyVelocity"

-- Toggle function
ToggleButton.MouseButton1Click:Connect(function()
    flying = not flying
    ToggleButton.Text = flying and "Fly: ON" or "Fly: OFF"
    if flying then
        velocity.Parent = hrp
    else
        velocity:Destroy()
    end
end)

-- Fly movement
RunService.RenderStepped:Connect(function()
    if flying then
        local moveDir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0, 1, 0) end
        velocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * getgenv().FlySpeed or Vector3.zero
    end
end)
