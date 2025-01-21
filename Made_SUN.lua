local scriptCode = [[
-- 클라이언트 스크립트
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local flying = false
local spinning = false
local sitting = false
local bodyVelocity, bodyGyro
local canDoubleJump = true
local doubleJumpCooldown = 0.2
local jumpCount = 0
local originalJumpPower = 50
local jumpBoost = false
local flyEnabled = false
local speedBoost = false
local spinBoost = false
local canDoubleJump = true
local isFlying = false

-- GUI 생성
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Hub = Instance.new("Frame", ScreenGui)
Hub.Size = UDim2.new(0.375, 0, 0.65, 0)
Hub.Position = UDim2.new(0.3125, 0, 0.35, 0)
Hub.BackgroundColor3 = Color3.new(0, 0, 0)
Hub.BackgroundTransparency = 0.5
Hub.Active = true
Hub.Draggable = true

-- Made by SUN 텍스트
local Label = Instance.new("TextLabel", Hub)
Label.Size = UDim2.new(1, 0, 0.1, 0)
Label.Position = UDim2.new(0, 0, 0.45, 0)
Label.Text = "Made by SUN"
Label.TextColor3 = Color3.new(1, 1, 1)
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.SourceSans
Label.TextScaled = true

-- 버튼 생성 함수
local function createButton(parent, text, size, position, callback)
    local Button = Instance.new("TextButton", parent)
    Button.Size = size
    Button.Position = position
    Button.Text = text
    Button.TextColor3 = Color3.new(0, 0, 0)
    Button.BackgroundColor3 = Color3.new(1, 0, 0)
    Button.BorderSizePixel = 0
    Button.Font = Enum.Font.SourceSans
    Button.TextScaled = true
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- 점프 부스트: 점프력 증가/복원
local function toggleJumpBoost()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        jumpBoost = not jumpBoost
        character.Humanoid.JumpPower = jumpBoost and 500 or originalJumpPower
    end
end

-- 스피드 부스트
local function toggleSpeedBoost()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        speedBoost = not speedBoost
        character.Humanoid.WalkSpeed = speedBoost and 100 or 16
    end
end

-- 스핀 기능
local function toggleSpinBoost()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        spinning = not spinning
        if spinning then
            -- 스핀 파워 100 설정
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(100), 0)
        end
    end
end

-- 튕겨내기
local function toggleKnockBack()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        local direction = Vector3.new(math.random(), 1, math.random()).unit
        character.HumanoidRootPart.Velocity = direction * 100
    end
end

-- 공중 날기
local function toggleFly()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        isFlying = not isFlying
        if isFlying then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
            bodyVelocity.Velocity = Vector3.new(0, 10, 0)
            bodyVelocity.Parent = character.HumanoidRootPart
        else
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end
end

-- 점프 부스트
createButton(Hub, "Jump Boost", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0, 0, 0, 0), toggleJumpBoost)
-- 스피드 부스트
createButton(Hub, "Speed Boost", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.25, 0, 0, 0), toggleSpeedBoost)
-- 스핀
createButton(Hub, "Spin", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.5, 0, 0, 0), toggleSpinBoost)
-- 튕겨내기
createButton(Hub, "Knock Back", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0, 0, 0.2, 0), toggleKnockBack)
-- 플라이
createButton(Hub, "Fly", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.25, 0, 0.2, 0), toggleFly)
]]

-- 로드스트링 실행
local func = loadstring(scriptCode)
if func then
    func()
else
    warn("Failed to load script")
end
