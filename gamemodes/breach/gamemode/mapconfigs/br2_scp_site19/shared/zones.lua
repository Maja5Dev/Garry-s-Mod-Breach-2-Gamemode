
MAPCONFIG.ZONES = {}

MAPCONFIG.SPECIAL_MUSIC_ZONES = {
	/*
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/914.ogg", length = 29.05, volume = 0.5}, -- 079
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/914.ogg", length = 29.05, volume = 0.7}, -- 914
	{pos1 = XXXXXXXXXXXXXXXXXXXXXXX, pos2 = XXXXXXXXXXXXXXXXXXXXXXX, sound = "map_sounds/m_server_room.wav", length = 3.44, volume = 0.5}, -- SERVERS
	*/
}


MAPCONFIG.ESCAPE_ZONES = {
	{"scpcbnukearea", Vector(-2965,12890,-2142), Vector(-2397,12751,-1943)},
}

--  name                       	First Position          	Second Position         	Color                music       fog     NVGmul		ambient       use general ambient
MAPCONFIG.ZONES.LCZ = {
	{
		name 						= "Light Containment Zone",
		pos1						= Vector(-4527,579,-9481),
		pos2						= Vector(1942,-3909,-8571),
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
		pos1						= Vector(2920,4300,-8518),
		pos2						= Vector(-4527,579,-10113),
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
		name 						= "Storage Area 4",
		pos1 						= Vector(-5463,-4087,-10827),
		pos2 						= Vector(-8248,-6867,-10502),
		--music 						= {sound = "map_sounds/Room3Storage.ogg", length = 16, volume = 0.5},
		--ambients 					= ambient_hcz,
		fog_enabled 				= false,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= -1,
		examine_info 				= "YYou are in the Storage Area 4",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "SCP-049 Containment Chamber",
		pos1 						= Vector(-4035,1356,-11253),
		pos2 						= Vector(-1922,2745,-10489),
		--music 						= {sound = "map_sounds/Room3Storage.ogg", length = 16, volume = 0.5},
		--ambients 					= ambient_hcz,
		fog_enabled 				= false,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in the SCP-049 Containment Chamber",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.ENTRANCEZONE = {
	{
		name 						= "Entrance Zone",
		pos1 						= Vector(-5079,8333,-9510),
		pos2 						= Vector(2920,4300,-8527),
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
		name 						= "SCP-860",
		pos1 						= Vector(5862,4693,-10590),
		pos2 						= Vector(13935,12772,-8893),
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


MAPCONFIG.ZONES.POCKETDIMENSION = {
	{
		name 						= "Pocket Dimension",
		pos1 						= Vector(-4669,-8543,-8109),
		pos2 						= Vector(11589,-11726,-10271),
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
		pos1 						= Vector(15381,15414,-399),
		pos2 						= Vector(-15399,-15403,-5369),
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
}

print("[Breach2] Shared/Zones mapconfig loaded!")