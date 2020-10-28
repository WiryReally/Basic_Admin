local plugin_c = require(script.plugin_command) --plugin_command.lua
local Players = game:GetService("Players")
local Prefix = "!"
local AdminsDef = {}
local AD = {}
AD.__index = AD

function AD.SetAdminTable(AdminTable)
	local Table = {}
	local function FindPlr(v)
		local UD = tonumber(v)
		local Name
		if UD then
			Name = Players:GetNameFromUserIdAsync(UD)
		elseif type(v) == "string" then
			UD = Players:GetUserIdFromNameAsync(v)
			Name = v
		end
		return tostring(UD) , {
			["Name"] = Name;
		}
	end
	for _ , v in ipairs(AdminTable) do
		local index , value = FindPlr(v)
		Table[index] = value
	end
	return Table
end

function AD.new(AdminS , CommandsFunctions)
	local List = AdminS or AdminsDef
	local self = setmetatable({
		["Commands"] = CommandsFunctions or plugin_c;
		["AdminList"] = List;
	}, AD)
	
	return self
end

local function ParseMessage(Player,Message)
	local PrefixMatch = string.match(Message,"^".."!")
	local Arguments
	local functionName
	if PrefixMatch then
		Message = string.gsub(Message,PrefixMatch,"",1)
		Arguments = string.split(Message , " ")
		functionName = table.remove(Arguments, 1)
	end
	return Message , functionName , Arguments
end

function AD:RemoveAdmin()
end

function AD:AddAdmin()
end

function CheckName(self , player)
	local UD = player.UserId
	local RealName = Players:GetNameFromUserIdAsync(UD)
	local VAdmin = self["AdminList"][tostring(UD)]
	if VAdmin then
		VAdmin["Name"] = RealName
		return VAdmin
	end
end

function AD:IsAdmin(plr)
	if plr then
		local UserID_ = self["AdminList"][tostring(plr.UserId)]
		if UserID_ and CheckName(self , plr) then
			return true
		else
			return false
		end
	end
end

function AD:CheckCommand(Message , Player)
	local _IsAdmin = self:IsAdmin(Player)
	if _IsAdmin then
		local msg , cmdname , arg = ParseMessage(Players,Message)
		if msg then
			plugin_c[cmdname](unpack(arg))
		end
	end
end

return AD
