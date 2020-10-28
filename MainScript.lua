local ad_t = require(game.ServerScriptService.Admin_Test)
local RunService = game:GetService("RunService")
local AdminCommand = ad_t.new(ad_t.SetAdminTable({"WiryReally"}))

function PlayerAdded(p)
	p.Chatted:Connect(function(message)
		AdminCommand:CheckCommand(message , p)
	end)
end

game.Players.PlayerAdded:Connect(PlayerAdded)
if RunService:IsStudio() then
	for i,v in next,game.Players:GetPlayers() do
		PlayerAdded(v)                         --This for Studio Mode
	end
end
