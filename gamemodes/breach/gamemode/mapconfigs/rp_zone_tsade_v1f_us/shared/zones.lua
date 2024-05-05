
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
			{"LCZ - Class D Area", Vector(9195,-3097,-1118), Vector(6027,-1480,-385)},
			{"LCZ - SCP-914's Containment Chamber", Vector(9483,-1785,-1104), Vector(10442,-627,-479)},
			{"LCZ - SCP-173's Containment Chamber", Vector(7533,-699,-1017), Vector(6218,741,-515)},
			{"LCZ - Research Area", Vector(8159,-248,-1147), Vector(10391,511,-698)},
			{"LCZ - Research Area", Vector(11071,500,-1450), Vector(6920,4447,-419)},
			{"LCZ - Central Area", Vector(9490,-244,-1172), Vector(7538,-1478,-488)},
			{"LCZ - Central Area", Vector(7542,-702,-1094), Vector(5496,-1300,-681)},
			{"LCZ - Central Area", Vector(7647,-454,-1051), Vector(8096,309,-742)},
			{"LCZ - North Wing", Vector(5494,-489,-1138), Vector(4184,-1295,-648)},
			{"LCZ - North Wing", Vector(6081,-490,-1111), Vector(4363,921,-558)},
			{"LCZ - North Wing", Vector(5474,1733,-1011), Vector(4184,908,-558)},
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
		name 						= "HCZ - SCP-035's Containment Chamber",
		pos1 = Vector(2312,-537,-999),
		pos2 = Vector(2982,105,-814),
		--music 						= {sound = "map_sounds/HeavyContainment.ogg", length = 47.2, volume = 0.5},
		music						= nil,
		ambients 					= ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(255,0,0,50),
		sanity 						= -2,
		examine_info 				= "You are in the Heavy Containment Zone",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "Heavy Containment Zone",
		sub_areas = {
			{"HCZ - Research Area", Vector(5175,3346,-1100), Vector(2174,1744,-597)},
			{"HCZ - SCP-106's Containment Chamber", Vector(1714,1725,-1460), Vector(3093,143,-618)},
			{"HCZ - Central Area", Vector(3092,1750,-1278), Vector(4191,-1938,-638)},
			{"HCZ - Central Area", Vector(4348,-240,-1019), Vector(4172,528,-613)},
			{"HCZ - East Wing", Vector(3425,-1926,-1272), Vector(808,-3429,-546)},
			{"HCZ - East Wing", Vector(2523,-1534,-1135), Vector(1460,-1935,-589)},
			{"HCZ - North Wing", Vector(3012,122,-1299), Vector(1577,-1535,-749)},
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
		name 						= "Containment Area 6",
		pos1 						= Vector(2303,2383,-1554),
		pos2 						= Vector(4911,3386,-1231),
		music 						= {sound = "map_sounds/Room3Storage.ogg", length = 16, volume = 0.5},
		ambients 					= ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in the Containment Area 6",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.ENTRANCEZONE = {
	{
		name 						= "Entrance Zone",
		sub_areas = {
			{"Entrance Zone - East Wing", Vector(-641,-1574,-1110), Vector(809,-2527,-579)},
			{"Entrance Zone - Head Office", Vector(836,-836,-1080), Vector(1568,-308,-693)},
			{"Entrance Zone", Vector(842,-1579,-1161), Vector(-1804,930,-573)},
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
	}
}


MAPCONFIG.ZONES.POCKETDIMENSION = {
	{
		name 						= "Pocket Dimension",
		sub_areas = {
			{"Pocket Dimension", Vector(-1869,3102,-884), Vector(-3209,4431,-259)},
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
	}
}

MAPCONFIG.ZONES.OTHER = {
	{
		name 						= "Trenches",
		pos1 = Vector(-1743,994,-994),
		pos2 = Vector(-3232,3053,-456),
		ambients 					= {},
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(0,150,0,50),
		sanity 						= -1,
		examine_info 				= "You are in the trenches",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= true,
	}
}

MAPCONFIG.ZONES.OUTSIDE = {
	{
		name 						= "Outside",
		sub_areas = {
			{"Outside Area", Vector(3575,2671,1583), Vector(140,7715,2423)},
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
	},
	{
		name 						= "Outside Safe",
		sub_areas = {
			{"Underground", Vector(3575,2671,1099), Vector(-2515,7715,1577)},
			{"Entrance", Vector(73,6019,1583), Vector(-3802,4112,2019)},
		},
		--music 						= {sound = "map_sounds/m_ambience_night_battle.wav", length = 38.32, volume = 0.2},
		music						= nil,
		ambients 					= nil,
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= 1,
		examine_info 				= "You are outside of the facility",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= false,
	}
} 

MAPCONFIG.MINOR_ZONES = {
}

print("[Breach2] Shared/Zones mapconfig loaded!")