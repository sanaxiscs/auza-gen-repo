-- Works with any executor (client-side)
-- Adds UI and red highlights to other players

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
print(deneme)
local function createHighlight(char)
    if char and not char:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red
        highlight.FillTransparency = 0.3
        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlight.OutlineTransparency = 0.5
        highlight.Adornee = char
        highlight.Parent = char
    end
end

local function removeHighlight(char)
    local h = char and char:FindFirstChild("Highlight")
    if h then h:Destroy() end
end

local function updateAllHighlights(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if state then
                createHighlight(player.Character)
            else
                removeHighlight(player.Character)
            end
        end
    end
end

-- Watch for character spawns
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            wait(1)
            if _G.HighlightsEnabled then
                createHighlight(char)
            end
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(1)
        if _G.HighlightsEnabled then
            createHighlight(char)
        end
    end)
end)

-- Create a UI toggle
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "HighlightToggleUI"

local Button = Instance.new("TextButton", ScreenGui)
Button.Size = UDim2.new(0, 150, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 10)
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Text = "Enable Highlights"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 18
Button.BorderSizePixel = 0

-- Toggle logic
_G.HighlightsEnabled = false

Button.MouseButton1Click:Connect(function()
    _G.HighlightsEnabled = not _G.HighlightsEnabled
    Button.Text = _G.HighlightsEnabled and "Disable Highlights" or "Enable Highlights"
    updateAllHighlights(_G.HighlightsEnabled)
end)
