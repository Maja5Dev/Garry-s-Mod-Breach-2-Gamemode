
MAPCONFIG.ZONES = {}

MAPCONFIG.SPECIAL_MUSIC_ZONES = {
	/*
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/914.ogg", length = 29.05, volume = 0.5}, -- 079
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/914.ogg", length = 29.05, volume = 0.7}, -- 914
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/m_server_room.wav", length = 3.44, volume = 0.5}, -- SERVERS
	*/
}


MAPCONFIG.ESCAPE_ZONES = {
	--{pos1 = Vector(-6526,3309,-1615), pos2 = Vector(-7232,1660,-667)},
}

--  name                       	First Position          	Second Position         	Color                music       fog     NVGmul		ambient       use general ambient
MAPCONFIG.ZONES.LCZ = {
	{
		name 						= "Light Containment Zone",
		sub_areas = {
			{"LCZ Central Wing", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},
		},
		music 						= nil,
		ambients 					= ambient_lcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,255,0,50),
		sanity 						= 1,
		examine_info 				= "You are in the Light Containment Zone",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
}


MAPCONFIG.ZONES.HCZ = {
	{
		name 						= "Heavy Containment Zone",
		sub_areas = {
			{"HCZ North-East Wing - Sector B", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},

		},
		--music 						= {sound = "map_sounds/HeavyContainment.ogg", length = 47.2, volume = 0.5},
		music						= nil,
		ambients 					= ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= 0,
		examine_info 				= "You are in the Heavy Containment Zone",
		zone_temp 					= ZONE_TEMP_WARM,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "Warhead Control Room",
		pos1 						= XXXXXXXXXXXXXXXXXXXXXXX,
		pos2 						= XXXXXXXXXXXXXXXXXXXXXXX,
		--music 						= {sound = "map_sounds/Room049.ogg", length = 39.6, volume = 0.5},
		music 						= nil,
		ambients 					= ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= 0,
		examine_info 				= "You are in the Warhead Control Room",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "Storage Area 6",
		pos1 						= XXXXXXXXXXXXXXXXXXXXXXX,
		pos2 						= XXXXXXXXXXXXXXXXXXXXXXX,
		music 						= {sound = "map_sounds/Room3Storage.ogg", length = 16, volume = 0.5},
		ambients 					= ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in the Storage Area 6",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "SCP-1499",
		pos1 						= XXXXXXXXXXXXXXXXXXXXXXX,
		pos2 						= XXXXXXXXXXXXXXXXXXXXXXX,
		--music 						= {sound = "map_sounds/Room3Storage.ogg", length = 16, volume = 0.5},
		--ambients 					= ambient_hcz,
		fog_enabled 				= false,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in an unknown world",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	}
}

MAPCONFIG.ZONES.ENTRANCEZONE = {
	{
		name 						= "Entrance Zone",
		sub_areas = {
			{"XXXXXXXXXXXXXXXXXXXXXXX", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},
		},
		--music 						= {sound = "map_sounds/suspended.ogg", length = 81.60, volume = 1},
		music						= nil,
		ambients 					= ambient_ez,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(200,200,0,50),
		sanity 						= 1,
		examine_info 				= "You are in the Entrance Zone",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "SCP-860-1",
		pos1 = XXXXXXXXXXXXXXXXXXXXXXX,
		pos2 = XXXXXXXXXXXXXXXXXXXXXXX,
		--music 						= {sound = "map_sounds/suspended.ogg", length = 81.60, volume = 1},
		music						= nil,
		ambients 					= ambient_ez,
		fog_enabled 				= false,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= 1,
		examine_info 				= "You are inside SCP-860-1",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
}


MAPCONFIG.ZONES.POCKETDIMENSION = {
	{
		name 						= "Pocket Dimension",
		sub_areas = {
			{"XXXXXXXXXXXXXXXXXXXXXXX", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},
		},
		music 						= {sound = "map_sounds/PD.ogg", length = 27.03, volume = 1},
		ambients 					= {},
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(0,150,0,50),
		sanity 						= -1,
		examine_info 				= "You are in the Pocket Dimension",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.OUTSIDE = {
	{
		name 						= "Outside",
		sub_areas = {
			{"Outside", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},
			{"Outside", XXXXXXXXXXXXXXXXXXXXXXX, XXXXXXXXXXXXXXXXXXXXXXX},
		},
		--music 						= {sound = "map_sounds/m_ambience_night_battle.wav", length = 38.32, volume = 0.2},
		music						= nil,
		ambients 					= nil,
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= 1,
		examine_info 				= "You are outside of the facility",
		zone_temp 					= ZONE_TEMP_VERYCOLD,
		scp_106_can_tp 				= false,
	}
} 

MAPCONFIG.MINOR_ZONES = {
	{
		name 						= "SCP-008",
		pos1 						= XXXXXXXXXXXXXXXXXXXXXXX,
		pos2 						= XXXXXXXXXXXXXXXXXXXXXXX,
		music 						= nil,
		ambients 					= nil,
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(220,0,0,50),
		sanity 						= -1,
		examine_info 				= "You are in an unknown world",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= false,
	},
}

print("[Breach2] Shared/Zones mapconfig loaded!")