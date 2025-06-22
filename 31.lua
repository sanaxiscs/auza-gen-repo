local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local button = script.Parent
local highlightsEnabled = false

-- Function to add a red highlight to a character
local function addHighlightToCharacter(character)
	if not character:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.FillColor = Color3.fromRGB(255, 0, 0) -- 🔴 Red
		highlight.FillTransparency = 0.3
		highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
		highlight.OutlineTransparency = 0.5
		highlight.Adornee = character
		highlight.Parent = character
	end
end

-- Remove highlight from character
local function removeHighlightFromCharacter(character)
	local highlight = character:FindFirstChild("Highlight")
	if highlight then
		highlight:Destroy()
	end
end

-- Toggle all highlights
local function toggleHighlights()
	highlightsEnabled = not highlightsEnabled

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			if highlightsEnabled then
				addHighlightToCharacter(player.Character)
			else
				removeHighlightFromCharacter(player.Character)
			end
		end
	end

	button.Text = highlightsEnabled and "Disable Highlights" or "Enable Highlights"
end

-- Update highlights when players respawn
local function onCharacterAdded(character)
	if highlightsEnabled then
		addHighlightToCharacter(character)
	end
end

-- Connect to new players
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end)

for _, player in pairs(Players:GetPlayers()) do
	if player ~= localPlayer then
		player.CharacterAdded:Connect(onCharacterAdded)
	end
end

-- Bind button
button.MouseButton1Click:Connect(toggleHighlights)
