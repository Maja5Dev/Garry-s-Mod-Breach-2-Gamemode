
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
			{"LCZ - Class D Area", Vector(-3851,12213,-461), Vector(-6567,8947,378)},
			{"LCZ - SCP-914's Containment Chamber", Vector(-2688,9395,-141), Vector(-4054,8369,378)},
			{"LCZ - North-East Wing", Vector(-4623,5788,-351), Vector(-7770,4107,292)},
			{"LCZ - North-East Wing", Vector(-4630,4328,-164), Vector(-4089,4969,76)},
			{"LCZ - North-West Wing", Vector(-4376,7409,-257), Vector(-1211,4915,208)},
			{"LCZ - Central Area", Vector(-4376,5790,-137), Vector(-7833,8946,316)},
			{"LCZ - Central Area", Vector(-4376,7412,-244), Vector(-2904,8365,217)},
			{"LCZ - Bunker", Vector(-6499,6661,-138), Vector(-5718,5216,-677)}
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
	}
}


MAPCONFIG.ZONES.HCZ = {
}

MAPCONFIG.ZONES.ENTRANCEZONE = {
}

MAPCONFIG.ZONES.POCKETDIMENSION = {
}

MAPCONFIG.ZONES.OTHER = {
}

MAPCONFIG.ZONES.OUTSIDE = {
} 

MAPCONFIG.MINOR_ZONES = {
}

print("[Breach2] Shared/Zones mapconfig loaded!")