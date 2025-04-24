-- Notification khi execute
game.StarterGui:SetCore("SendNotification", {
    Title = "Fly Movement",
    Text = "By: Chiriku Roblox",
    Duration = 5
})

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
        local moveDir = Player:GetMouse().Hit.Position - HRP.Position
        moveDir = Vector3.new(moveDir.X, 0, moveDir.Z).Unit * speed
        if moveDir.Magnitude ~= moveDir.Magnitude then moveDir = Vector3.zero end
        bodyVel.Velocity = moveDir
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
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
