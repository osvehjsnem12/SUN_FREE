local scriptCode = [[
-- 클라이언트 스크립트
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI 생성
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Hub = Instance.new("Frame", ScreenGui)
Hub.Size = UDim2.new(0.375, 0, 0.325, 0)  -- 허브 크기
Hub.Position = UDim2.new(0.3125, 0, 0.45, 0)  -- 위치 조정
Hub.BackgroundColor3 = Color3.new(0, 0, 0)
Hub.BackgroundTransparency = 0.5
Hub.Active = true
Hub.Draggable = true -- 드래그 가능

-- 버튼 생성
local Button = Instance.new("TextButton", Hub)
Button.Size = UDim2.new(0.25, 0, 0.65, 0)  -- 버튼 크기
Button.Position = UDim2.new(0.375, 0, 0.175, 0)  -- 위치 조정
Button.Text = "스피드 증가"
Button.TextColor3 = Color3.new(0, 0, 0)
Button.BackgroundColor3 = Color3.new(1, 0, 0)
Button.BorderSizePixel = 0
Button.Font = Enum.Font.SourceSans
Button.TextScaled = true

-- Made by SUN 텍스트 추가
local Footer = Instance.new("TextLabel", Hub)
Footer.Size = UDim2.new(1, 0, 0.2, 0)
Footer.Position = UDim2.new(0, 0, 0.8, 0)
Footer.Text = "Made by SUN"
Footer.TextColor3 = Color3.new(0, 0, 0)
Footer.BackgroundTransparency = 1
Footer.TextScaled = true
Footer.Font = Enum.Font.SourceSans

-- 버튼 클릭 이벤트
Button.MouseButton1Click:Connect(function()
    -- 플레이어의 스피드를 100으로 설정
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 100
    else
        warn("Character or Humanoid not found!")
    end
end)
]]

-- 로드스트링 실행
local func = loadstring(scriptCode)
if func then
    func()
else
    warn("Failed to load script")
end
