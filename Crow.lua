local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
 
local player = Players.LocalPlayer
 
-- GUI 생성
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MysticHubGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
 
-- 이름 텍스트 (위쪽)
local hubTitle = Instance.new("TextLabel")
hubTitle.Text = "%0"
hubTitle.Size = UDim2.new(0, 200, 0, 50)
hubTitle.Position = UDim2.new(0.5, -100, 0.4, -100)
hubTitle.BackgroundTransparency = 1
hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hubTitle.Font = Enum.Font.SourceSansBold
hubTitle.TextSize = 24
hubTitle.Parent = screenGui
 
-- 제작자 텍스트 (아래쪽)
local creatorLabel = Instance.new("TextLabel")
creatorLabel.Text = "제작자: 크로우"
creatorLabel.Size = UDim2.new(0, 200, 0, 50)
creatorLabel.Position = UDim2.new(0.5, -100, 0.6, 0)
creatorLabel.BackgroundTransparency = 1
creatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creatorLabel.Font = Enum.Font.SourceSans
creatorLabel.TextSize = 18
creatorLabel.Parent = screenGui
 
-- 버튼 생성
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.5, -25)
button.Text = "개복치 허브 열기"
button.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Parent = screenGui
 
-- 버튼 클릭 이벤트
button.MouseButton1Click:Connect(function()
    -- 기존 GUI 숨기기
    screenGui.Enabled = false
 
    -- 개복치 허브 GUI 생성
    local hubGui = Instance.new("ScreenGui")
    hubGui.Name = "개복치허브"
    hubGui.Parent = player:WaitForChild("PlayerGui")
 
    -- 허브 이름
    local hubTitle = Instance.new("TextLabel")
    hubTitle.Text = "🌊 개복치의 신기한 허브 🌊"
    hubTitle.Size = UDim2.new(0, 400, 0, 50)
    hubTitle.Position = UDim2.new(0.5, -200, 0.1, 0)
    hubTitle.BackgroundTransparency = 0.3
    hubTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
    hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    hubTitle.Font = Enum.Font.SourceSansBold
    hubTitle.TextSize = 24
    hubTitle.Parent = hubGui
 
    -- 제작자 정보
    local creatorLabel = Instance.new("TextLabel")
    creatorLabel.Text = "제작자: 크로우 & 개복치"
    creatorLabel.Size = UDim2.new(0, 400, 0, 30)
    creatorLabel.Position = UDim2.new(0.5, -200, 0.2, 0)
    creatorLabel.BackgroundTransparency = 1
    creatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    creatorLabel.Font = Enum.Font.SourceSans
    creatorLabel.TextSize = 18
    creatorLabel.Parent = hubGui
 
    -- 폭발 버튼 생성
    local explosionButton = Instance.new("TextButton")
    explosionButton.Text = "폭발 시작"
    explosionButton.Size = UDim2.new(0, 150, 0, 50)
    explosionButton.Position = UDim2.new(0.5, -75, 0.4, 0)
    explosionButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    explosionButton.TextColor3 = Color3.new(1, 1, 1)
    explosionButton.Font = Enum.Font.SourceSansBold
    explosionButton.TextSize = 16
    explosionButton.Parent = hubGui
 
    -- 폭발 실행 상태
    local isExploding = false
    local explosionLoop
 
    -- 폭발 함수 (자신 제외)
    local function explodePlayers()
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            -- 자신을 제외한 다른 플레이어들만 폭발 처리
            if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- 폭발 생성
                    local explosion = Instance.new("Explosion")
                    explosion.Position = rootPart.Position
                    explosion.BlastRadius = 10
                    explosion.BlastPressure = 5000
                    explosion.Parent = workspace
 
                    -- 데미지 처리
                    humanoid:TakeDamage(100)
                    Debris:AddItem(explosion, 5)
                end
            end
        end
    end
 
    -- 폭발 버튼 클릭 이벤트
    explosionButton.MouseButton1Click:Connect(function()
        if isExploding then
            -- 폭발 중지
            isExploding = false
            explosionButton.Text = "폭발 시작"
            if explosionLoop then
                explosionLoop:Disconnect()
            end
        else
            -- 폭발 시작
            isExploding = true
            explosionButton.Text = "폭발 중지"
            explosionLoop = RunService.Heartbeat:Connect(explodePlayers)
        end
    end)
 
    -- 닫기 버튼
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "허브 닫기"
    closeButton.Size = UDim2.new(0, 150, 0, 50)
    closeButton.Position = UDim2.new(0.5, -75, 0.6, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 16
    closeButton.Parent = hubGui
 
    -- 닫기 버튼 클릭 이벤트
    closeButton.MouseButton1Click:Connect(function()
        if explosionLoop then
            explosionLoop:Disconnect()
        end
        hubGui:Destroy()
        screenGui.Enabled = true
    end)
end)local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
 
local player = Players.LocalPlayer
 
-- GUI 생성
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MysticHubGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
 
-- 이름 텍스트 (위쪽)
local hubTitle = Instance.new("TextLabel")
hubTitle.Text = "%0"
hubTitle.Size = UDim2.new(0, 200, 0, 50)
hubTitle.Position = UDim2.new(0.5, -100, 0.4, -100)
hubTitle.BackgroundTransparency = 1
hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hubTitle.Font = Enum.Font.SourceSansBold
hubTitle.TextSize = 24
hubTitle.Parent = screenGui
 
-- 제작자 텍스트 (아래쪽)
local creatorLabel = Instance.new("TextLabel")
creatorLabel.Text = "제작자: 크로우"
creatorLabel.Size = UDim2.new(0, 200, 0, 50)
creatorLabel.Position = UDim2.new(0.5, -100, 0.6, 0)
creatorLabel.BackgroundTransparency = 1
creatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creatorLabel.Font = Enum.Font.SourceSans
creatorLabel.TextSize = 18
creatorLabel.Parent = screenGui
 
-- 버튼 생성
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.5, -25)
button.Text = "개복치 허브 열기"
button.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Parent = screenGui
 
-- 버튼 클릭 이벤트
button.MouseButton1Click:Connect(function()
    -- 기존 GUI 숨기기
    screenGui.Enabled = false
 
    -- 개복치 허브 GUI 생성
    local hubGui = Instance.new("ScreenGui")
    hubGui.Name = "개복치허브"
    hubGui.Parent = player:WaitForChild("PlayerGui")
 
    -- 허브 이름
    local hubTitle = Instance.new("TextLabel")
    hubTitle.Text = "🌊 개복치의 신기한 허브 🌊"
    hubTitle.Size = UDim2.new(0, 400, 0, 50)
    hubTitle.Position = UDim2.new(0.5, -200, 0.1, 0)
    hubTitle.BackgroundTransparency = 0.3
    hubTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
    hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    hubTitle.Font = Enum.Font.SourceSansBold
    hubTitle.TextSize = 24
    hubTitle.Parent = hubGui
 
    -- 제작자 정보
    local creatorLabel = Instance.new("TextLabel")
    creatorLabel.Text = "제작자: 크로우 & 개복치"
    creatorLabel.Size = UDim2.new(0, 400, 0, 30)
    creatorLabel.Position = UDim2.new(0.5, -200, 0.2, 0)
    creatorLabel.BackgroundTransparency = 1
    creatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    creatorLabel.Font = Enum.Font.SourceSans
    creatorLabel.TextSize = 18
    creatorLabel.Parent = hubGui
 
    -- 폭발 버튼 생성
    local explosionButton = Instance.new("TextButton")
    explosionButton.Text = "폭발 시작"
    explosionButton.Size = UDim2.new(0, 150, 0, 50)
    explosionButton.Position = UDim2.new(0.5, -75, 0.4, 0)
    explosionButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    explosionButton.TextColor3 = Color3.new(1, 1, 1)
    explosionButton.Font = Enum.Font.SourceSansBold
    explosionButton.TextSize = 16
    explosionButton.Parent = hubGui
 
    -- 폭발 실행 상태
    local isExploding = false
    local explosionLoop
 
    -- 폭발 함수 (자신 제외)
    local function explodePlayers()
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            -- 자신을 제외한 다른 플레이어들만 폭발 처리
            if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- 폭발 생성
                    local explosion = Instance.new("Explosion")
                    explosion.Position = rootPart.Position
                    explosion.BlastRadius = 10
                    explosion.BlastPressure = 5000
                    explosion.Parent = workspace
 
                    -- 데미지 처리
                    humanoid:TakeDamage(100)
                    Debris:AddItem(explosion, 5)
                end
            end
        end
    end
 
    -- 폭발 버튼 클릭 이벤트
    explosionButton.MouseButton1Click:Connect(function()
        if isExploding then
            -- 폭발 중지
            isExploding = false
            explosionButton.Text = "폭발 시작"
            if explosionLoop then
                explosionLoop:Disconnect()
            end
        else
            -- 폭발 시작
            isExploding = true
            explosionButton.Text = "폭발 중지"
            explosionLoop = RunService.Heartbeat:Connect(explodePlayers)
        end
    end)
 
    -- 닫기 버튼
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "허브 닫기"
    closeButton.Size = UDim2.new(0, 150, 0, 50)
    closeButton.Position = UDim2.new(0.5, -75, 0.6, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 16
    closeButton.Parent = hubGui
 
    -- 닫기 버튼 클릭 이벤트
    closeButton.MouseButton1Click:Connect(function()
        if explosionLoop then
            explosionLoop:Disconnect()
        end
        hubGui:Destroy()
        screenGui.Enabled = true
    end)
end)
