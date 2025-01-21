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
local espEnabled = false
local noclipEnabled = false

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

-- 점프 키 입력 핸들링
local function onJumpRequest()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
        if canDoubleJump then
            canDoubleJump = false
            jumpCount += 1

            -- 공중에서 추가 점프 수행
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            character.HumanoidRootPart.Velocity = Vector3.new(
                character.HumanoidRootPart.Velocity.X,
                75, -- 점프 높이 조절
                character.HumanoidRootPart.Velocity.Z
            )

            task.wait(doubleJumpCooldown)
            canDoubleJump = true
        end
    end
end

-- 입력 감지
UserInputService.JumpRequest:Connect(onJumpRequest)

-- 점프력 증가/복원
local jumpBoost = false
local function toggleJumpBoost()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        jumpBoost = not jumpBoost
        character.Humanoid.JumpPower = jumpBoost and 500 or 50
    end
end

-- 속도 증가/복원
local speedBoost = false
local function toggleSpeedBoost()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        speedBoost = not speedBoost
        character.Humanoid.WalkSpeed = speedBoost and 100 or 16
    end
end

-- 스핀 효과
local function toggleSpin()
    local character = LocalPlayer.Character
    if character then
        spinning = not spinning
        if spinning then
            while spinning do
                character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(100), 0))
                task.wait(0.1)
            end
        end
    end
end

-- 랜덤 방향으로 튕겨나가기
local function ejectPlayer()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local force = Instance.new("BodyVelocity", character.HumanoidRootPart)
        force.MaxForce = Vector3.new(100000, 100000, 100000)
        local randomDirection = Vector3.new(
            math.random(-100, 100),
            math.random(50, 200),
            math.random(-100, 100)
        ).Unit * 200
        force.Velocity = randomDirection
        task.wait(0.5)
        force:Destroy()
    end
end

-- 공중 날기
local function toggleFly()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        flying = not flying
        if flying then
            bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)

            bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
            bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
            bodyGyro.CFrame = character.HumanoidRootPart.CFrame

            UserInputService.InputBegan:Connect(function(input)
                if flying and input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- 상승
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if flying and input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- 상승 멈춤
                end
            end)

            while flying do
                local moveDirection = Vector3.new(
                    (character.Humanoid.MoveDirection.X * 50),
                    bodyVelocity.Velocity.Y,
                    (character.Humanoid.MoveDirection.Z * 50)
                )
                bodyVelocity.Velocity = moveDirection
                task.wait()
            end
        else
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end
end

-- ESP 활성화/비활성화
local function toggleESP()
    espEnabled = not espEnabled
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                if espEnabled then
                    -- ESP 활성화
                    local box = Instance.new("BoxHandleAdornment", char)
                    box.Adornee = char:FindFirstChild("Head")
                    box.Size = Vector3.new(2, 2, 1)
                    box.Color3 = Color3.new(1, 0, 0)
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Name = "ESP"
                else
                    -- ESP 비활성화
                    for _, obj in pairs(char:GetChildren()) do
                        if obj.Name == "ESP" then
                            obj:Destroy()
                        end
                    end
                end
            end
        end
    end
end

-- noclip 활성화/비활성화
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.PlatformStand = noclipEnabled
        character:WaitForChild("HumanoidRootPart").CanCollide = not noclipEnabled
    end
end

-- 앉기/일어서기
local function toggleSit()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        sitting = not sitting
        character.Humanoid.Sit = sitting
    end
end

-- 버튼 배치
createButton(Hub, "Jump Boost", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0, 0, 0, 0), toggleJumpBoost)
createButton(Hub, "Speed Boost", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.375, 0, 0, 0), toggleSpeedBoost)
createButton(Hub, "Spin", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.75, 0, 0, 0), toggleSpin)
createButton(Hub, "Eject", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0, 0, 0.8, 0), ejectPlayer)
createButton(Hub, "Sit/Stand", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.375, 0, 0.8, 0), toggleSit)
createButton(Hub, "Fly", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.75, 0, 0.8, 0), toggleFly)
createButton(Hub, "ESP", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.125, 0, 0.6, 0), toggleESP)
createButton(Hub, "Noclip", UDim2.new(0.25, 0, 0.2, 0), UDim2.new(0.625, 0, 0.6, 0), toggleNoclip)
]]

-- 로드스트링 실행
local func = loadstring(scriptCode)
if func then
    func()
else
    warn("Failed to load script")
end
