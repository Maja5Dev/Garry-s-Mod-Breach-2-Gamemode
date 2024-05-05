
MAPCONFIG.ZONES = {}

MAPCONFIG.SPECIAL_MUSIC_ZONES = {
	/*
	{pos1 = Vector(6625,1346,-11249), pos2 = Vector(5814,1820,-10931), sound = "map_sounds/914.ogg", length = 29.05, volume = 0.5}, -- 079
	{pos1 = Vector(10347,-3041,-11060), pos2 = Vector(11249,-4064,-10628), sound = "map_sounds/914.ogg", length = 29.05, volume = 0.7}, -- 914
	{pos1 = Vector(1280,-4224,-11206), pos2 = Vector(-86,-5927,-10828), sound = "map_sounds/m_server_room.wav", length = 3.44, volume = 0.5}, -- SERVERS
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
			{"LCZ Central Wing", Vector(8279,-2995,-46), Vector(8648,-3370,159)},
			{"LCZ Central Wing", Vector(7734,-4901,-282), Vector(8421,-5038,150)},
			{"LCZ North Wing - Office Complex E", Vector(9812,-1740,-21), Vector(9961,-1469,141)},
			{"LCZ West Wing - Administrative Area A", Vector(7891,-1803,-39), Vector(7707,-1181,145)},



			{"LCZ South Wing - Office Complex A", Vector(4096,-2496,-85), Vector(6030,-3475,422)},
			{"LCZ South Wing - Office Complex B", Vector(4662,-2643,-66), Vector(6567,-1562,256)},
			{"LCZ West Wing - Containment Area", Vector(6600,-1508,-168), Vector(7162,-3406,457)},
			{"LCZ West Wing - Administrative Area A", Vector(7148,-1229,-181), Vector(7812,-3224,379)},
			{"LCZ Soth-East Wing - SCP-173's Chamber", Vector(6089,-2955,63), Vector(6503,-3461,385)},
			{"LCZ Soth-East Wing - Office Complex C", Vector(5855,-3475,-229), Vector(7195,-4955,524)},
			{"LCZ Soth-East Wing - Prison Area", Vector(5872,-4964,114), Vector(8343,-6596,466)},
			{"LCZ North Wing - SCP-372's Chamber", Vector(8358,-6586,-64), Vector(9238,-5090,465)},
			--{"LCZ North Wing - SCP-914's Chamber", Vector(9750,-4444,-77), Vector(9093,-5131,353)},
			{"LCZ North Wing - Office Complex D", Vector(8709,-4445,-212), Vector(10440,-3173,337)},
			{"LCZ North Wing - Storage Area A", Vector(9310,-1638,-62), Vector(10440,-3173,337)},
			{"LCZ North Wing - Office Complex E", Vector(8522,-1597,-134), Vector(10593,-533,352)},
			{"LCZ West Wing - Administrative Area B", Vector(7815,-1501,-206), Vector(9287,-3171,449)},
			{"LCZ Central Wing", Vector(8698,-3176,-315), Vector(7202,-4973,507)},
			--{"LCZ Central Wing", Vector(9087,-5087,-78), Vector(8700,-4446,345)},
			{"LCZ North Wing - SCP-914's Chamber", Vector(8703,-4446,-231), Vector(9793,-5095,481)},
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
			{"HCZ North-East Wing - Sector B", Vector(7900,-1506,-10), Vector(8433,-1121,286)},



			{"HCZ North-East Wing - Sector A", Vector(7130,-1510,-479), Vector(4654,132,336)},
			{"HCZ North-East Wing - SCP-895's Chamber", Vector(5597,131,-583), Vector(5073,1204,222)},
			{"HCZ North-East Wing - Sector B", Vector(8448,-489,-48), Vector(9933,-194,303)},
			{"HCZ North-East Wing - Sector B", Vector(8447,-1226,-124), Vector(7154,133,388)},
			{"HCZ East Wing - Sector C", Vector(3359,980,-42), Vector(4644,-2489,261)},
			{"HCZ North-West Wing - Sector D", Vector(8685,132,-147), Vector(6170,1573,350)},
			{"HCZ North-West Wing - Sector E", Vector(8819,1569,-165), Vector(6173,3690,366)},
			{"HCZ North-West Wing - Sector F", Vector(6175,3319,-205), Vector(4898,1205,354)},
			{"HCZ North-West Wing - Sector F", Vector(2480,-6520,-2433), Vector(1076,-6760,-2186)},
			{"HCZ North-West Wing - Sector G", Vector(6168,3321,-218), Vector(4475,3824,158)},
			{"HCZ Central Wing - Sector H", Vector(4899,982,-134), Vector(3210,3321,474)},
			{"HCZ West Wing - Sector I", Vector(4465,3321,-186), Vector(3199,5603,150)},
			{"HCZ West Wing - Sector J", Vector(3958,5616,-119), Vector(79,6468,254)},
			{"HCZ South-East Wing - Sector K", Vector(3198,656,-143), Vector(1215,1926,426)},
			{"HCZ South Wing - Sector L", Vector(1788,2065,-522), Vector(3201,5316,431)},

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
		pos1 						= Vector(-760,-6501,-2634),
		pos2 						= Vector(99,-5850,-2219),
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
		pos1 						= Vector(-939,-3654,-1391),
		pos2 						= Vector(1715,-5824,-1004),
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
		pos1 						= Vector(1081,-11412,-3459),
		pos2 						= Vector(-4133,-15597,-546),
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
			{"EZ North-East Wing - Area 3", Vector(1194,760,-75), Vector(-137,1913,288)},
			{"EZ North Wing - Area 1", Vector(1779,1926,-150), Vector(511,5599,235)},
			{"EZ North Wing - Area 2", Vector(506,1920,-146), Vector(-129,3544,348)},
			{"EZ West Wing - Area 4", Vector(-480,6703,-190), Vector(-2619,5394,445)},
			{"EZ West Wing - Area 5", Vector(505,5395,-186), Vector(-2044,3564,128)},
			{"EZ South-East Wing - Area 8", Vector(-4032,1366,-88), Vector(-2058,3319,438)},
			{"EZ South-West Wing - Area 9", Vector(-6404,3324,-2169), Vector(-2056,5369,386)},
			{"EZ East Wing - Area 7", Vector(-2043,1322,-258), Vector(-136,2448,307)},
			{"EZ Central Wing - Area 6", Vector(-137,3555,-217), Vector(-2035,2484,372)},
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
		pos1 = Vector(9813,-10539,-3528),
		pos2 = Vector(15392,-15590,-3049),
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
			{"Pocket Dimension", Vector(7801,-15655,-16082), Vector(4415,-11775,-14599)},
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
			{"Outside", Vector(3701,15362,985), Vector(-13498,-1496,3018)},
			{"Outside", Vector(-15054,3701,-15758), Vector(-14430,-14959,-14137)},
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
		pos1 						= Vector(6118,3935,-11108),
		pos2 						= Vector(5548,3303,-10787),
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