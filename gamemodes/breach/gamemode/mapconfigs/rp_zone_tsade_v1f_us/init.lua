
MAPCONFIG = {}

br2_914_on_map = true

local last_ent = nil
local keys_todelete = {"OnFullyClosed", "OnFullyOpen"}
local function check_kv(ent, key, value)
	/*
	if ent:GetClass() == "prop_dynamic" then
		print(ent, key, value)
		if last_ent != ent then
			print("")
		end
		last_ent = ent
	end
	*/
    if ent:GetName() == "914_mechanism" then
        if table.HasValue(keys_todelete, key) then
            print("removing", ent, key, value)
            return ""
        end
	end
end
hook.Add("EntityKeyValue", "map_keyvalues_hook", check_kv)

include("server/functions_other.lua")
include("server/functions_scp914.lua")
include("server/functions_organise.lua")

include("server/corpses.lua")
include("server/keypads.lua")
include("server/item_gen_groups.lua")
include("server/item_spawns.lua")
include("server/positions.lua")

-- FOR DEBUG PURPOSES
AddCSLuaFile("server/item_spawns.lua")
AddCSLuaFile("server/positions.lua")
--

print("[Breach2] Serverside mapconfig loaded!")
