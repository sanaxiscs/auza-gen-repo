-- Butona basıldığında TextLabel'in görünmesini sağlar

-- Nesneleri tanımla
local button = script.Parent
local screenGui = button.Parent
local textLabel = screenGui:WaitForChild("TextLabel")

-- Başlangıçta TextLabel gizli olsun
textLabel.Visible = false

-- Butona tıklandığında çalışacak fonksiyon
button.MouseButton1Click:Connect(function()
	textLabel.Text = "Merhaba, Roblox!"
	textLabel.Visible = true
end)
