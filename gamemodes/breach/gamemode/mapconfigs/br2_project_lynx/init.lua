
MAPCONFIG = {}

br2_914_on_map = false -- TODO CHANGE

include("server/functions_npcs.lua")
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
