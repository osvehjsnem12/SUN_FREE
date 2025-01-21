local scriptCode = [[
-- 클라이언트 스크립트
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI 생성
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Hub = Instance.new("Frame", ScreenGui)
Hub.Size = UDim2.new(0.3, 0, 0.1, 0)
Hub.Position = UDim2.new(0.35, 0, 0.45, 0)
Hub.BackgroundColor3 = Color3.new(0, 0, 0)
Hub.BackgroundTransparency = 0.5
Hub.Active = true
Hub.Draggable = true -- 드래그 가능

-- 버튼 생성
local Button = Instance.new("TextButton", Hub)
Button.Size = UDim2.new(0.5, 0, 0.5, 0)
Button.Position = UDim2.new(0.25, 0, 0.25, 0)
Button.Text = "폭발 올"
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
    for _, character in ipairs(workspace:GetDescendants()) do
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and character ~= LocalPlayer.Character then
            local explosion = Instance.new("Explosion")
            explosion.Position = humanoid.Parent.PrimaryPart.Position
            explosion.BlastRadius = 5
            explosion.BlastPressure = 50000
            explosion.Parent = workspace

            explosion.Hit:Connect(function(hit)
                if hit.Parent:FindFirstChildOfClass("Humanoid") then
                    local targetHumanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
                    if targetHumanoid and targetHumanoid ~= LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                        targetHumanoid:TakeDamage(1000000)
                    end
                end
            end)
        end
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
