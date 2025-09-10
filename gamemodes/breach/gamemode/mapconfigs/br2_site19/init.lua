
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


DOOR_STATE_OPENED = 0
DOOR_STATE_CLOSED = 1
DOOR_STATE_OPENING = 2
DOOR_STATE_CLOSING = 3

DOOR_ISTATE_OPENED = "1"
DOOR_ISTATE_CLOSED = "0"
DOOR_ISTATE_DENIED = "2"

local states = {
	[DOOR_STATE_OPENED] = DOOR_ISTATE_OPENED,
	[DOOR_STATE_CLOSED] = DOOR_ISTATE_CLOSED,
	[DOOR_STATE_OPENING] = DOOR_ISTATE_OPENED,
	[DOOR_STATE_CLOSING] = DOOR_ISTATE_CLOSED
}

local nt = 0
local function map_tick()
	local ct = CurTime()
	if nt < ct then
		nt = ct + 0.25

		for k,v in pairs(MAP_AAB) do
			if istable(v.triggers) then
				for k2,v2 in pairs(v.triggers) do
					if IsValid(v2[1]) and isnumber(v2[1].active) and v2[1].active > CurTime() then
						local state = v2[2]:GetSaveTable().m_toggle_state
						if state == 1 then
							v2[1]:SetKeyValue("skin", "0")
						elseif state == 0 then
							v2[1]:SetKeyValue("skin", "1")
						end
					end
				end
			end
		end
	end
end
hook.Add("Tick", "map_tick_hook", map_tick)


include("server/functions_npcs.lua")
include("server/functions_other.lua")
include("server/functions_scp914.lua")
include("server/functions_organise.lua")

include("server/corpses.lua")
include("server/keypads.lua")
include("server/item_gen_groups.lua")
include("server/item_spawns.lua")
include("server/positions.lua")

print("[Breach2] Serverside mapconfig loaded!")
