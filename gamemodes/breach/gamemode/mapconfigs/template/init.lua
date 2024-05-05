
MAPCONFIG = {}

function form_basic_item_info(class, amount)
	for k,v in pairs(BR2_DOCUMENTS) do
		if v.class == class then
			return {class = class, ammo = 0, name = v.name}
		end
	end
	for k,v in pairs(BR2_SPECIAL_ITEMS) do
		if v.class == class then
			return {class = class, ammo = 0, v.name}
		end
	end
	--print("TEST ITEM", class, weapons.Get(class), weapons.Get(class).PrintName)
	local wwep = weapons.Get(class)
	if wwep == nil then
		ErrorNoHalt("Couldn't find a weapon class: " .. class)
	end
	return {class = class, ammo = amount or 0, name = wwep.PrintName}
end

function Kanade_DebugPrint1()
	local ent = Entity(1):GetAllEyeTrace().Entity
	local ent_pos = ent:GetPos()
	local ent_ang = ent:GetAngles()
	print("{Vector("..ent_pos.x..", "..ent_pos.y..", "..ent_pos.z..")" .. ", " .. "Angle("..ent_ang.pitch..", "..ent_ang.yaw..", "..ent_ang.roll..")},")
end


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

print("[Breach2] Serverside mapconfig loaded!")
