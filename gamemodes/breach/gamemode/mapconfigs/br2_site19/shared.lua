
BR_MAP_NAME = "br2_site19"

local mat_lock_opened = Material("breach2/scpu/lock_opened.png")
local mat_lock_closed = Material("breach2/scpu/lock_closed.png")
local mat_lock_picking = Material("breach2/scpu/lock_picking.png")

local mat_scpu_opened = Material("breach2/scpu/Handy.png")
local mat_scpu_closed = Material("breach2/scpu/Handy.png")
local mat_hiding_icon = Material("breach2/scpu/hiding_2_icon.png")

local scpu_lock_picking = {
	mat = mat_lock_picking,
	w = 66,
	h = 90
}

local scpu_lock_opened = {
	mat = mat_lock_opened,
	w = 66,
	h = 90
}

local scpu_lock_closed = {
	mat = mat_lock_closed,
	w = 66,
	h = 90
}

local scpu_opened = {
	mat = mat_scpu_opened,
	w = 1173 / 15,
	h = 1666 / 15
}

local scpu_closed = {
	mat = mat_scpu_closed,
	w = 1173 / 15,
	h = 1666 / 15
}

button_icons = {
	scpu = {
		opened = scpu_opened,
		closed = scpu_closed,
	},
	scpu_locks = {
		opened_func = function(num, button, tab)
			if lockpicking_timestamp > CurTime() and progress_circle_status != 0 then
				return scpu_lock_picking
			end
			if table.HasValue(br_crates_info, num) then
				return scpu_opened
			end
		end,
		closed_func = function(num, button, tab)
			if lockpicking_timestamp > CurTime() and progress_circle_status != 0 then
				return scpu_lock_picking
			end
			if table.HasValue(br_crates_info, num) then
				return scpu_lock_opened
			end
		end,
		opened = scpu_lock_closed,
		closed = scpu_lock_closed,
	},
	scu_hiding = {
		opened = {
			mat = mat_hiding_icon,
			w = 64,
			h = 64
		},
		closed = {
			mat = mat_hiding_icon,
			w = 64,
			h = 64
		}
	},
}

local ambient_general = {
	"breach2/ambient/general/Ambient1.ogg",
	"breach2/ambient/general/Ambient2.ogg",
	"breach2/ambient/general/Ambient3.ogg",
	"breach2/ambient/general/Ambient4.ogg",
	"breach2/ambient/general/Ambient5.ogg",
	"breach2/ambient/general/Ambient6.ogg",
	"breach2/ambient/general/Ambient7.ogg",
	"breach2/ambient/general/Ambient8.ogg",
	"breach2/ambient/general/Ambient9.ogg",
	"breach2/ambient/general/Ambient10.ogg",
	"breach2/ambient/general/Ambient11.ogg",
	"breach2/ambient/general/Ambient12.ogg",
	"breach2/ambient/general/Ambient13.ogg",
	"breach2/ambient/general/Ambient14.ogg",
	"breach2/ambient/general/Ambient15.ogg",
}

local ambient_lcz = {
	"breach2/ambient/zone1/Ambient1.ogg",
	"breach2/ambient/zone1/Ambient2.ogg",
	"breach2/ambient/zone1/Ambient3.ogg",
	"breach2/ambient/zone1/Ambient4.ogg",
	"breach2/ambient/zone1/Ambient5.ogg",
	"breach2/ambient/zone1/Ambient6.ogg",
	"breach2/ambient/zone1/Ambient7.ogg",
	"breach2/ambient/zone1/Ambient8.ogg",
}

local ambient_hcz = {
	"breach2/ambient/zone2/Ambient1.ogg",
	"breach2/ambient/zone2/Ambient2.ogg",
	"breach2/ambient/zone2/Ambient3.ogg",
	"breach2/ambient/zone2/Ambient4.ogg",
	"breach2/ambient/zone2/Ambient5.ogg",
	"breach2/ambient/zone2/Ambient6.ogg",
	"breach2/ambient/zone2/Ambient7.ogg",
	"breach2/ambient/zone2/Ambient8.ogg",
	"breach2/ambient/zone2/Ambient9.ogg",
	"breach2/ambient/zone2/Ambient10.ogg",
	"breach2/ambient/zone2/Ambient11.ogg",
}

local ambient_ez = {
	"breach2/ambient/zone3/Ambient1.ogg",
	"breach2/ambient/zone3/Ambient2.ogg",
	"breach2/ambient/zone3/Ambient3.ogg",
	"breach2/ambient/zone3/Ambient4.ogg",
	"breach2/ambient/zone3/Ambient5.ogg",
	"breach2/ambient/zone3/Ambient6.ogg",
	"breach2/ambient/zone3/Ambient7.ogg",
	"breach2/ambient/zone3/Ambient8.ogg",
	"breach2/ambient/zone3/Ambient9.ogg",
	"breach2/ambient/zone3/Ambient10.ogg",
	"breach2/ambient/zone3/Ambient11.ogg",
	"breach2/ambient/zone3/Ambient12.ogg",
}

MAPCONFIG.EnableGamemodeMusic = true
MAPCONFIG.EnableAmbientSounds = true
MAPCONFIG.GeneralAmbientSounds = ambient_general
MAPCONFIG.CommotionSounds = {
	"breach2/intro/Commotion/Commotion1.ogg",
	"breach2/intro/Commotion/Commotion2.ogg",
	"breach2/intro/Commotion/Commotion3.ogg",
	"breach2/intro/Commotion/Commotion4.ogg",
	"breach2/intro/Commotion/Commotion5.ogg",
	"breach2/intro/Commotion/Commotion6.ogg",
	"breach2/intro/Commotion/Commotion7.ogg",
	"breach2/intro/Commotion/Commotion8.ogg",
	"breach2/intro/Commotion/Commotion9.ogg",
	"breach2/intro/Commotion/Commotion10.ogg",
	"breach2/intro/Commotion/Commotion11.mp3",
	"breach2/intro/Commotion/Commotion12.ogg",
	"breach2/intro/Commotion/Commotion13.mp3",
	"breach2/intro/Commotion/Commotion14.mp3",
	"breach2/intro/Commotion/Commotion15.mp3",
	"breach2/intro/Commotion/Commotion16.ogg",
	"breach2/intro/Commotion/Commotion17.ogg",
	"breach2/intro/Commotion/Commotion18.ogg",
	"breach2/intro/Commotion/Commotion19.ogg",
	"breach2/intro/Commotion/Commotion20.ogg",
	"breach2/intro/Commotion/Commotion21.ogg",
	"breach2/intro/Commotion/Commotion22.mp3",
	"breach2/intro/Commotion/Commotion23.ogg",
	"breach2/intro/Bang2.ogg",
	"breach2/intro/Bang3.ogg",
}

/*
MAPCONFIG.FirstSounds = {
	{"breach2/alarm/Alarm2_1.ogg", 6},
	{"breach2/alarm/Alarm2_2.ogg", 5},
	{"breach2/alarm/Alarm2_3.ogg", 7},
	{"breach2/alarm/Alarm2_4.ogg", 10},
	{"breach2/alarm/Alarm2_5.ogg", 6},
	{"breach2/alarm/Alarm2_6.ogg", 8},
	{"breach2/alarm/Alarm2_7.ogg", 7},
	{"breach2/alarm/Alarm2_8.ogg", 4},
	{"breach2/alarm/Alarm2_9.ogg", 4},
	{"breach2/alarm/Alarm2_10.ogg", 15}
}
*/

MAPCONFIG.FirstSounds = {
	{"breach2/alarm/breach_alarm.ogg", 72},
}
MAPCONFIG.FirstSoundsLength = 72 -- length of all of FirstSounds in seconds


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
