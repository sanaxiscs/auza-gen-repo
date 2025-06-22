-- Server Script inside ServerScriptService

local Players = game:GetService("Players")

-- Function to add highlight to a player's character
local function highlightCharacter(character)
	if not character:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Yellow
		highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
		highlight.OutlineTransparency = 0.5
		highlight.FillTransparency = 0.3
		highlight.Adornee = character
		highlight.Parent = character
	end
end

-- Called when a player's character spawns
local function onCharacterAdded(character)
	highlightCharacter(character)
end

-- Called when a player joins the game
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)

	-- If the character already exists
	if player.Character then
		highlightCharacter(player.Character)
	end
end

-- Connect existing and future players
for _, player in pairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

