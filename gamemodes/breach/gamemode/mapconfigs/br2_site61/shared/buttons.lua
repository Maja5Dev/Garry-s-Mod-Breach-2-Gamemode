
XXXXXXXXXXXXXXXXXXXXXXX = Vector(0,0,0)
YYYYYYYYYYYYYYYYYYYYYYYY = Vector(0,0,0)
ZZZZZZZZZZZZZZZZZZZZZZZZ = Angle(0,0,0)

MAPCONFIG.BUTTONS_2D = {}

function Buttons_Containers_TestPos(pos)
	for i,v in ipairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		local dist = v.pos:Distance(pos)
		if dist < 25 then
			print(i, dist, v.pos)
		end
	end
end
-- lua_run Buttons_Containers_TestPos(XXXXXXXXXXXXXXXX)

if SERVER then
	AddCSLuaFile("buttons/scp_actions.lua")
	AddCSLuaFile("buttons/item_containers.lua")
	AddCSLuaFile("buttons/terminals.lua")
	AddCSLuaFile("buttons/cameras.lua")
	AddCSLuaFile("buttons/others.lua")
end

if CLIENT then
	include("buttons/scp_actions.lua")
	include("buttons/item_containers.lua")
	include("buttons/terminals.lua")
	include("buttons/cameras.lua")
	include("buttons/others.lua")
else
	include("/buttons/scp_actions.lua")
	include("/buttons/item_containers.lua")
	include("/buttons/terminals.lua")
	include("/buttons/cameras.lua")
	include("/buttons/others.lua")
end

print("[Breach2] Shared/Buttons mapconfig loaded!")