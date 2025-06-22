-- Client-side executor script
-- Press "H" to toggle red highlights on all players

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local highlightsEnabled = false

-- Function to create highlight
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

-- Function to remove highlight
local function removeHighlight(char)
	local h = char:FindFirstChild("Highlight")
	if h then
		h:Destroy()
	end
end

-- Apply or remove highlights
local function updateHighlights()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			if highlightsEnabled then
				createHighlight(player.Character)
			else
				removeHighlight(player.Character)
			end
		end
	end
end

-- Monitor player spawns
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		if highlightsEnabled then
			createHighlight(char)
		end
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer and player.Character then
		player.CharacterAdded:Connect(function(char)
			if highlightsEnabled then
				createHighlight(char)
			end
		end)
	end
end

-- Toggle keybind: "H"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
		highlightsEnabled = not highlightsEnabled
		updateHighlights()
		if highlightsEnabled then
			print("🔴 Highlights ENABLED")
		else
			print("❌ Highlights DISABLED")
		end
	end
end)
