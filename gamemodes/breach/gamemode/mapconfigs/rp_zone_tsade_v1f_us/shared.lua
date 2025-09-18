
BR_MAP_NAME = "rp_zone_tsade_v1f_us"

MAPCONFIG.EnableGamemodeMusic = true
MAPCONFIG.EnableAmbientSounds = true
MAPCONFIG.GeneralAmbientSounds = BR_DEFAULT_AMBIENT_GENERAL
MAPCONFIG.CommotionSounds = BR_DEFAULT_COMMOTION_SOUNDS

MAPCONFIG.FirstSounds = {
	{"breach2/alarm/breach_alarm.ogg", 72},
}
MAPCONFIG.FirstSoundsLength = 72 -- length of all of FirstSounds in seconds

/*
local evac_shelter_delay = 0

local special_terminal_settings = {
	hcz_storage_room = {
		class = "1",
		name = "Open/Close Storage Room 2b",
		type = "button",
		button_size = 720,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_hcz_storage_room"]:Use(pl, pl, 3, 1)
			end
		}
	},
	ez_servers = {
		class = "5",
		name = "Restart the servers",
		type = "button",
		button_size = 640,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_ez_server_room"]:Use(pl, pl, 3, 1)
			end
		}
	},
	evac_shelter = {
		class = "6",
		name = "Send the elevator",
		type = "button",
		button_size = 600,
		server = {
			func = function(pl)
				if evac_shelter_delay < CurTime() then
					BR2_SPECIAL_BUTTONS["spec_button_ez_evac_shelter_1"]:Use(pl, pl, 3, 1)
					evac_shelter_delay = CurTime() + 12.5
				end
			end
		}
	},
}

for i=1, 4 do
	special_terminal_settings["hcz_generator_"..i] = {
		class = tostring(i + 1),
		name = "Restart Generator "..i.."",
		type = "button",
		button_size = 600,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_generator_"..i]:Use(pl, pl, 1, 1)
			end
		}
	}
end
*/

if SERVER then
	AddCSLuaFile("shared/buttons.lua")
	AddCSLuaFile("shared/zones.lua")
	AddCSLuaFile("shared/positions.lua")
end

if CLIENT then
	include("shared/buttons.lua")
	include("shared/zones.lua")
	include("shared/positions.lua")
else
	include("/shared/buttons.lua")
	include("/shared/zones.lua")
	include("/shared/positions.lua")
end

print("[Breach2] Shared mapconfig loaded!")
